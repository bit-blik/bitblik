# TWINT browser amount recognition

`twint_amount_ocr_test.cjs` runs the real Web Worker in headless Chrome. It covers
CHF amounts on light/dark backgrounds, different fonts and sizes, decimal commas,
currency suffixes, and ambiguous/irrelevant text. No OCR model is needed.

Install Playwright in a separate tooling directory, then run from repository root:

```sh
PLAYWRIGHT_MODULE=/path/to/node_modules/playwright \
  CHROME_BIN=/usr/bin/google-chrome \
  TWINT_IMPORT_SCREENSHOT=/path/to/twint.png \
  node packages/app/test_web/twint_amount_ocr_test.cjs
```

`TWINT_IMPORT_SCREENSHOT` is optional. When supplied, tests expect the example
CHF 9.90 screenshot and also check resized JPEG copies. The screenshot stays
local and is not committed. If Playwright resolves normally, omit
`PLAYWRIGHT_MODULE`.

The fallback is deliberately limited to clear printed currency amounts. It
compares connected letter/digit shapes against browser-rendered font templates,
requires a currency label, and returns no amount for uncertain characters or
multiple distinct recognized amounts. It is not general-purpose document OCR.
