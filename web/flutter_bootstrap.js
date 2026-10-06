{{flutter_js}}
{{flutter_build_config}}

const barberHubConfig = { canvasKitBaseUrl: 'canvaskit/' };

_flutter.loader.load({
  config: barberHubConfig,
  onEntrypointLoaded: async function (engineInitializer) {
    try {
      const appRunner = await engineInitializer.initializeEngine(barberHubConfig);
      await appRunner.runApp();
    } catch (error) {
      window.dispatchEvent(new Event('barberhub-load-error'));
      console.error('Falha ao iniciar BarberHub.', error);
    }
  }
}).catch((error) => {
  window.dispatchEvent(new Event('barberhub-load-error'));
  console.error('Falha ao carregar BarberHub.', error);
});
