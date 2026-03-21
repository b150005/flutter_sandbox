import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_number.freezed.dart';
part 'phone_number.g.dart';

@freezed
abstract class PhoneNumber with _$PhoneNumber {
  const factory PhoneNumber({
    String? countryCode,
    @Default('') String nationalNumber,
  }) = _PhoneNumber;

  factory PhoneNumber.fromJson(Map<String, dynamic> json) =>
      _$PhoneNumberFromJson(json);
}
