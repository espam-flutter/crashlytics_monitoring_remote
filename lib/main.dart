import 'dart:ui';

// Firebase Core: SDK base requerido por Crashlytics, Performance y Remote Config.
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart'; // Credenciales del proyecto Firebase (FlutterFire CLI).
import 'injection/service_locator.dart';
import 'providers/config_provider.dart'; // Remote Config: estado de parámetros remotos en la UI.
import 'providers/perf_provider.dart'; // Performance Monitoring: estado de trazas en la UI.
import 'screens/home_screen.dart';
import 'services/crashlytics_service.dart'; // Crashlytics: wrapper del SDK de reporte de errores.
import 'services/performance_service.dart'; // Performance Monitoring: wrapper del SDK de trazas.
import 'services/remote_config_service.dart'; // Remote Config: wrapper del SDK de configuración remota.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase Core: inicializa la app con las opciones de la plataforma actual.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupServiceLocator();

  // --- Crashlytics: habilita recolección y captura errores globales (no en web). ---
  final crashlyticsService = getIt<CrashlyticsService>();
  await crashlyticsService.initialize();

  if (CrashlyticsService.isSupported) {
    // Errores de widgets Flutter → Crashlytics.
    FlutterError.onError = crashlyticsService.recordFlutterError;

    // Errores asíncronos fuera del árbol de widgets → Crashlytics.
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
        // Performance Monitoring: inyecta el servicio de trazas en PerfProvider.
        ChangeNotifierProvider(
          create: (_) => PerfProvider(getIt<PerformanceService>()),
        ),
        // Remote Config: inyecta el servicio de parámetros remotos en ConfigProvider.
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
