// Remote Config: SDK de parámetros remotos con valores por defecto locales.
import 'package:firebase_remote_config/firebase_remote_config.dart';

/// Valores por defecto de Remote Config (fallback sin red).
abstract final class RemoteConfigKeys {
  // Remote Config: clave del texto del banner en la consola de Firebase.
  static const bannerText = 'banner_text';
  // Remote Config: clave booleana que muestra u oculta la promo.
  static const showPromo = 'show_promo';
}

/// Wrapper del SDK de Firebase Remote Config.
class RemoteConfigService {
  // Remote Config: instancia inyectable para pruebas.
  RemoteConfigService({FirebaseRemoteConfig? remoteConfig})
      : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  final FirebaseRemoteConfig _remoteConfig;

  // Remote Config: valores locales si fetch falla o aún no hay red.
  static const Map<String, Object> defaultValues = {
    RemoteConfigKeys.bannerText: 'Bienvenido',
    RemoteConfigKeys.showPromo: false,
  };

  Future<void> initialize() async {
    // Remote Config: aplica defaults antes del primer fetch.
    await _remoteConfig.setDefaults(defaultValues);
    // Remote Config: timeout de fetch e intervalo mínimo entre consultas.
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: Duration.zero,
      ),
    );
    // Remote Config: descarga plantilla de la nube y la activa en el dispositivo.
    await _remoteConfig.fetchAndActivate();
  }

  // Remote Config: lee el parámetro string activo.
  String get bannerText =>
      _remoteConfig.getString(RemoteConfigKeys.bannerText);

  // Remote Config: lee el parámetro boolean activo.
  bool get showPromo => _remoteConfig.getBool(RemoteConfigKeys.showPromo);

  // Remote Config: vuelve a consultar la nube y activa si hay cambios.
  Future<bool> fetchAndActivate() => _remoteConfig.fetchAndActivate();
}
