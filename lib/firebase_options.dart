// Firebase Core: credenciales por plataforma (compartidas por Crashlytics, Performance y Remote Config).
// Archivo generado por FlutterFire CLI (`flutterfire configure`).
// Reemplaza estos valores ejecutando: dart pub global activate flutterfire_cli && flutterfire configure

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  // Firebase Core: selecciona el FirebaseOptions según web, Android, iOS o macOS.
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions no están configuradas para esta plataforma.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB9cAkGJ08p7Qy3IPl6g25XxbSSoHCw5Ro',
    appId: '1:58135104076:web:1c6124f2a32d4836b7c2e9',
    messagingSenderId: '58135104076',
    projectId: 'crashlytics-monitoring-remote',
    authDomain: 'crashlytics-monitoring-remote.firebaseapp.com',
    storageBucket: 'crashlytics-monitoring-remote.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGtqIJCAS_BLzZaG8njZvFnnu7gdZjrdI',
    appId: '1:58135104076:android:b4cc9504bb7e7271b7c2e9',
    messagingSenderId: '58135104076',
    projectId: 'crashlytics-monitoring-remote',
    storageBucket: 'crashlytics-monitoring-remote.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: 'YOUR_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_PROJECT_ID.appspot.com',
    iosBundleId: 'com.example.crashlyticsMonitoringRemote',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: 'YOUR_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_PROJECT_ID.appspot.com',
    iosBundleId: 'com.example.crashlyticsMonitoringRemote',
  );
}
