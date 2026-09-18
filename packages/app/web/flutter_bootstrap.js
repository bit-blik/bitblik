{{flutter_js}}
{{flutter_build_config}}

// Keep accelerated rendering on every browser. Software rendering remains an
// opt-in escape hatch for devices affected by a CanvasKit/WebGL driver crash:
// append ?rendering=software, or set appConfig.forceSoftwareRendering=true.
const rendering = new URLSearchParams(window.location.search).get('rendering');
const softwareRendering = rendering === 'software' ||
  (rendering !== 'hardware' && window.appConfig?.forceSoftwareRendering === true);

_flutter.loader.load({
  config: {
    canvasKitForceCpuOnly: softwareRendering,
  },
  serviceWorkerSettings: {
    serviceWorkerVersion: {{flutter_service_worker_version}},
  },
});
