import 'package:flutter/material.dart';

import '../../../core/config/constants/colors.dart';
import '../../../core/config/constants/sizes.dart';
import 'utils/gradients.dart';

class RoundedGradientIcon extends StatelessWidget {
  const RoundedGradientIcon({
    super.key,
    required this.icon,
    required this.primaryColor,
    this.iconColor = Colors.white,
    this.size = IconSize.md,
    this.gradients = Gradients.subtle,
  });

  final IconData icon;
  final Color iconColor;
  final Color primaryColor;
  final IconSize size;
  final Gradients gradients;

  @override
  Widget build(BuildContext context) {
    final colorGradients = gradients.fromColor(primaryColor);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colorGradients,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size.borderRadius),
        boxShadow: [
          BoxShadow(
            color: colorGradients.first.withAlpha(
              (AlphaChannel.max.value * 0.3).round(),
            ),
            blurRadius: size.blurRadius,
          ),
        ],
      ),
      width: size.dp,
      height: size.dp,
      child: Icon(icon, size: size.iconSize, color: iconColor),
    );
  }
}
