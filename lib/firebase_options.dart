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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9eXZLHFIIXwBn0tKu5NlEKySS9bt3N7k',
    appId: '1:235743143921:android:2b761bc407e1bd3cfc0650',
    messagingSenderId: '235743143921',
    projectId: 'goat-app-751e6',
    databaseURL: 'https://goat-app-751e6-default-rtdb.firebaseio.com',
    storageBucket: 'goat-app-751e6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCf8r7503cvreyBqkS5DaDTDnrHhZubMuw',
    appId: '1:235743143921:ios:3c19530d851c6324fc0650',
    messagingSenderId: '235743143921',
    projectId: 'goat-app-751e6',
    databaseURL: 'https://goat-app-751e6-default-rtdb.firebaseio.com',
    storageBucket: 'goat-app-751e6.appspot.com',
    iosBundleId: 'com.golfonanytee.goatApp.goatflutter.goatFlutter',
  );
}
