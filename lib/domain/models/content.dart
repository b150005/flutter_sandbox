import 'package:freezed_annotation/freezed_annotation.dart';

part 'content.freezed.dart';

@freezed
abstract class Content with _$Content {
  const factory Content({
    required String path,
    required String title,
    required String description,
    String? subtitle,
    String? thumbnailPath,
  }) = _Content;
}
