enum AlphaChannel {
  transparen(value: 0),
  extraLight(value: 0.2),
  light(value: 0.4),
  medium(value: 0.6),
  strong(value: 0.8),
  opaque(value: 1);

  const AlphaChannel({required this.value});

  final double value;
}
