import 'dart:ui';

enum ButtonSize {
  xs(size: Size(64, 24)),
  sm(size: Size(96, 32)),
  md(size: Size(128, 40)),
  lg(size: Size(160, 48)),
  xl(size: Size(192, 56));

  const ButtonSize({required this.size});

  final Size size;

  Size get fullWidth => Size(double.maxFinite, size.height);
}
