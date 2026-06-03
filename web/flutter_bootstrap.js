{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();
    
    // Once the engine is initialized, we can remove our custom loader here or wait for the app to run.
    // It is generally safer to let the MutationObserver in index.html remove it, 
    // or remove it right after runApp.
    await appRunner.runApp();
  }
});
