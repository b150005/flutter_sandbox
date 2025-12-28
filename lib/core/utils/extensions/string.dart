extension NullableString on String? {
  bool get isNotNullAndNotEmpty => this != null && this!.isNotEmpty;
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isTrimmedNotNullAndNotEmpty =>
      this != null && this!.trim().isNotEmpty;
  bool get isTrimmedNullOrEmpty => this == null || this!.trim().isEmpty;
}

extension EmptyString on String {
  bool get isTrimmedEmpty => trim().isEmpty;
}
