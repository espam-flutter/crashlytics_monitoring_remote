import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../injection/service_locator.dart';
import '../services/crashlytics_service.dart';

class CrashScreen extends StatelessWidget {
  const CrashScreen({super.key});

  CrashlyticsService get _crashlytics => getIt<CrashlyticsService>();

  Future<void> _recordNonFatalError(BuildContext context) async {
    if (!CrashlyticsService.isSupported) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Crashlytics no está disponible en web'),
          ),
        );
      }
      return;
    }

    try {
      final a = 1;
      final b = 0;
      final _ = a ~/ b;
    } catch (e, stack) {
      await _crashlytics.log(
        'Error no fatal simulado desde CrashScreen (división por cero)',
      );
      await _crashlytics.recordError(
        e,
        stack,
        fatal: false,
        reason: 'Simulación de error no fatal',
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error no fatal registrado en Crashlytics'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (kIsWeb)
            Card(
              color: Colors.amber.shade100,
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Crashlytics no funciona en Flutter Web. '
                  'Prueba esta pestaña en Android o iOS.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          if (kIsWeb) const SizedBox(height: 16),
          Icon(
            Icons.bug_report,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Firebase Crashlytics',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Prueba reportes fatales y no fatales. Los errores globales '
            'no capturados también se envían desde main.dart.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          FilledButton.icon(
            onPressed: CrashlyticsService.isSupported
                ? _crashlytics.forceCrash
                : null,
            icon: const Icon(Icons.warning_amber_rounded),
            label: const Text('Forzar crash fatal'),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: CrashlyticsService.isSupported
                ? () => _recordNonFatalError(context)
                : null,
            icon: const Icon(Icons.error_outline),
            label: const Text('Registrar error no fatal'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
