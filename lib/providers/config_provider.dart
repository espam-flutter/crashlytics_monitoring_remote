import 'package:flutter/foundation.dart';

import '../services/remote_config_service.dart';

class ConfigProvider extends ChangeNotifier {
  ConfigProvider(this._remoteConfigService);

  final RemoteConfigService _remoteConfigService;

  bool _isLoading = false;
  bool _isInitialized = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;
  String? get errorMessage => _errorMessage;

  String get bannerText => _remoteConfigService.bannerText;
  bool get showPromo => _remoteConfigService.showPromo;

  Future<void> initialize() async {
    if (_isInitialized) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
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
