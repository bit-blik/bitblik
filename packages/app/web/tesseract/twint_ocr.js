// Web-only OCR bridge for the TWINT amount scanner.
//
// mobile_scanner on web renders the camera into a <video> element but never
// exposes frame pixels (no `returnImage` support) and google_mlkit is
// native-only. So on web we snapshot that <video> ourselves and run the amount
// OCR with a locally-bundled tesseract.js. See
// lib/src/screens/maker_flow/twint_code_scanner_screen.dart.
(function () {
  var _worker = null;
  var _workerPromise = null;

  function _assetUrl(name) {
    // Resolve against <base href> so it works when the app is served from a
    // sub-path, not just the domain root.
    return new URL('tesseract/' + name, document.baseURI).href;
  }

  function _ensureWorker() {
    if (_worker) return Promise.resolve(_worker);
    if (_workerPromise) return _workerPromise;
    if (typeof Tesseract === 'undefined') {
      return Promise.reject(new Error('tesseract.js not loaded'));
    }
    _workerPromise = Tesseract.createWorker('eng', 1, {
      workerPath: _assetUrl('worker.min.js'),
      corePath: _assetUrl(''),
      langPath: _assetUrl(''),
      gzip: true,
    }).then(function (w) {
      // PSM 11 = sparse text: find text anywhere in a natural scene (a photo of
      // a payment screen), rather than assuming a clean document page.
      return w.setParameters({ tessedit_pageseg_mode: '11' }).then(function () {
        _worker = w;
        return w;
      });
    });
    _workerPromise.catch(function () {
      // Allow a later retry if init failed (e.g. transient asset load error).
      _workerPromise = null;
    });
    return _workerPromise;
  }

  // Find the live camera <video>. Flutter web can place platform views inside
  // shadow roots, so a plain document.querySelector('video') may miss it — walk
  // shadow roots too and prefer an element that actually has decoded frames.
  function _findVideo() {
    function search(root) {
      var vids = root.querySelectorAll ? root.querySelectorAll('video') : [];
      for (var i = 0; i < vids.length; i++) {
        if (vids[i].videoWidth > 0 && vids[i].videoHeight > 0) return vids[i];
      }
      var els = root.querySelectorAll ? root.querySelectorAll('*') : [];
      for (var j = 0; j < els.length; j++) {
        if (els[j].shadowRoot) {
          var found = search(els[j].shadowRoot);
          if (found) return found;
        }
      }
      return null;
    }
    return search(document);
  }

  // Kick off worker + language load ahead of time so the first real snapshot
  // is fast. Safe to call repeatedly.
  window.twintOcrPreload = function () {
    _ensureWorker().catch(function () {});
  };

  // Grab the current camera frame and return recognized text. Never rejects.
  // On capture problems returns a marker the Dart side can surface for
  // diagnostics: '__NOVIDEO__' or '__OCRERR__:<message>'.
  window.twintOcrSnapshot = function () {
    var video = _findVideo();
    if (!video) return Promise.resolve('__NOVIDEO__');
    var vw = video.videoWidth;
    var vh = video.videoHeight;
    // OCR the full frame (not a crop) — we do not know where the amount sits on
    // the payer's screen. Keep it fairly high-res so small digits survive: a
    // photo of a screen loses a lot of detail, and over-downscaling made the
    // amount unreadable.
    var maxWidth = 1280;
    var scale = vw > maxWidth ? maxWidth / vw : 1;
    var w = Math.round(vw * scale);
    var h = Math.round(vh * scale);
    var canvas = document.createElement('canvas');
    canvas.width = w;
    canvas.height = h;
    var ctx = canvas.getContext('2d');
    ctx.drawImage(video, 0, 0, w, h);
    // Grayscale + contrast stretch: a camera shot of a screen is noisy and
    // low-contrast; this makes the text edges cleaner for tesseract.
    try {
      var img = ctx.getImageData(0, 0, w, h);
      var d = img.data;
      for (var i = 0; i < d.length; i += 4) {
        var g = 0.299 * d[i] + 0.587 * d[i + 1] + 0.114 * d[i + 2];
        g = (g - 128) * 1.6 + 128;
        g = g < 0 ? 0 : g > 255 ? 255 : g;
        d[i] = d[i + 1] = d[i + 2] = g;
      }
      ctx.putImageData(img, 0, 0);
    } catch (_) {
      // getImageData can throw on tainted canvas; fall back to the raw frame.
    }
    return _ensureWorker()
      .then(function (worker) {
        return worker.recognize(canvas);
      })
      .then(function (result) {
        var text = (result && result.data && result.data.text) || '';
        // Prefix the source frame size (before scaling) so the Dart side can
        // surface it for diagnostics: low native resolution is the usual reason
        // small amount digits are unreadable. Delimiter is .
        return vw + 'x' + vh + '' + text;
      })
      .catch(function (e) {
        return '__OCRERR__:' + (e && e.message ? e.message : e);
      });
  };
})();
