extension HardcodedString on String {
  @Deprecated('TODO: Replace hardcoded string with AppLocalizations')
  String get hardcoded => this;
}

extension NullableString on String? {
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
