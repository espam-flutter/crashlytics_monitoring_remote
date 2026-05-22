// Performance Monitoring: SDK de trazas y métricas de rendimiento.
import 'package:firebase_performance/firebase_performance.dart';

/// Wrapper del SDK de Firebase Performance Monitoring.
class PerformanceService {
  // Performance Monitoring: instancia inyectable para pruebas.
  PerformanceService({FirebasePerformance? performance})
      : _performance = performance ?? FirebasePerformance.instance;

  final FirebasePerformance _performance;

  // Performance Monitoring: crea una traza personalizada por nombre.
  Trace createTrace(String name) {
    return _performance.newTrace(name);
  }
}
