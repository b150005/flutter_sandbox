final class LogMessage {
  const LogMessage._();

  static const firebaseNotInitialized = 'Firebase initialization missing';

  static const unhandledError = 'Unhandled error occurred';

  static const internalError = 'Internal error occurred';

  static String nullObject(String objectName) => '$objectName is null';
}
