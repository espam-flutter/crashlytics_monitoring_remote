# crashlytics_monitoring_remote

Demo Flutter con **Firebase Crashlytics**, **Performance Monitoring** y **Remote Config**, usando el patrón Service Wrapper, **GetIt** y **Provider**.

## Estructura

```
lib/
├── main.dart                 # Firebase init + manejo global de errores
├── firebase_options.dart     # Credenciales (generar con FlutterFire)
├── injection/
│   └── service_locator.dart  # GetIt
├── services/
│   ├── crashlytics_service.dart
│   ├── performance_service.dart
│   └── remote_config_service.dart
├── providers/
│   ├── config_provider.dart
│   └── perf_provider.dart
└── screens/
    ├── home_screen.dart
    ├── crash_screen.dart
    ├── perf_screen.dart
    └── config_screen.dart
```

## Configuración de Firebase

1. Crea un proyecto en [Firebase Console](https://console.firebase.google.com/).
2. Habilita **Crashlytics**, **Performance Monitoring** y **Remote Config**.
3. En la raíz del proyecto:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

4. Coloca `google-services.json` (Android) y `GoogleService-Info.plist` (iOS) — `flutterfire configure` los genera automáticamente.

### Remote Config (consola)

Crea estos parámetros en Firebase Remote Config:

| Clave         | Tipo    | Valor de ejemplo        |
|---------------|---------|-------------------------|
| `banner_text` | String  | `¡Oferta especial!`    |
| `show_promo`  | Boolean | `true`                  |

Con `minimumFetchInterval: 0` (solo desarrollo), el botón **Forzar Actualización** reflejará cambios al publicar en la consola.

## Ejecutar

```bash
flutter pub get
flutter run
```

## Notas

- El crash fatal usa `CrashlyticsService.forceCrash()` → `FirebaseCrashlytics.crash()`.
- En debug, la recolección de Crashlytics puede estar deshabilitada (`kDebugMode`); usa un build release o ajusta `setCrashlyticsCollectionEnabled` para pruebas.

## Flutter Web

| Pestaña | ¿Funciona en web? | Qué deberías ver |
|---------|-------------------|------------------|
| **Remote Config** | Sí | Banner/texto según `banner_text` y `show_promo`; botón Fetch actualiza la UI |
| **Performance** | Parcial | Proceso pesado + SnackBar al terminar la traza (consola Firebase con retraso) |
| **Crashlytics** | No | Aviso amarillo; botones deshabilitados. Usa Android/iOS para pruebas reales |

Si la pantalla quedaba en blanco, era porque `CrashlyticsService.initialize()` llamaba al plugin antes de `runApp()` y en web no existe implementación. La app ahora omite Crashlytics en web y muestra la UI.

Para probar todo el demo: `flutter run` en un emulador Android o dispositivo iOS.
