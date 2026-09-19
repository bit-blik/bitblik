import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import test from 'node:test';
import { runInNewContext } from 'node:vm';

const source = readFileSync(new URL('../../web/flutter_bootstrap.js', import.meta.url), 'utf8')
  .replace('{{flutter_js}}', '')
  .replace('{{flutter_build_config}}', '')
  .replace('{{flutter_service_worker_version}}', 'null');

function config(search = '', appConfig, userAgent = 'Firefox/143') {
  let loaded;
  runInNewContext(source, {
    window: { location: { search }, appConfig },
    navigator: { userAgent },
    URLSearchParams,
    _flutter: { loader: { load: (options) => { loaded = options.config; } } },
  });
  return loaded;
}

test('Firefox and Chromium use accelerated rendering by default', () => {
  assert.equal(config().canvasKitForceCpuOnly, false);
  assert.equal(config('', {}, 'Chrome/140').canvasKitForceCpuOnly, false);
});
test('software rendering remains an explicit URL or deployment fallback', () => {
  assert.equal(config('?rendering=software').canvasKitForceCpuOnly, true);
  assert.equal(config('', { forceSoftwareRendering: true }).canvasKitForceCpuOnly, true);
  assert.equal(config('?rendering=hardware', { forceSoftwareRendering: true }).canvasKitForceCpuOnly, false);
});
