// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
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
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyASGDDjA-cnc3SHntXuW_INXOBj09_VWVM',
    appId: '1:341797672286:web:230af792f46b37a9096bcf',
    messagingSenderId: '341797672286',
    projectId: 'dsoc-app',
    authDomain: 'dsoc-app.firebaseapp.com',
    storageBucket: 'dsoc-app.firebasestorage.app',
    measurementId: 'G-6L1DP544P8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDklZfdPkqst7Iimm10GbRrso2MUhh5n6Y',
    appId: '1:341797672286:android:a6c5f5cfc8b44704096bcf',
    messagingSenderId: '341797672286',
    projectId: 'dsoc-app',
    storageBucket: 'dsoc-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAw12_uRkBQ7Fvjo7ygW-Un_8cVMFRlC6o',
    appId: '1:341797672286:ios:e8a79c9086867994096bcf',
    messagingSenderId: '341797672286',
    projectId: 'dsoc-app',
    storageBucket: 'dsoc-app.firebasestorage.app',
    iosBundleId: 'com.example.task2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAw12_uRkBQ7Fvjo7ygW-Un_8cVMFRlC6o',
    appId: '1:341797672286:ios:e8a79c9086867994096bcf',
    messagingSenderId: '341797672286',
    projectId: 'dsoc-app',
    storageBucket: 'dsoc-app.firebasestorage.app',
    iosBundleId: 'com.example.task2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyASGDDjA-cnc3SHntXuW_INXOBj09_VWVM',
    appId: '1:341797672286:web:cde0d4bde938c4f4096bcf',
    messagingSenderId: '341797672286',
    projectId: 'dsoc-app',
    authDomain: 'dsoc-app.firebaseapp.com',
    storageBucket: 'dsoc-app.firebasestorage.app',
    measurementId: 'G-Z9X4C0MF61',
  );

}