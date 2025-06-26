import 'package:flutter/material.dart';

import '../../../../core/config/constants/colors.dart';
import '../../../../core/config/constants/sizes.dart';

@immutable
class IconButtonStyles extends ThemeExtension<IconButtonStyles> {
  const IconButtonStyles({
    required this.standard,
    required this.filled,
    required this.filledTonal,
    required this.outlined,
    required this.calloutDismiss,
  });

  IconButtonStyles.light(BuildContext context)
    : standard = IconButton.styleFrom(
        iconSize: IconSize.md.iconSize,
        foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        overlayColor: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.extraLight.value,
        ),
      ),
      filled = IconButton.styleFrom(
        iconSize: IconSize.md.iconSize,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        overlayColor: Theme.of(context).colorScheme.onPrimary.withValues(
          alpha: AlphaChannel.extraLight.value,
        ),
      ),
      filledTonal = IconButton.styleFrom(
        iconSize: IconSize.md.iconSize,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        overlayColor: Theme.of(context).colorScheme.onSecondaryContainer
            .withValues(alpha: AlphaChannel.extraLight.value),
      ),
      outlined = IconButton.styleFrom(
        iconSize: IconSize.md.iconSize,
        foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
        overlayColor: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.extraLight.value,
        ),
      ),
      calloutDismiss = IconButton.styleFrom(
        iconSize: IconSize.lg.iconSize,
        foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        overlayColor: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.extraLight.value,
        ),
        shape: const CircleBorder(),
      );

  IconButtonStyles.dark(BuildContext context)
    : standard = IconButton.styleFrom(
        iconSize: IconSize.md.iconSize,
        foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        overlayColor: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.extraLight.value,
        ),
      ),
      filled = IconButton.styleFrom(
        iconSize: IconSize.md.iconSize,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        overlayColor: Theme.of(context).colorScheme.onPrimary.withValues(
          alpha: AlphaChannel.extraLight.value,
        ),
      ),
      filledTonal = IconButton.styleFrom(
        iconSize: IconSize.md.iconSize,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        overlayColor: Theme.of(context).colorScheme.onSecondaryContainer
            .withValues(alpha: AlphaChannel.extraLight.value),
      ),
      outlined = IconButton.styleFrom(
        iconSize: IconSize.md.iconSize,
        foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
        overlayColor: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.extraLight.value,
        ),
      ),
      calloutDismiss = IconButton.styleFrom(
        iconSize: IconSize.lg.iconSize,
        foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
        overlayColor: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.extraLight.value,
        ),
        shape: const CircleBorder(),
      );

  final ButtonStyle standard;

  final ButtonStyle filled;

  final ButtonStyle filledTonal;

  final ButtonStyle outlined;

  final ButtonStyle calloutDismiss;

  @override
  ThemeExtension<IconButtonStyles> copyWith({
    ButtonStyle? standard,
    ButtonStyle? filled,
    ButtonStyle? filledTonal,
    ButtonStyle? outlined,
    ButtonStyle? calloutDismiss,
  }) => IconButtonStyles(
    standard: standard ?? this.standard,
    filled: filled ?? this.filled,
    filledTonal: filledTonal ?? this.filledTonal,
    outlined: outlined ?? this.outlined,
    calloutDismiss: calloutDismiss ?? this.calloutDismiss,
  );

  @override
  ThemeExtension<IconButtonStyles> lerp(
    ThemeExtension<IconButtonStyles>? other,
    double t,
  ) {
    if (other is! IconButtonStyles) {
      return this;
    }

    return IconButtonStyles(
      standard: ButtonStyle.lerp(standard, other.standard, t)!,
      filled: ButtonStyle.lerp(filled, other.filled, t)!,
      filledTonal: ButtonStyle.lerp(filledTonal, other.filledTonal, t)!,
      outlined: ButtonStyle.lerp(outlined, other.outlined, t)!,
      calloutDismiss: ButtonStyle.lerp(
        calloutDismiss,
        other.calloutDismiss,
        t,
      )!,
    );
  }
}
