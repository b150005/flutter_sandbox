import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';

part 'content.freezed.dart';

@freezed
abstract class Content<T extends GoRouteData> with _$Content {
  const factory Content({
    required T route,
    required String title,
    required String description,
    String? subtitle,
    String? thumbnailPath,
  }) = _Content;
}
