enum Regexes {
  email(r'^[^@]+@[^@]+\.[^@]{2,}$'),
  nationalNumberCharacter(r'[0-9\s\-]'),
  whitespace(r'\s'),
  uppercase(r'[A-Z]'),
  lowercase(r'[a-z]'),
  digit(r'[0-9]');

  const Regexes(this.source);

  final String source;

  RegExp get regExp => RegExp(source);
}
