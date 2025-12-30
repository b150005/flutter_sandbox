final class LogMessage {
  const LogMessage._();

  static const firebaseNotInitialized =
      '❌ Firebase app'
      ' not properly initialized';

  static const internalError = '❌ Internal error occurred';

  static const invalidArgument = '❌ Invalid argument passed';

  static const canEnterWhitespace = '⚠️ Whitespace can be entered';

  static const cancelledByDebounce = '⛔️ Cancelled by debounce';

  static String unhandledError(Object? error) =>
      '❌ Unhandled error occurred, runtimeType: ${error.runtimeType}';

  static String nullObject(String objectName) => '⚠️ $objectName is null';

  static String unimplementedCode(String code) =>
      '⚠️ Unimplemented Firebase Auth error code: $code';

  static String failedToFetch(Uri uri) => 'Data fetch failed: ${uri.path}';
}
