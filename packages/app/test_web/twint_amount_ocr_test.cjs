// Run with node; install playwright separately or set PLAYWRIGHT_MODULE.
// Optional TWINT_IMPORT_SCREENSHOT checks the original CHF 9.90 screenshot.
const assert = require("node:assert/strict");
const fs = require("node:fs/promises");
const http = require("node:http");
const path = require("node:path");
const { chromium } = require(process.env.PLAYWRIGHT_MODULE || "playwright");

(async () => {
  const server = http.createServer(async (req, res) => {
    try {
      // Match the isolated production page and its worker responses.
      res.setHeader("Cross-Origin-Embedder-Policy", "require-corp");
      if (req.url === "/") {
        res.setHeader("Cross-Origin-Opener-Policy", "same-origin");
        res.setHeader("Content-Type", "text/html");
        return res.end('<script src="twint_ocr.js"></script>');
      }
      const filename =
        req.url === "/screenshot.png"
          ? process.env.TWINT_IMPORT_SCREENSHOT
          : /^\/twint_(ocr|ocr_worker|amount_ocr)\.js$/.test(req.url)
            ? path.join(__dirname, "../web", req.url.slice(1))
            : null;
      if (!filename) {
        res.writeHead(404);
        return res.end();
      }
      res.setHeader(
        "Content-Type",
        req.url.endsWith(".png") ? "image/png" : "text/javascript",
      );
      res.end(await fs.readFile(filename));
    } catch (error) {
      res.writeHead(500);
      res.end(error.message);
    }
  });
  await new Promise((resolve) => server.listen(0, "127.0.0.1", resolve));
  const browser = await chromium.launch({
    headless: true,
    executablePath: process.env.CHROME_BIN || "/usr/bin/google-chrome",
  });
  try {
    const page = await browser.newPage();
    await page.goto(`http://127.0.0.1:${server.address().port}/`);
    assert.equal(await page.evaluate(() => crossOriginIsolated), true);
    const readText = (options) =>
      page.evaluate(async (options) => {
        const canvas = document.createElement("canvas");
        canvas.width = 800;
        canvas.height = 300;
        const ctx = canvas.getContext("2d");
        ctx.fillStyle = options.dark ? "#151515" : "#ffffff";
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        ctx.fillStyle = options.dark ? "#ffffff" : "#111111";
        ctx.font = `${options.weight || 700} ${options.size || 40}px ${options.font || "Arial"}`;
        ctx.fillText(options.text, 80, 110);
        if (options.second) ctx.fillText(options.second, 80, 210);
        const blob = await new Promise((resolve) => canvas.toBlob(resolve));
        return window.bitblikOcrImage(new Uint8Array(await blob.arrayBuffer()));
      }, options);
    if (process.env.TWINT_IMPORT_SCREENSHOT) {
      for (const scale of [1, 0.75, 0.5]) {
        const started = Date.now();
        const result = await page.evaluate(async (scale) => {
          const bytes = new Uint8Array(
            await (await fetch("/screenshot.png")).arrayBuffer(),
          );
          if (scale === 1) return window.bitblikOcrImage(bytes);
          const bitmap = await createImageBitmap(new Blob([bytes]));
          const canvas = document.createElement("canvas");
          canvas.width = Math.round(bitmap.width * scale);
          canvas.height = Math.round(bitmap.height * scale);
          canvas
            .getContext("2d")
            .drawImage(bitmap, 0, 0, canvas.width, canvas.height);
          bitmap.close();
          const blob = await new Promise((resolve) =>
            canvas.toBlob(resolve, "image/jpeg", 0.85),
          );
          return window.bitblikOcrImage(
            new Uint8Array(await blob.arrayBuffer()),
          );
        }, scale);
        assert.equal(result, "CHF 9.90", "original screenshot");
        console.log(
          "PASS original screenshot:",
          result,
          "scale:",
          scale,
          "ms:",
          Date.now() - started,
        );
      }
    }
    for (const options of [
      { text: "CHF 9.90" },
      { text: "CHF 17.50", dark: true },
      { text: "CHF 42.80", size: 24, weight: 400 },
      { text: "125.60 CHF", font: "Verdana" },
      { text: "CHF 8,25", weight: 400 },
      { text: "CHF 99", size: 32 },
      { text: "CHF 206.34" },
      { text: "CHF 0.10" },
      { text: "CHF 1234.56" },
      { text: "CHF 7.00", size: 18, weight: 400 },
    ]) {
      const result = await readText(options);
      const amount = Number(
        options.text.match(/[\d.,]+/)[0].replace(",", "."),
      ).toFixed(2);
      assert.equal(result, `CHF ${amount}`, JSON.stringify(options));
      console.log("PASS", JSON.stringify(options), result);
    }
    for (const options of [
      { text: "54576" },
      { text: "Order 12345 Total" },
      { text: "" },
      { text: "CHF 9.90", second: "CHF 12.50" },
      { text: "1.234.50 CHF" },
      { text: "CHF 1.234.50" },
    ]) {
      assert.equal(await readText(options), null, JSON.stringify(options));
      console.log("PASS no unambiguous amount:", options.text);
    }
  } finally {
    await browser.close();
    server.close();
  }
})().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
