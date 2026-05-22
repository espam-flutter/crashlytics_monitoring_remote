import 'package:get_it/get_it.dart';

import '../services/crashlytics_service.dart';
import '../services/performance_service.dart';
import '../services/remote_config_service.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  if (getIt.isRegistered<CrashlyticsService>()) return;

  // Crashlytics: singleton del wrapper de reporte de errores.
  getIt.registerLazySingleton<CrashlyticsService>(CrashlyticsService.new);
  // Performance Monitoring: singleton del wrapper de trazas.
  getIt.registerLazySingleton<PerformanceService>(PerformanceService.new);
  // Remote Config: singleton del wrapper de parámetros remotos.
  getIt.registerLazySingleton<RemoteConfigService>(RemoteConfigService.new);
}
