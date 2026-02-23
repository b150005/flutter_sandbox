import 'package:flutter/material.dart';

extension NullableStringExtension on String? {
  bool get isNotNullAndNotEmpty => this != null && this!.isNotEmpty;
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isTrimmedNotNullAndNotEmpty =>
      this != null && this!.trim().isNotEmpty;
  bool get isTrimmedNullOrEmpty => this == null || this!.trim().isEmpty;
}

extension StringExtension on String {
  bool get isTrimmedEmpty => trim().isEmpty;

  bool equalsLength(String value) =>
      characters.length == value.characters.length;
}
