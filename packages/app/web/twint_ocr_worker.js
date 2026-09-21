self.importScripts("twint_amount_ocr.js");

self.onmessage = async function (event) {
  try {
    const image = await createImageBitmap(new Blob([event.data]));
    try {
      let text = null;
      if (typeof TextDetector !== "undefined") {
        try {
          const blocks = await new TextDetector().detect(image);
          text = blocks.map((block) => block.rawValue).join("\n");
        } catch (_) {
          /* Use the local fallback when native OCR fails. */
        }
      }
      let amount = null;
      const hasAmount =
        /(?:CHF|Fr\.?)\s*\d+(?:[.,]\d{1,2})?|\d+(?:[.,]\d{1,2})?\s*(?:CHF|Fr\.?)/i.test(
          text || "",
        );
      if (!hasAmount) {
        try {
          amount = self.recognizeTwintAmount(image);
        } catch (_) {
          /* Preserve native text on browsers without canvas support. */
        }
      }
      self.postMessage({
        text: [amount, text].filter(Boolean).join("\n") || null,
      });
    } finally {
      image.close();
    }
  } catch (_) {
    self.postMessage({ text: null });
  }
};
