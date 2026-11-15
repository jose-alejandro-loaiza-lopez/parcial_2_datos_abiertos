{{flutter_js}}
{{flutter_build_config}}

// La demo se monta dentro de un contenedor con proporción 9:18 para que la
// aplicación se vea como en un celular cuando se abre desde un computador.
_flutter.loader.load({
  onEntrypointLoaded: async function (engineInitializer) {
    const host = document.getElementById('flutter-host');
    const appRunner = await engineInitializer.initializeEngine({
      hostElement: host,
    });
    await appRunner.runApp();
  },
});
