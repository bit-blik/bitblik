window.bitblikOcrImage = function (bytes) {
  return new Promise(function (resolve) {
    if (!window.Worker) {
      resolve(null);
      return;
    }

    let worker;
    let timer;
    const finish = function (text) {
      clearTimeout(timer);
      if (worker) worker.terminate();
      resolve(text || null);
    };
    try {
      worker = new Worker(new URL("twint_ocr_worker.js", document.baseURI));
    } catch (_) {
      finish(null);
      return;
    }
    timer = setTimeout(function () {
      finish(null);
    }, 10000);
    worker.onmessage = function (event) {
      finish(event.data.text);
    };
    worker.onerror = function () {
      finish(null);
    };
    worker.postMessage(bytes);
  });
};
