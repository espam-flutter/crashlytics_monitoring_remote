import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Wrapper del SDK de Firebase Crashlytics.
///
/// Solo Android, iOS y macOS. En web no existe implementación nativa del plugin.
class CrashlyticsService {
  CrashlyticsService({FirebaseCrashlytics? crashlytics})
    : _crashlytics = crashlytics;

  final FirebaseCrashlytics? _crashlytics;

  static bool get isSupported => !kIsWeb;

  FirebaseCrashlytics get _instance =>
      _crashlytics ?? FirebaseCrashlytics.instance;

  Future<void> initialize() async {
    if (!isSupported) return;
    await _instance.setCrashlyticsCollectionEnabled(true);
  }

  /// Simula un crash fatal (solo para pruebas en móvil/desktop nativo).
  void forceCrash() {
    if (!isSupported) return;
    _instance.crash();
  }

  Future<void> log(String message) async {
    if (!isSupported) return;
    await _instance.log(message);
  }

  Future<void> recordError(
    Object exception,
    StackTrace? stack, {
    bool fatal = false,
    String? reason,
  }) async {
    if (!isSupported) return;
    await _instance.recordError(exception, stack, reason: reason, fatal: fatal);
  }

  void recordFlutterError(FlutterErrorDetails details) {
    if (!isSupported) {
      FlutterError.presentError(details);
      return;
    }
    _instance.recordFlutterFatalError(details);
  }

  void recordPlatformError(Object error, StackTrace stack) {
    if (!isSupported) return;
    _instance.recordError(error, stack, fatal: true);
  }
}
