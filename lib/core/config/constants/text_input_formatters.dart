import 'package:flutter/services.dart';

import 'regexes.dart';

abstract final class TextInputFormatters {
  const TextInputFormatters._();

  static final noWhitespace = FilteringTextInputFormatter.deny(
    Regexes.whitespace.regExp,
  );

  static final nationalNumber = FilteringTextInputFormatter.allow(
    Regexes.nationalNumberCharacter.regExp,
  );
}
