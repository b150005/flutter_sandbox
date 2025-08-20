import 'package:flutter/foundation.dart';

/// @see [Available plugins](https://firebase.google.com/docs/flutter/setup?platform=ios#available-plugins)
final class PackageCapability {
  const PackageCapability._();

  /// @see [window_manager](https://pub.dev/packages/window_manager)
  static bool get supportsWindowManager =>
      !kIsWeb &&
      switch (defaultTargetPlatform) {
        TargetPlatform.linux ||
        TargetPlatform.macOS ||
        TargetPlatform.windows => true,
        _ => false,
      };

  /// @see [Available plugins](https://firebase.google.com/docs/flutter/setup?platform=ios#available-plugins)
  static bool get supportsDataConnect =>
      kIsWeb ||
      switch (defaultTargetPlatform) {
        TargetPlatform.android || TargetPlatform.iOS => true,
        _ => false,
      };

  /// @see [firebase_messaging](https://pub.dev/packages/firebase_messaging)
  static bool get supportsFirebaseCloudMessaging =>
      kIsWeb ||
      switch (defaultTargetPlatform) {
        TargetPlatform.android ||
        TargetPlatform.iOS ||
        TargetPlatform.macOS => true,
        _ => false,
      };

  /// @see [firebase_analytics](https://pub.dev/packages/firebase_analytics)
  static bool get supportsFirebaseAnalytics =>
      kIsWeb ||
      switch (defaultTargetPlatform) {
        TargetPlatform.android ||
        TargetPlatform.iOS ||
        TargetPlatform.macOS => true,
        _ => false,
      };

  /// @see [firebase_crashlytics](https://pub.dev/packages/firebase_crashlytics)
  static bool get supportsFirebaseCrashlytics =>
      !kIsWeb &&
      switch (defaultTargetPlatform) {
        TargetPlatform.android ||
        TargetPlatform.iOS ||
        TargetPlatform.macOS => true,
        _ => false,
      };

  /// @see [firebase_remote_config](https://pub.dev/packages/firebase_remote_config)
  static bool get supportsFirebaseRemoteConfig =>
      kIsWeb ||
      switch (defaultTargetPlatform) {
        TargetPlatform.android ||
        TargetPlatform.iOS ||
        TargetPlatform.macOS => true,
        _ => false,
      };

  /// @see [cloud_functions](https://pub.dev/packages/cloud_functions)
  static bool get supportsCloudFunctions =>
      kIsWeb ||
      switch (defaultTargetPlatform) {
        TargetPlatform.android ||
        TargetPlatform.iOS ||
        TargetPlatform.macOS => true,
        _ => false,
      };

  /// @see [firebase_performance](https://pub.dev/packages/firebase_performance)
  static bool get supportsFirebasePerformanceMonitoring =>
      kIsWeb ||
      switch (defaultTargetPlatform) {
        TargetPlatform.android || TargetPlatform.iOS => true,
        _ => false,
      };

  /// @see [firebase_app_check](https://pub.dev/packages/firebase_app_check)
  static bool get supportsFirebaseAppCheck =>
      kIsWeb ||
      switch (defaultTargetPlatform) {
        TargetPlatform.android ||
        TargetPlatform.iOS ||
        TargetPlatform.macOS => true,
        _ => false,
      };

  /// @see [firebase_app_installations](https://pub.dev/packages/firebase_app_installations)
  static bool get supportsFirebaseInstallations =>
      !kIsWeb &&
      switch (defaultTargetPlatform) {
        TargetPlatform.android ||
        TargetPlatform.iOS ||
        TargetPlatform.macOS => true,
        _ => false,
      };

  /// @see [firebase_in_app_messaging](https://pub.dev/packages/firebase_in_app_messaging)
  static bool get supportsFirebaseInAppMessaging =>
      !kIsWeb &&
      switch (defaultTargetPlatform) {
        TargetPlatform.android || TargetPlatform.iOS => true,
        _ => false,
      };

  /// @see [firebase_ai](https://pub.dev/packages/firebase_ai)
  static bool get supportsFirebaseAILogic =>
      kIsWeb ||
      switch (defaultTargetPlatform) {
        TargetPlatform.android ||
        TargetPlatform.iOS ||
        TargetPlatform.macOS => true,
        _ => false,
      };

  /// @see [firebase_database](https://pub.dev/packages/firebase_database)
  static bool get supportsFirebaseRealtimeDatabase =>
      kIsWeb ||
      switch (defaultTargetPlatform) {
        TargetPlatform.android ||
        TargetPlatform.iOS ||
        TargetPlatform.macOS => true,
        _ => false,
      };
}
