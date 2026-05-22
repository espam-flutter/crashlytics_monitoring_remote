import 'package:flutter/foundation.dart';

import '../services/remote_config_service.dart';

class ConfigProvider extends ChangeNotifier {
  ConfigProvider(this._remoteConfigService);

  // Remote Config: servicio que lee y actualiza parámetros del SDK.
  final RemoteConfigService _remoteConfigService;

  bool _isLoading = false;
  bool _isInitialized = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;
  String? get errorMessage => _errorMessage;

  // Remote Config: expone parámetro banner_text activo en el dispositivo.
  String get bannerText => _remoteConfigService.bannerText;
  // Remote Config: expone parámetro show_promo activo en el dispositivo.
  bool get showPromo => _remoteConfigService.showPromo;

  Future<void> initialize() async {
    if (_isInitialized) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Remote Config: defaults, settings y primer fetchAndActivate.
      await _remoteConfigService.initialize();
      _isInitialized = true;
    } catch (e) {
      _errorMessage = 'Error al inicializar Remote Config: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> forceRefresh() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Remote Config: fetch manual desde el botón de la pantalla Config.
      final updated = await _remoteConfigService.fetchAndActivate();
      return updated;
    } catch (e) {
      _errorMessage = 'Error al actualizar: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
