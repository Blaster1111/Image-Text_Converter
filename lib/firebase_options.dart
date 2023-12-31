// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAP3Hj3dh_XybDNm5a3hCP2yCxohHgUkMM',
    appId: '1:407190636363:web:44e5702b54a21c7d960ace',
    messagingSenderId: '407190636363',
    projectId: 'imageconverter-7405c',
    authDomain: 'imageconverter-7405c.firebaseapp.com',
    storageBucket: 'imageconverter-7405c.appspot.com',
    measurementId: 'G-P2S9LL8049',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAv68xcYuEZnXIaPakR4T7O5s9aHXJkzTo',
    appId: '1:407190636363:android:8d5a63aa66436c01960ace',
    messagingSenderId: '407190636363',
    projectId: 'imageconverter-7405c',
    storageBucket: 'imageconverter-7405c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC1WG-A2qm288-Ou_0MBiEna5OmCCZa1dQ',
    appId: '1:407190636363:ios:f056b6682ef6b594960ace',
    messagingSenderId: '407190636363',
    projectId: 'imageconverter-7405c',
    storageBucket: 'imageconverter-7405c.appspot.com',
    iosBundleId: 'com.example.imageConverter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC1WG-A2qm288-Ou_0MBiEna5OmCCZa1dQ',
    appId: '1:407190636363:ios:61a359f10617b14a960ace',
    messagingSenderId: '407190636363',
    projectId: 'imageconverter-7405c',
    storageBucket: 'imageconverter-7405c.appspot.com',
    iosBundleId: 'com.example.imageConverter.RunnerTests',
  );
}
