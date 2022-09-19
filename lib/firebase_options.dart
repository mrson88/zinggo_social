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
    apiKey: 'AIzaSyBXt7rqNQixLpInb50HODXzmyS7ZlViA1o',
    appId: '1:108780648961:android:5e15ea43918e81d20c5e00',
    messagingSenderId: '108780648961',
    projectId: 'signin-76320',
    storageBucket: 'signin-76320.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyABGvfp-zQf7Dg7jg1bWsScIPn1Z1B3h7c',
    appId: '1:108780648961:ios:611e8f88f3f131050c5e00',
    messagingSenderId: '108780648961',
    projectId: 'signin-76320',
    storageBucket: 'signin-76320.appspot.com',
    androidClientId:
        '108780648961-3n4pc2pacis56jd03r5bufma2d4lmmvq.apps.googleusercontent.com',
    iosClientId:
        '108780648961-lorc9e7jpd498go4uovge8mm8n9ga7ih.apps.googleusercontent.com',
    iosBundleId: 'com.example.zinggoSocial',
  );
}