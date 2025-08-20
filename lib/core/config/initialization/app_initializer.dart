import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../../data/services/firebase/dataconnect/firebase_data_connect.dart';
import '../../utils/exceptions/app_exception.dart';
import '../../utils/logging/logger.dart';
import '../capabilities/package_capability.dart';
import '../env/env.dart';

import '../firebase/firebase_options.dart';
import 'app_initializer_none.dart'
    if (dart.library.io) 'app_initializer_io.dart'
    if (dart.library.js_interop) 'app_initializer_web.dart';

final class AppInitializer {
  const AppInitializer._();

  static final AppInitializerProtocol instance = AppInitializerImpl();
}

/// @remarks firebase.json とポート番号を一致させてください。
enum _Firebase {
  // ignore: unused_field
  emulatorUi(4000),
  cloudFunctions(5001),
  // ignore: unused_field
  hosting(5002),
  firestore(8080),
  // ignore: unused_field
  cloudPubSub(8085),
  realtimeDatabase(9000),
  auth(9099),
  cloudStorage(9199),
  // ignore: unused_field
  cloudEvents(9299),
  dataConnect(9399),
  // ignore: unused_field
  cloudTasks(9499);

  const _Firebase(this.port);
  final int port;
}

abstract class AppInitializerProtocol {
  Future<void> initialize();

  Future<void> initializeFirebaseApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    if (kIsDev && kDebugMode) {
      Logger.instance.d(
        '🚀 Starting Firebase Local Emulator Suite connection ...',
      );

      try {
        const host = 'localhost';

        if (PackageCapability.supportsDataConnect) {
          FirebaseDataConnect.instance.dataConnect.useDataConnectEmulator(
            host,
            _Firebase.dataConnect.port,
          );
        }

        await FirebaseAuth.instance.useAuthEmulator(host, _Firebase.auth.port);

        if (PackageCapability.supportsCloudFunctions) {
          FirebaseFunctions.instance.useFunctionsEmulator(
            host,
            _Firebase.cloudFunctions.port,
          );
        }

        FirebaseFirestore.instance.useFirestoreEmulator(
          host,
          _Firebase.firestore.port,
        );

        if (PackageCapability.supportsFirebaseRealtimeDatabase) {
          FirebaseDatabase.instance.useDatabaseEmulator(
            host,
            _Firebase.realtimeDatabase.port,
          );
        }

        await FirebaseStorage.instance.useStorageEmulator(
          host,
          _Firebase.cloudStorage.port,
        );

        Logger.instance.d(
          '✅ Firebase Local Emulator Suite'
          ' connections established successfully!',
        );

        _initializeErrorHandlers();
      } on Exception catch (error, stackTrace) {
        Logger.instance.e(
          '❌ Firebase Local Emulator connection failed'
          ' - Firebase local emulator suite is not available.'
          ' Check the host and port settings in your configuration.'
          ' Make sure your environment variables are correct.'
          '\n\nPlease ensure that:'
          '\n1. Firebase Local Emulator is running and accessible'
          '\n2. The correct port is specified in firebase.json'
          '\n3. Your firewall settings allow connections to the specified ports'
          '\n\nIf you\'re running the app in an emulator or simulator,'
          ' make sure the virtual device can access your host machine.',
          error: error,
          stackTrace: stackTrace,
        );

        throw const AppException.serviceUnavailable(
          'Firebase Local Emulator connection failed',
        );
      }
    }
  }

  /// @see [Configure crash handlers](https://firebase.google.com/docs/crashlytics/get-started?platform=flutter#configure-crash-handlers)
  /// @see [Handling errors in Flutter](https://docs.flutter.dev/testing/errors)
  void _initializeErrorHandlers() {
    FlutterError.onError = (flutterErrorDetails) {
      FlutterError.presentError(flutterErrorDetails);

      if (PackageCapability.supportsFirebaseCrashlytics) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(
          flutterErrorDetails,
        );
      }

      if (kReleaseMode) {
        exit(1);
      }
    };

    PlatformDispatcher.instance.onError = (error, stackTrace) {
      Logger.instance.e(
        error.toString(),
        error: error,
        stackTrace: stackTrace,
        logsAnalyticsEvent: false,
        logsCrashlyticsMessage: false,
      );

      return true;
    };
  }
}
