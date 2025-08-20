enum BorderRadii {
  none(value: 0),
  xs(value: 4),
  sm(value: 8),
  md(value: 12),
  lg(value: 16),
  xl(value: 20),
  xxl(value: 24);

  const BorderRadii({required this.value});

  final double value;
}
