import 'dart:convert';

import '../../../domain/models/phone_number.dart';
import '../../utils/logging/log_message.dart';

class AppExtraCodec extends Codec<Object?, Object?> {
  const AppExtraCodec();

  @override
  Converter<Object?, Object?> get encoder => const _AppExtraEncoder();

  @override
  Converter<Object?, Object?> get decoder => const _AppExtraDecoder();
}

class _AppExtraEncoder extends Converter<Object?, Object?> {
  const _AppExtraEncoder();

  @override
  Object? convert(Object? input) => switch (input) {
    null => null,
    PhoneNumber _ => {PhoneNumber.extraKey: input.toJson()},
    _ => throw FormatException(LogMessage.unsupportedExtraType(input), input),
  };
}

class _AppExtraDecoder extends Converter<Object?, Object?> {
  const _AppExtraDecoder();

  @override
  Object? convert(Object? input) => switch (input) {
    null => null,
    {PhoneNumber.extraKey: final Map<String, dynamic> json} =>
      PhoneNumber.fromJson(json),
    _ => throw FormatException(LogMessage.unsupportedExtraType(input), input),
  };
}
