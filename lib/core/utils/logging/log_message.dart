final class LogMessage {
  const LogMessage._();

  static const firebaseNotInitialized =
      '❌ Firebase app'
      ' not properly initialized';

  static const unhandledError = '❌ Unhandled error occurred';

  static const internalError = '❌ Internal error occurred';

  static const invalidArgument = '❌ Invalid argument passed';

  static const canEnterWhitespace = '⚠️ Whitespace can be entered';

  static const cancelledByDebounce = '⛔️ Cancelled by debounce';

  static String nullObject(String objectName) => '⚠️ $objectName is null';
}
