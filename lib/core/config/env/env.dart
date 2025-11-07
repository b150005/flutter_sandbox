import 'package:envied/envied.dart';
import 'package:flutter/foundation.dart';

import 'env_field.dart';

part 'env.g.dart';

bool get kPreviewMode => const String.fromEnvironment(Env.appEnvKey).isEmpty;

bool get kIsDev => Env.instance.appEnv == Env.development;
bool get kIsStg => Env.instance.appEnv == Env.staging;
bool get kIsProd => Env.instance.appEnv == Env.production;

bool get kDebugModeInDev => kIsDev && kDebugMode;
bool get kDebugModeInDevOnWeb => kDebugModeInDev && kIsWeb;

@Envied(
  path: 'lib/core/config/env/development.env',
  name: 'Development',
  useConstantCase: true,
)
@Envied(
  path: 'lib/core/config/env/staging.env',
  name: 'Staging',
  useConstantCase: true,
)
@Envied(
  path: 'lib/core/config/env/production.env',
  name: 'Production',
  useConstantCase: true,
)
final class Env implements EnvField {
  Env._();

  static const appEnvKey = 'APP_ENV';

  static const development = 'development';
  static const staging = 'staging';
  static const production = 'production';

  static final Env instance = switch (const String.fromEnvironment(appEnvKey)) {
    development => _Development(),
    staging => _Staging(),
    production => _Production(),
    _ => throw UnsupportedError(
      'Unknown flutter flavor: ${const String.fromEnvironment(appEnvKey)}',
    ),
  };

  @override
  @EnviedField()
  final String appEnv = instance.appEnv;

  @override
  @EnviedField()
  final String capitalizedAppEnv = instance.capitalizedAppEnv;

  @override
  @EnviedField()
  final String appName = instance.appName;

  @override
  @EnviedField()
  final String teamId = instance.teamId;

  @override
  @EnviedField()
  final String bundleId = instance.bundleId;

  @override
  @EnviedField()
  final String appId = instance.appId;

  @override
  @EnviedField()
  final String androidNdkVersion = instance.androidNdkVersion;

  @override
  @EnviedField()
  final String androidMinSdk = instance.androidMinSdk;

  @override
  @EnviedField()
  final String sha256CertFingerprints = instance.sha256CertFingerprints;

  @override
  @EnviedField()
  final String origin = instance.origin;

  @override
  @EnviedField()
  final String webDescription = instance.webDescription;

  @override
  @EnviedField()
  final String themeColor = instance.themeColor;

  @override
  @EnviedField()
  final String host = instance.host;

  @override
  @EnviedField()
  final String firebaseWebApiKey = instance.firebaseWebApiKey;

  @override
  @EnviedField()
  final String firebaseWebAppId = instance.firebaseWebAppId;

  @override
  @EnviedField()
  final String firebaseWebMessagingSenderId =
      instance.firebaseWebMessagingSenderId;

  @override
  @EnviedField()
  final String firebaseWebProjectId = instance.firebaseWebProjectId;

  @override
  @EnviedField()
  final String firebaseWebAuthDomain = instance.firebaseWebAuthDomain;

  @override
  @EnviedField()
  final String firebaseWebDatabaseUrl = instance.firebaseWebDatabaseUrl;

  @override
  @EnviedField()
  final String firebaseWebStorageBucket = instance.firebaseWebStorageBucket;

  @override
  @EnviedField()
  final String firebaseWebMeasurementId = instance.firebaseWebMeasurementId;

  @override
  @EnviedField()
  final String firebaseAndroidApiKey = instance.firebaseAndroidApiKey;

  @override
  @EnviedField()
  final String firebaseAndroidAppId = instance.firebaseAndroidAppId;

  @override
  @EnviedField()
  final String firebaseAndroidMessagingSenderId =
      instance.firebaseAndroidMessagingSenderId;

