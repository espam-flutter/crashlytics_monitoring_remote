import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/perf_provider.dart';

class PerfScreen extends StatelessWidget {
  const PerfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PerfProvider>(
      builder: (context, perf, _) {
        if (perf.traceCompleted && perf.lastMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(perf.lastMessage!),
                backgroundColor: Colors.green.shade700,
              ),
            );
            perf.clearCompletion();
          });
        }

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.speed,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Firebase Performance',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Inicia una traza personalizada (${PerfProvider.traceName}) '
                'durante un proceso simulado pesado.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              if (perf.isRunning) ...[
                const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 16),
                const Text(
                  'Ejecutando proceso y traza...',
                  textAlign: TextAlign.center,
                ),
              ] else
                FilledButton.icon(
                  onPressed: perf.runHeavyProcess,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Iniciar proceso pesado'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
