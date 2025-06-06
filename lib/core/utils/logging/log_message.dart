final class LogMessage {
  const LogMessage._();

  static const firebaseNotInitialized =
      '❌ Firebase app'
      ' not properly initialized';

  static const unhandledError = '❌ Unhandled error occurred';

  static const internalError = '❌ Internal error occurred';

  static String nullObject(String objectName) => '⚠️ $objectName is null';
}
