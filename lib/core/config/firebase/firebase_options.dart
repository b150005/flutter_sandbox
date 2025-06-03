import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

import '../env/env.dart';

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
  const DefaultFirebaseOptions._();

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
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static final web = FirebaseOptions(
    apiKey: Env.instance.firebaseWebApiKey,
    appId: Env.instance.firebaseWebAppId,
    messagingSenderId: Env.instance.firebaseWebMessagingSenderId,
    projectId: Env.instance.firebaseWebProjectId,
    authDomain: Env.instance.firebaseWebAuthDomain,
    storageBucket: Env.instance.firebaseWebStorageBucket,
    measurementId: Env.instance.firebaseWebMeasurementId,
  );

  static final android = FirebaseOptions(
    apiKey: Env.instance.firebaseAndroidApiKey,
    appId: Env.instance.firebaseAndroidAppId,
    messagingSenderId: Env.instance.firebaseAndroidMessagingSenderId,
    projectId: Env.instance.firebaseAndroidProjectId,
    databaseURL: Env.instance.firebaseAndroidDatabaseUrl,
    storageBucket: Env.instance.firebaseAndroidStorageBucket,
  );

  static final ios = FirebaseOptions(
    apiKey: Env.instance.firebaseIosApiKey,
    appId: Env.instance.firebaseIosAppId,
    messagingSenderId: Env.instance.firebaseIosMessagingSenderId,
    projectId: Env.instance.firebaseIosProjectId,
    databaseURL: Env.instance.firebaseIosDatabaseUrl,
    storageBucket: Env.instance.firebaseIosStorageBucket,
    iosBundleId: Env.instance.firebaseIosBundleId,
  );

  static final macos = FirebaseOptions(
    apiKey: Env.instance.firebaseMacosApiKey,
    appId: Env.instance.firebaseMacosAppId,
    messagingSenderId: Env.instance.firebaseMacosMessagingSenderId,
    projectId: Env.instance.firebaseMacosProjectId,
    databaseURL: Env.instance.firebaseMacosDatabaseUrl,
    storageBucket: Env.instance.firebaseMacosStorageBucket,
    iosBundleId: Env.instance.firebaseMacosBundleId,
  );

  static final windows = FirebaseOptions(
    apiKey: Env.instance.firebaseWindowsApiKey,
    appId: Env.instance.firebaseWindowsAppId,
    messagingSenderId: Env.instance.firebaseWindowsMessagingSenderId,
    projectId: Env.instance.firebaseWindowsProjectId,
    authDomain: Env.instance.firebaseWindowsAuthDomain,
    databaseURL: Env.instance.firebaseWindowsDatabaseUrl,
    storageBucket: Env.instance.firebaseWindowsStorageBucket,
    measurementId: Env.instance.firebaseWindowsMeasurementId,
  );
}
