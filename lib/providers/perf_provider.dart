import 'package:flutter/foundation.dart';

import '../services/performance_service.dart';

class PerfProvider extends ChangeNotifier {
  PerfProvider(this._performanceService);

  // Performance Monitoring: servicio que crea y controla las trazas del SDK.
  final PerformanceService _performanceService;

  // Performance Monitoring: nombre de la traza visible en la consola de Firebase.
  static const String traceName = 'heavy_process_simulation';

  bool _isRunning = false;
  bool _traceCompleted = false;
  String? _lastMessage;

  bool get isRunning => _isRunning;
  bool get traceCompleted => _traceCompleted;
  String? get lastMessage => _lastMessage;

  Future<void> runHeavyProcess() async {
    if (_isRunning) return;

    _isRunning = true;
    _traceCompleted = false;
    _lastMessage = null;
    notifyListeners();

    // Performance Monitoring: inicia traza personalizada alrededor del trabajo pesado.
    final trace = _performanceService.createTrace(traceName);
    await trace.start();

    try {
      await Future<void>.delayed(const Duration(seconds: 2));
      var sum = 0;
      for (var i = 0; i < 10000000; i++) {
        sum += i;
      }
      debugPrint('Perf simulation sum: $sum');
    } finally {
      // Performance Monitoring: detiene la traza y la envía a Firebase.
      await trace.stop();
      _isRunning = false;
      _traceCompleted = true;
      _lastMessage = 'Traza "$traceName" registrada en Performance Monitoring.';
      notifyListeners();
    }
  }

  void clearCompletion() {
    _traceCompleted = false;
    _lastMessage = null;
    notifyListeners();
  }
}
