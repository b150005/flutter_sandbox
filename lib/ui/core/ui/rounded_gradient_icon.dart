import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../core/config/constants/alpha_channel.dart';
import '../../../core/config/constants/icon_size.dart';
import 'utils/gradients.dart';

@Preview(name: 'RoundedGradientIcon')
Widget roundedGradientIcon() => const Column(
  spacing: 8,
  children: [
    RoundedGradientIcon(
      icon: Icons.home_rounded,
      primaryColor: Colors.blue,
    ),
    RoundedGradientIcon(
      icon: Icons.favorite_rounded,
      primaryColor: Colors.red,
      gradients: Gradients.analogous,
    ),
    RoundedGradientIcon(
      icon: Icons.notifications_rounded,
      primaryColor: Colors.yellow,
      gradients: Gradients.monochromatic,
    ),
    RoundedGradientIcon(
      icon: Icons.shopping_cart_rounded,
      primaryColor: Colors.green,
      gradients: Gradients.vibrant,
    ),
    RoundedGradientIcon(
      icon: Icons.settings_rounded,
      primaryColor: Colors.grey,
    ),
  ],
);

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
            color: colorGradients.first.withValues(
              alpha: AlphaChannel.light.value,
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
