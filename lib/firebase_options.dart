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
    apiKey: 'AIzaSyByqTv_ay8m6cQmVAIF7zkAsgwu4we8ako',
    appId: '1:500317680360:web:6488b62ad0bca07f6d4f5d',
    messagingSenderId: '500317680360',
    projectId: 'booking-library-eb022',
    authDomain: 'booking-library-eb022.firebaseapp.com',
    storageBucket: 'booking-library-eb022.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBz3pK7QfMgvpNn0DRAzaRQcX32KNf2KtE',
    appId: '1:500317680360:android:5ccb9f08e42779f96d4f5d',
    messagingSenderId: '500317680360',
    projectId: 'booking-library-eb022',
    storageBucket: 'booking-library-eb022.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAhsBhVrixgy7ptlTAi9qJxIaIkUoQ4nG8',
    appId: '1:500317680360:ios:d4c64837600f84626d4f5d',
    messagingSenderId: '500317680360',
    projectId: 'booking-library-eb022',
    storageBucket: 'booking-library-eb022.appspot.com',
    iosClientId: '500317680360-hb6m05vtoffvmie4t3rhrfuhp7qv4l38.apps.googleusercontent.com',
    iosBundleId: 'com.uy.zootecnia.reservelibrary.reserveLibrary',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAhsBhVrixgy7ptlTAi9qJxIaIkUoQ4nG8',
    appId: '1:500317680360:ios:d4c64837600f84626d4f5d',
    messagingSenderId: '500317680360',
    projectId: 'booking-library-eb022',
    storageBucket: 'booking-library-eb022.appspot.com',
    iosClientId: '500317680360-hb6m05vtoffvmie4t3rhrfuhp7qv4l38.apps.googleusercontent.com',
    iosBundleId: 'com.uy.zootecnia.reservelibrary.reserveLibrary',
  );
}
