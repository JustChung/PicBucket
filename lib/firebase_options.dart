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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAfpEGgHhTdQ_7cmYsxira90Vs7iUJZoRk',
    appId: '1:253186659513:web:d217181d03bbd50a9d7768',
    messagingSenderId: '253186659513',
    projectId: 'picbucket-2dda4',
    authDomain: 'picbucket-2dda4.firebaseapp.com',
    storageBucket: 'picbucket-2dda4.appspot.com',
    measurementId: 'G-YCHCPERECZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBf0pFIIJ-IjgfpemqrNZMlFG-vbw7cawE',
    appId: '1:253186659513:android:5494e064b7e7e2559d7768',
    messagingSenderId: '253186659513',
    projectId: 'picbucket-2dda4',
    storageBucket: 'picbucket-2dda4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxAGRY2YraIQgnLp89t9Duzk2Sw26C6Es',
    appId: '1:253186659513:ios:2e898d7b048260139d7768',
    messagingSenderId: '253186659513',
    projectId: 'picbucket-2dda4',
    storageBucket: 'picbucket-2dda4.appspot.com',
    iosBundleId: 'com.bucketcpp.bucket',
  );
}