import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'injection/service_locator.dart';
import 'providers/config_provider.dart';
import 'providers/perf_provider.dart';
import 'screens/home_screen.dart';
import 'services/crashlytics_service.dart';
import 'services/performance_service.dart';
import 'services/remote_config_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupServiceLocator();

  final crashlyticsService = getIt<CrashlyticsService>();
  await crashlyticsService.initialize();

  if (CrashlyticsService.isSupported) {
    FlutterError.onError = crashlyticsService.recordFlutterError;

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      crashlyticsService.recordPlatformError(error, stack);
      return true;
    };
  }

  runApp(const FirebaseDemoApp());
}

class FirebaseDemoApp extends StatelessWidget {
  const FirebaseDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PerfProvider(getIt<PerformanceService>()),
        ),
        ChangeNotifierProvider(
          create: (_) => ConfigProvider(getIt<RemoteConfigService>()),
        ),
      ],
      child: MaterialApp(
        title: 'Firebase Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
