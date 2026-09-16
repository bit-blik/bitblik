{{flutter_js}}
{{flutter_build_config}}

const isFirefox = /Firefox\//.test(navigator.userAgent);

_flutter.loader.load({
  config: {
    // Firefox can abort inside CanvasKit's WebGL surface flush even when app
    // scene data is valid. Keep CanvasKit, but use its software surface there.
    canvasKitForceCpuOnly: isFirefox,
  },
  serviceWorkerSettings: {
    serviceWorkerVersion: {{flutter_service_worker_version}},
  },
});