  @override
  @EnviedField()
  final String firebaseAndroidProjectId = instance.firebaseAndroidProjectId;

  @override
  @EnviedField(optional: true)
  final String? firebaseAndroidDatabaseUrl =
      instance.firebaseAndroidDatabaseUrl;

  @override
  @EnviedField()
  final String firebaseAndroidStorageBucket =
      instance.firebaseAndroidStorageBucket;

  @override
  @EnviedField()
  final String firebaseIosApiKey = instance.firebaseIosApiKey;

  @override
  @EnviedField()
  final String firebaseIosAppId = instance.firebaseIosAppId;

  @override
  @EnviedField()
  final String firebaseIosMessagingSenderId =
      instance.firebaseIosMessagingSenderId;

  @override
  @EnviedField()
  final String firebaseIosProjectId = instance.firebaseIosProjectId;

  @override
  @EnviedField(optional: true)
  final String? firebaseIosDatabaseUrl = instance.firebaseIosDatabaseUrl;

  @override
  @EnviedField()
  final String firebaseIosStorageBucket = instance.firebaseIosStorageBucket;

  @override
  @EnviedField(optional: true)
  final String? firebaseIosClientId = instance.firebaseIosClientId;

  @override
  @EnviedField()
  final String firebaseIosBundleId = instance.firebaseIosBundleId;

  @override
  @EnviedField()
  final String firebaseMacosApiKey = instance.firebaseMacosApiKey;

  @override
  @EnviedField()
  final String firebaseMacosAppId = instance.firebaseMacosAppId;

  @override
  @EnviedField()
  final String firebaseMacosMessagingSenderId =
      instance.firebaseMacosMessagingSenderId;

  @override
  @EnviedField()
  final String firebaseMacosProjectId = instance.firebaseMacosProjectId;

  @override
  @EnviedField(optional: true)
  final String? firebaseMacosDatabaseUrl = instance.firebaseMacosDatabaseUrl;

  @override
  @EnviedField()
  final String firebaseMacosStorageBucket = instance.firebaseMacosStorageBucket;

  @override
  @EnviedField(optional: true)
  final String? firebaseMacosClientId = instance.firebaseMacosClientId;

  @override
  @EnviedField()
  final String firebaseMacosBundleId = instance.firebaseMacosBundleId;

  @override
  @EnviedField()
  final String firebaseWindowsApiKey = instance.firebaseWindowsApiKey;

  @override
  @EnviedField()
  final String firebaseWindowsAppId = instance.firebaseWindowsAppId;

  @override
  @EnviedField()
  final String firebaseWindowsMessagingSenderId =
      instance.firebaseWindowsMessagingSenderId;

  @override
  @EnviedField()
  final String firebaseWindowsProjectId = instance.firebaseWindowsProjectId;

  @override
  @EnviedField()
  final String firebaseWindowsAuthDomain = instance.firebaseWindowsAuthDomain;

  @override
  @EnviedField(optional: true)
  final String? firebaseWindowsDatabaseUrl =
      instance.firebaseWindowsDatabaseUrl;

  @override
  @EnviedField()
  final String firebaseWindowsStorageBucket =
      instance.firebaseWindowsStorageBucket;

  @override
  @EnviedField()
  final String firebaseWindowsMeasurementId =
      instance.firebaseWindowsMeasurementId;

  @override
  @EnviedField()
  final String firebaseDataConnectLocation =
      instance.firebaseDataConnectLocation;

  @override
  @EnviedField()
  final String firebaseDataConnectConnector =
      instance.firebaseDataConnectConnector;

  @override
  @EnviedField()
  final String firebaseDataConnectServiceId =
      instance.firebaseDataConnectServiceId;

  @override
  @EnviedField()
  final String recaptchaSiteKey = instance.recaptchaSiteKey;

  @override
  @EnviedField()
  final String recaptchaSecretKey = instance.recaptchaSecretKey;
}
