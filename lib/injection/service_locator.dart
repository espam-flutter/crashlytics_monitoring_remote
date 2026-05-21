import 'package:get_it/get_it.dart';

import '../services/crashlytics_service.dart';
import '../services/performance_service.dart';
import '../services/remote_config_service.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  if (getIt.isRegistered<CrashlyticsService>()) return;

  getIt.registerLazySingleton<CrashlyticsService>(CrashlyticsService.new);
  getIt.registerLazySingleton<PerformanceService>(PerformanceService.new);
  getIt.registerLazySingleton<RemoteConfigService>(RemoteConfigService.new);
}
