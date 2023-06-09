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
    apiKey: 'AIzaSyCZZ9ys77HQj-peRZLG5CPihHj0lL5U2WA',
    appId: '1:916831591136:web:57e4fd8ce36d91874b8e85',
    messagingSenderId: '916831591136',
    projectId: 'social-media-fb35b',
    authDomain: 'social-media-fb35b.firebaseapp.com',
    storageBucket: 'social-media-fb35b.appspot.com',
    measurementId: 'G-913X3DMLFG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCFe6Yj4Fr7WR0gfsBV3qOmvhscbhZCpz8',
    appId: '1:916831591136:android:d00d090475a1c4e24b8e85',
    messagingSenderId: '916831591136',
    projectId: 'social-media-fb35b',
    storageBucket: 'social-media-fb35b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlh698_PBu1rjie9EM72je-bkdeGpr_k0',
    appId: '1:916831591136:ios:c4ba5666d21590eb4b8e85',
    messagingSenderId: '916831591136',
    projectId: 'social-media-fb35b',
    storageBucket: 'social-media-fb35b.appspot.com',
    androidClientId: '916831591136-rf198snj0aveeirbqd4dor5n4ii7q80h.apps.googleusercontent.com',
    iosClientId: '916831591136-3f8njp1t00c89u96o8bb5noomaq12865.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialMedia',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDlh698_PBu1rjie9EM72je-bkdeGpr_k0',
    appId: '1:916831591136:ios:c4ba5666d21590eb4b8e85',
    messagingSenderId: '916831591136',
    projectId: 'social-media-fb35b',
    storageBucket: 'social-media-fb35b.appspot.com',
    androidClientId: '916831591136-rf198snj0aveeirbqd4dor5n4ii7q80h.apps.googleusercontent.com',
    iosClientId: '916831591136-3f8njp1t00c89u96o8bb5noomaq12865.apps.googleusercontent.com',
    iosBundleId: 'com.example.socialMedia',
  );
}
