abstract final class Regexes {
  const Regexes._();

  static final email = RegExp(r'^[^@]+@[^@]+\.[^@]{2,}$');

  static final whitespace = RegExp(r'\s');
  static final uppercase = RegExp(r'[A-Z]');
  static final lowercase = RegExp(r'[a-z]');
  static final number = RegExp(r'[0-9]');
}
