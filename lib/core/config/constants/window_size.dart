import 'dart:ui';

enum WindowSize {
  min(size: Size(320, 480));

  const WindowSize({required this.size});

  final Size size;
  double get width => size.width;
  double get height => size.height;
}
