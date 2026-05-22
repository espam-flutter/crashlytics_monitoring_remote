import 'package:flutter/material.dart';

import 'config_screen.dart'; // Remote Config
import 'crash_screen.dart'; // Crashlytics
import 'perf_screen.dart'; // Performance Monitoring

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Navegación entre las tres demos de Firebase.
  static const _titles = [
    'Crashlytics',
    'Performance',
    'Remote Config',
  ];

  final _screens = const [
    CrashScreen(), // Crashlytics
    PerfScreen(), // Performance Monitoring
    ConfigScreen(), // Remote Config
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.bug_report_outlined),
            selectedIcon: Icon(Icons.bug_report),
            label: 'Crashlytics',
          ),
          NavigationDestination(
            icon: Icon(Icons.speed_outlined),
            selectedIcon: Icon(Icons.speed),
            label: 'Performance',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune_outlined),
            selectedIcon: Icon(Icons.tune),
            label: 'Config',
          ),
        ],
      ),
    );
  }
}
