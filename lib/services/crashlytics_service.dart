// Crashlytics: SDK de reporte de crashes y errores no fatales.
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Wrapper del SDK de Firebase Crashlytics.
///
/// Solo Android, iOS y macOS. En web no existe implementación nativa del plugin.
class CrashlyticsService {
  // Crashlytics: instancia inyectable para pruebas; si es null usa la del SDK.
  CrashlyticsService({FirebaseCrashlytics? crashlytics})
    : _crashlytics = crashlytics;

  final FirebaseCrashlytics? _crashlytics;

  // Crashlytics: el plugin no expone implementación en Flutter Web.
  static bool get isSupported => !kIsWeb;

  FirebaseCrashlytics get _instance =>
      _crashlytics ?? FirebaseCrashlytics.instance;

  Future<void> initialize() async {
    if (!isSupported) return;
    // Crashlytics: activa el envío de informes a la consola de Firebase.
    await _instance.setCrashlyticsCollectionEnabled(true);
  }

  /// Simula un crash fatal (solo para pruebas en móvil/desktop nativo).
  void forceCrash() {
    if (!isSupported) return;
    // Crashlytics: provoca un cierre nativo para verificar el flujo fatal.
    _instance.crash();
  }

  Future<void> log(String message) async {
    if (!isSupported) return;
    // Crashlytics: breadcrumb que acompaña el próximo informe de error.
    await _instance.log(message);
  }

  Future<void> recordError(
    Object exception,
    StackTrace? stack, {
    bool fatal = false,
    String? reason,
  }) async {
    if (!isSupported) return;
    // Crashlytics: registra excepción con severidad fatal o no fatal.
    await _instance.recordError(exception, stack, reason: reason, fatal: fatal);
  }

  void recordFlutterError(FlutterErrorDetails details) {
    if (!isSupported) {
      FlutterError.presentError(details);
      return;
    }
    // Crashlytics: error del framework Flutter (p. ej. overflow, assert).
    _instance.recordFlutterFatalError(details);
  }

  void recordPlatformError(Object error, StackTrace stack) {
    if (!isSupported) return;
    // Crashlytics: error de isolate / zona asíncrona marcado como fatal.
    _instance.recordError(error, stack, fatal: true);
  }
}
