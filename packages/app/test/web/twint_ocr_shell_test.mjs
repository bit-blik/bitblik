import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import test from 'node:test';

for (const shell of ['bitblik', 'bitway', 'bittwint']) {
  test(`${shell} web shell loads TWINT browser OCR`, () => {
    const html = readFileSync(
      new URL(`../../web_shells/${shell}/index.html`, import.meta.url),
      'utf8',
    );
    assert.match(html, /<script src="twint_ocr\.js"><\/script>/);
  });
}
