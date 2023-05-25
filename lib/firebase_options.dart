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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQfilhE9Etz1HA7yPf8XvPANCWJXskjPY',
    appId: '1:1020752653553:android:009fa8ccae299368ff0d50',
    messagingSenderId: '1020752653553',
    projectId: 'test-seva',
    storageBucket: 'test-seva.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrvwikaOKIxDeJfiRBIpce5APgJl6FwzY',
    appId: '1:1020752653553:ios:9af9f413ce095737aa5523',
    messagingSenderId: '1020752653553',
    projectId: 'devs-portfolio',
    storageBucket: 'devs-portfolio.appspot.com',
    iosClientId:
        '458277569178-sd0ng9qnp8s8a2i90ktp4kgqrq5oifsv.apps.googleusercontent.com',
    iosBundleId: 'com.test.ios.sevaauth',
  );
}