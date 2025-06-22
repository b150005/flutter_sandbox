import 'package:flutter/material.dart';

enum Gradients {
  subtle(
    lighterLightnessOffset: 0.08,
    lighterSaturationOffset: 0.05,
    lighterHueShift: 0,
    darkerLightnessOffset: -0.056,
    darkerSaturationOffset: -0.015,
    darkerHueShift: 0,
  ),
  vibrant(
    lighterLightnessOffset: 0.15,
    lighterSaturationOffset: 0.12,
    lighterHueShift: 20,
    darkerLightnessOffset: -0.12,
    darkerSaturationOffset: 0.12,
    darkerHueShift: -10,
  ),
  analogous(
    lighterLightnessOffset: 0.1,
    lighterSaturationOffset: 0.08,
    lighterHueShift: -25,
    darkerLightnessOffset: -0.1,
    darkerSaturationOffset: -0.04,
    darkerHueShift: 25,
  ),
  monochromatic(
    lighterLightnessOffset: 0.18,
    lighterSaturationOffset: -0.03,
    lighterHueShift: 0,
    darkerLightnessOffset: -0.18,
    darkerSaturationOffset: 0.1,
    darkerHueShift: 0,
  );

  const Gradients({
    required double lighterLightnessOffset,
    required double lighterSaturationOffset,
    required double lighterHueShift,
    required double darkerLightnessOffset,
    required double darkerSaturationOffset,
    required double darkerHueShift,
  }) : _lighterLightnessOffset = lighterLightnessOffset,
       _lighterSaturationOffset = lighterSaturationOffset,
       _lighterHueShift = lighterHueShift,
       _darkerLightnessOffset = darkerLightnessOffset,
       _darkerSaturationOffset = darkerSaturationOffset,
       _darkerHueShift = darkerHueShift;

  final double _lighterLightnessOffset;
  final double _lighterSaturationOffset;
  final double _lighterHueShift;
  final double _darkerLightnessOffset;
  final double _darkerSaturationOffset;
  final double _darkerHueShift;

  List<Color> fromColor(Color color, {double intensity = 0.6}) {
    final hsl = HSLColor.fromColor(color);
    final lighter = hsl
        .withLightness(
          (hsl.lightness + _lighterLightnessOffset * intensity).clamp(0, 1),
        )
        .withSaturation(
          (hsl.saturation + _lighterSaturationOffset * intensity).clamp(0, 1),
        )
        .withHue((hsl.hue + _lighterHueShift * intensity) % 360.0)
        .toColor();

    final darker = hsl
        .withLightness(
          (hsl.lightness + _darkerLightnessOffset * intensity).clamp(0, 1),
        )
        .withSaturation(
          (hsl.saturation + _darkerSaturationOffset * intensity).clamp(0, 1),
        )
        .withHue((hsl.hue + _darkerHueShift * intensity) % 360.0)
        .toColor();

    return [lighter, darker];
  }
}
