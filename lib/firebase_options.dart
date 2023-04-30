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
    apiKey: 'AIzaSyCfhNiLymukOgMUsBKkw8X3CARIAFX6PBw',
    appId: '1:642656145533:web:509e3fd87efe485dae2114',
    messagingSenderId: '642656145533',
    projectId: 'com-ledinhcuong-rikedu',
    authDomain: 'com-ledinhcuong-rikedu.firebaseapp.com',
    databaseURL: 'https://com-ledinhcuong-rikedu-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'com-ledinhcuong-rikedu.appspot.com',
    measurementId: 'G-G143GLTNX4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAF-CoshTGbM8mFduG7rlhsSGwUU_onu10',
    appId: '1:642656145533:android:222cba64458c208aae2114',
    messagingSenderId: '642656145533',
    projectId: 'com-ledinhcuong-rikedu',
    databaseURL: 'https://com-ledinhcuong-rikedu-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'com-ledinhcuong-rikedu.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUvMxdTp_PfY57deFccQnmVp0SBiR-3Xk',
    appId: '1:642656145533:ios:6339dd7197aed1e3ae2114',
    messagingSenderId: '642656145533',
    projectId: 'com-ledinhcuong-rikedu',
    databaseURL: 'https://com-ledinhcuong-rikedu-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'com-ledinhcuong-rikedu.appspot.com',
    iosBundleId: 'com.ledinhcuong.rikedu',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBUvMxdTp_PfY57deFccQnmVp0SBiR-3Xk',
    appId: '1:642656145533:ios:6339dd7197aed1e3ae2114',
    messagingSenderId: '642656145533',
    projectId: 'com-ledinhcuong-rikedu',
    databaseURL: 'https://com-ledinhcuong-rikedu-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'com-ledinhcuong-rikedu.appspot.com',
    iosBundleId: 'com.ledinhcuong.rikedu',
  );
}