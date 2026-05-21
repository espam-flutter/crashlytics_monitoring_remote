import 'package:firebase_remote_config/firebase_remote_config.dart';

/// Valores por defecto de Remote Config (fallback sin red).
abstract final class RemoteConfigKeys {
  static const bannerText = 'banner_text';
  static const showPromo = 'show_promo';
}

/// Wrapper del SDK de Firebase Remote Config.
class RemoteConfigService {
  RemoteConfigService({FirebaseRemoteConfig? remoteConfig})
      : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  final FirebaseRemoteConfig _remoteConfig;

  static const Map<String, Object> defaultValues = {
    RemoteConfigKeys.bannerText: 'Bienvenido',
    RemoteConfigKeys.showPromo: false,
  };

  Future<void> initialize() async {
    await _remoteConfig.setDefaults(defaultValues);
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: Duration.zero,
      ),
    );
    await _remoteConfig.fetchAndActivate();
  }

  String get bannerText =>
      _remoteConfig.getString(RemoteConfigKeys.bannerText);

  bool get showPromo => _remoteConfig.getBool(RemoteConfigKeys.showPromo);

  Future<bool> fetchAndActivate() => _remoteConfig.fetchAndActivate();
}
