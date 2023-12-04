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
    apiKey: 'AIzaSyDHFBLujt3Vwr5MyHy_E2IRCac7MQ2c0b8',
    appId: '1:234864439215:web:3113844684a2adb231c95a',
    messagingSenderId: '234864439215',
    projectId: 'mobilfinal-29180',
    authDomain: 'mobilfinal-29180.firebaseapp.com',
    storageBucket: 'mobilfinal-29180.appspot.com',
    measurementId: 'G-4LZND9Q2PM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAu88kOVI3KKNaT2OKP3jL1iNEuQI6hpGs',
    appId: '1:234864439215:android:5cc5e4707128f6e331c95a',
    messagingSenderId: '234864439215',
    projectId: 'mobilfinal-29180',
    storageBucket: 'mobilfinal-29180.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDjZbDy7fGveFMA59632NQtN-amyHLqgBk',
    appId: '1:234864439215:ios:71295f3fcb76cdc931c95a',
    messagingSenderId: '234864439215',
    projectId: 'mobilfinal-29180',
    storageBucket: 'mobilfinal-29180.appspot.com',
    iosClientId: '234864439215-rnqom8i8hvuiq33gr6ljn33fj2pl3sd8.apps.googleusercontent.com',
    iosBundleId: 'com.example.mafinal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDjZbDy7fGveFMA59632NQtN-amyHLqgBk',
    appId: '1:234864439215:ios:71295f3fcb76cdc931c95a',
    messagingSenderId: '234864439215',
    projectId: 'mobilfinal-29180',
    storageBucket: 'mobilfinal-29180.appspot.com',
    iosClientId: '234864439215-rnqom8i8hvuiq33gr6ljn33fj2pl3sd8.apps.googleusercontent.com',
    iosBundleId: 'com.example.mafinal',
  );
}
