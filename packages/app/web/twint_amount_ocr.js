// Small, model-free fallback for printed CHF amounts in payment screenshots.
// Templates come from browser fonts; no models, network requests or uploads.
(() => {
  const W = 20;
  const H = 28;
  let templates;

  function components(mask, width, height) {
    const seen = new Uint8Array(mask.length);
    const queue = new Int32Array(mask.length);
    const result = [];
    for (let start = 0; start < mask.length; start++) {
      if (!mask[start] || seen[start]) continue;
      let head = 0,
        tail = 1;
      queue[0] = start;
      seen[start] = 1;
      let x0 = width,
        y0 = height,
        x1 = 0,
        y1 = 0;
      while (head < tail) {
        const p = queue[head++];
        const x = p % width,
          y = Math.floor(p / width);
        x0 = Math.min(x0, x);
        x1 = Math.max(x1, x);
        y0 = Math.min(y0, y);
        y1 = Math.max(y1, y);
        for (let dy = -1; dy <= 1; dy++) {
          for (let dx = -1; dx <= 1; dx++) {
            const nx = x + dx,
              ny = y + dy;
            if (nx < 0 || nx >= width || ny < 0 || ny >= height) continue;
            const next = ny * width + nx;
            if (mask[next] && !seen[next]) {
              seen[next] = 1;
              queue[tail++] = next;
            }
          }
        }
      }
      result.push({
        x0,
        y0,
        x1,
        y1,
        w: x1 - x0 + 1,
        h: y1 - y0 + 1,
        area: tail,
      });
    }
    return result;
  }

  function sample(mask, stride, box) {
    const pixels = new Float32Array(W * H);
    for (let y = 0; y < H; y++) {
      for (let x = 0; x < W; x++) {
        // Supersample to retain thin strokes and suppress raster-size noise.
        let value = 0;
        for (let sy = 0; sy < 3; sy++) {
          for (let sx = 0; sx < 3; sx++) {
            const px =
              box.x0 +
              Math.min(
                box.w - 1,
                Math.floor(((x + (sx + 0.5) / 3) * box.w) / W),
              );
            const py =
              box.y0 +
              Math.min(
                box.h - 1,
                Math.floor(((y + (sy + 0.5) / 3) * box.h) / H),
              );
            value += mask[py * stride + px];
          }
        }
        pixels[y * W + x] = value / 9;
      }
    }
    return pixels;
  }

  function makeTemplates() {
    const canvas = new OffscreenCanvas(100, 100);
    const ctx = canvas.getContext("2d", { willReadFrequently: true });
    const result = [];
    for (const family of ["Arial", "Verdana", "sans-serif"]) {
      for (const weight of [400, 700, 900]) {
        for (const size of [24, 60]) {
          for (const char of "0123456789CHFfr") {
            ctx.fillStyle = "white";
            ctx.fillRect(0, 0, 100, 100);
            ctx.fillStyle = "black";
            ctx.font = `${weight} ${size}px ${family}`;
            ctx.fillText(char, 10, 75);
            const rgba = ctx.getImageData(0, 0, 100, 100).data;
            const mask = new Uint8Array(10000);
            for (let i = 0; i < mask.length; i++)
              mask[i] = rgba[4 * i] < 160 ? 1 : 0;
            const box = components(mask, 100, 100).sort(
              (a, b) => b.area - a.area,
            )[0];
            if (box)
              result.push({
                char,
                ratio: box.w / box.h,
                pixels: sample(mask, 100, box),
              });
          }
        }
      }
    }
    return result;
  }

  function classify(mask, width, box) {
    const pixels = sample(mask, width, box);
    const scores = new Map();
    for (const template of templates) {
      let error = 0;
      for (let i = 0; i < pixels.length; i++)
        error += Math.abs(pixels[i] - template.pixels[i]);
      error =
        error / pixels.length +
        0.15 * Math.abs(Math.log(box.w / box.h / template.ratio));
      scores.set(
        template.char,
        Math.min(scores.get(template.char) ?? Infinity, error),
      );
    }
    const ranked = [...scores].sort((a, b) => a[1] - b[1]);
    const [char, error] = ranked[0];
    return error < 0.22 && ranked[1][1] - error > 0.012 ? char : "?";
  }

  function readMask(mask, width, height) {
    const boxes = components(mask, width, height).filter(
      (b) => b.h >= 1 && b.h <= 180 && b.w >= 1 && b.w <= 180,
    );
    const letters = boxes.filter(
      (b) => b.h >= 10 && b.w / b.h < 1.35 && b.area >= 12,
    );
    const lines = [];
    for (const box of letters.sort((a, b) => a.y1 - b.y1)) {
      let line = lines.find(
        (l) =>
          Math.abs(l.y1 - box.y1) < Math.max(3, l.h * 0.18) &&
          box.h / l.h > 0.8 &&
          box.h / l.h < 1.25,
      );
      if (!line) {
        line = { y1: box.y1, h: box.h, boxes: [] };
        lines.push(line);
      }
      line.boxes.push(box);
    }
    const amounts = [];
    for (const line of lines) {
      if (line.boxes.length < 4 || line.boxes.length > 50) continue;
      const ordered = line.boxes.sort((a, b) => a.x0 - b.x0);
      const small = boxes.filter(
        (b) =>
          b.h < line.h * 0.4 &&
          b.w < line.h * 0.35 &&
          b.y1 >= line.y1 - line.h * 0.15 &&
          b.y1 <= line.y1 + line.h * 0.2 &&
          b.x0 > ordered[0].x0 &&
          b.x1 < ordered[ordered.length - 1].x1,
      );
      let text = "",
        previous;
      for (const box of [...ordered, ...small].sort((a, b) => a.x0 - b.x0)) {
        if (previous && box.x0 - previous.x1 > line.h * 0.8) text += "|";
        else if (previous && box.x0 - previous.x1 > line.h * 0.22) text += " ";
        text += small.includes(box) ? "." : classify(mask, width, box);
        previous = box;
      }
      const pattern =
        /(?:CHF|Fr\.?)(\d{1,5}(?:[.,]\d{2})?)(?![\d?.])|(?<![\d?.])(\d{1,5}(?:[.,]\d{2})?)(?:CHF|Fr\.?)/g;
      for (const match of text.replaceAll(" ", "").matchAll(pattern)) {
        const amount = Number((match[1] || match[2]).replace(",", "."));
        if (amount > 0) amounts.push(amount.toFixed(2));
      }
    }
    return amounts;
  }

  self.recognizeTwintAmount = function (bitmap) {
    templates ??= makeTemplates();
    const scale = Math.min(1, 2048 / Math.max(bitmap.width, bitmap.height));
    const width = Math.round(bitmap.width * scale),
      height = Math.round(bitmap.height * scale);
    const canvas = new OffscreenCanvas(width, height);
    const ctx = canvas.getContext("2d", { willReadFrequently: true });
    ctx.fillStyle = "white";
    ctx.fillRect(0, 0, width, height);
    ctx.drawImage(bitmap, 0, 0, width, height);
    const rgba = ctx.getImageData(0, 0, width, height).data;
    const gray = new Uint8Array(width * height);
    for (let i = 0; i < gray.length; i++)
      gray[i] =
        0.299 * rgba[4 * i] + 0.587 * rgba[4 * i + 1] + 0.114 * rgba[4 * i + 2];
    const found = new Set();
    for (const threshold of [128, 192]) {
      for (const inverse of [false, true]) {
        const mask = new Uint8Array(gray.length);
        for (let i = 0; i < mask.length; i++)
          mask[i] = gray[i] < threshold !== inverse ? 1 : 0;
        for (const amount of readMask(mask, width, height)) found.add(amount);
      }
    }
    // Multiple different amounts are ambiguous: never choose a subtotal silently.
    return found.size === 1 ? `CHF ${[...found][0]}` : null;
  };
})();
