import 'package:firebase_performance/firebase_performance.dart';

/// Wrapper del SDK de Firebase Performance Monitoring.
class PerformanceService {
  PerformanceService({FirebasePerformance? performance})
      : _performance = performance ?? FirebasePerformance.instance;

  final FirebasePerformance _performance;

  Trace createTrace(String name) {
    return _performance.newTrace(name);
  }
}
