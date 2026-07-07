// Web-only OCR bridge for the TWINT amount scanner.
//
// mobile_scanner on web renders the camera into a single <video> element but
// never exposes frame pixels (no `returnImage` support) and google_mlkit is
// native-only. So on web we snapshot that <video> ourselves and run the
// amount OCR with a locally-bundled tesseract.js. See
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
      // Amount text is "CHF 12.34" / "Fr. 12.34"; restrict the alphabet to the
      // characters that can appear so digits are read more reliably.
      return w.setParameters({
        tessedit_char_whitelist: '0123456789.,CHFr ',
      }).then(function () {
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

  // Kick off worker + language load ahead of time so the first real snapshot
  // is fast. Safe to call repeatedly.
  window.twintOcrPreload = function () {
    _ensureWorker().catch(function () {});
  };

  // Grab the current camera frame and return recognized text (or '' on any
  // failure). Never rejects. OCR cost scales with pixel count, so crop to the
  // centre band (where the amount text sits) and downscale before recognizing
  // — this keeps a single pass fast even on phones.
  window.twintOcrSnapshot = function () {
    var video = document.querySelector('video');
    if (!video || !video.videoWidth || !video.videoHeight) {
      return Promise.resolve('');
    }
    var vw = video.videoWidth;
    var vh = video.videoHeight;
    // Crop the middle 90% width / 60% height: drops the noisy edges and roughly
    // halves the area tesseract has to scan.
    var cropW = Math.round(vw * 0.9);
    var cropH = Math.round(vh * 0.6);
    var sx = Math.round((vw - cropW) / 2);
    var sy = Math.round((vh - cropH) / 2);
    // Cap the OCR width for speed; text stays legible at ~720px.
    var maxWidth = 720;
    var scale = cropW > maxWidth ? maxWidth / cropW : 1;
    var w = Math.round(cropW * scale);
    var h = Math.round(cropH * scale);
    var canvas = document.createElement('canvas');
    canvas.width = w;
    canvas.height = h;
    var ctx = canvas.getContext('2d');
    ctx.drawImage(video, sx, sy, cropW, cropH, 0, 0, w, h);
    return _ensureWorker()
      .then(function (worker) {
        return worker.recognize(canvas);
      })
      .then(function (result) {
        return (result && result.data && result.data.text) || '';
      })
      .catch(function () {
        return '';
      });
  };
})();
