import 'package:flutter/material.dart';

import '../../../../core/config/constants/colors.dart';

@immutable
class TextStyles extends ThemeExtension<TextStyles> {
  const TextStyles({
    this.primaryStyle,
    this.primaryLargeStyle,
    this.primarySmallStyle,
    this.secondaryStyle,
    this.secondaryLargeStyle,
    this.secondarySmallStyle,
    this.emphasisStyle,
    this.emphasisLargeStyle,
    this.emphasisSmallStyle,
    this.mutedStyle,
    this.mutedLargeStyle,
    this.mutedSmallStyle,
    this.errorStyle,
    this.errorLargeStyle,
    this.errorSmallStyle,
    this.successStyle,
    this.successLargeStyle,
    this.successSmallStyle,
    this.warningStyle,
    this.warningLargeStyle,
    this.warningSmallStyle,
    this.linkStyle,
    this.linkLargeStyle,
    this.linkSmallStyle,
    this.inverseStyle,
    this.inverseLargeStyle,
    this.inverseSmallStyle,
  });

  TextStyles.light(BuildContext context)
    : primaryStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      primaryLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      primarySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),

      secondaryStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      secondaryLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      secondarySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),

      emphasisStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
      emphasisLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
      emphasisSmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),

      mutedStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedSmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),

      errorStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorSmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),

      successStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),
      successLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),
      successSmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),

      warningStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      warningLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      warningSmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),

      linkStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkSmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),

      inverseStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      inverseLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      inverseSmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      );

  TextStyles.dark(BuildContext context)
    : primaryStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      primaryLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      primarySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),

      secondaryStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      secondaryLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      secondarySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),

      emphasisStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
      emphasisLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
      emphasisSmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),

      mutedStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedSmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),

      errorStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorSmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),

      successStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),
      successLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),
      successSmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),

      warningStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      warningLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      warningSmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),

      linkStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkSmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),

      inverseStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      inverseLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      inverseSmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      );

  final TextStyle? primaryStyle;
  final TextStyle? primaryLargeStyle;
  final TextStyle? primarySmallStyle;

  final TextStyle? secondaryStyle;
  final TextStyle? secondaryLargeStyle;
  final TextStyle? secondarySmallStyle;

  final TextStyle? emphasisStyle;
  final TextStyle? emphasisLargeStyle;
  final TextStyle? emphasisSmallStyle;

  final TextStyle? mutedStyle;
  final TextStyle? mutedLargeStyle;
  final TextStyle? mutedSmallStyle;

  final TextStyle? errorStyle;
  final TextStyle? errorLargeStyle;
  final TextStyle? errorSmallStyle;

  final TextStyle? successStyle;
  final TextStyle? successLargeStyle;
  final TextStyle? successSmallStyle;

  final TextStyle? warningStyle;
  final TextStyle? warningLargeStyle;
  final TextStyle? warningSmallStyle;

  final TextStyle? linkStyle;
  final TextStyle? linkLargeStyle;
  final TextStyle? linkSmallStyle;

  final TextStyle? inverseStyle;
  final TextStyle? inverseLargeStyle;
  final TextStyle? inverseSmallStyle;

  @override
  ThemeExtension<TextStyles> copyWith({
    TextStyle? primaryStyle,
    TextStyle? primaryLargeStyle,
    TextStyle? primarySmallStyle,
    TextStyle? secondaryStyle,
    TextStyle? secondaryLargeStyle,
    TextStyle? secondarySmallStyle,
    TextStyle? emphasisStyle,
    TextStyle? emphasisLargeStyle,
    TextStyle? emphasisSmallStyle,
    TextStyle? mutedStyle,
    TextStyle? mutedLargeStyle,
    TextStyle? mutedSmallStyle,
    TextStyle? errorStyle,
    TextStyle? errorLargeStyle,
    TextStyle? errorSmallStyle,
    TextStyle? successStyle,
    TextStyle? successLargeStyle,
    TextStyle? successSmallStyle,
    TextStyle? warningStyle,
    TextStyle? warningLargeStyle,
    TextStyle? warningSmallStyle,
    TextStyle? linkStyle,
    TextStyle? linkLargeStyle,
    TextStyle? linkSmallStyle,
    TextStyle? inverseStyle,
    TextStyle? inverseLargeStyle,
    TextStyle? inverseSmallStyle,
  }) => TextStyles(
    primaryStyle: primaryStyle ?? this.primaryStyle,
    primaryLargeStyle: primaryLargeStyle ?? this.primaryLargeStyle,
    primarySmallStyle: primarySmallStyle ?? this.primarySmallStyle,
    secondaryStyle: secondaryStyle ?? this.secondaryStyle,
    secondaryLargeStyle: secondaryLargeStyle ?? this.secondaryLargeStyle,
    secondarySmallStyle: secondarySmallStyle ?? this.secondarySmallStyle,
    emphasisStyle: emphasisStyle ?? this.emphasisStyle,
    emphasisLargeStyle: emphasisLargeStyle ?? this.emphasisLargeStyle,
    emphasisSmallStyle: emphasisSmallStyle ?? this.emphasisSmallStyle,
    mutedStyle: mutedStyle ?? this.mutedStyle,
    mutedLargeStyle: mutedLargeStyle ?? this.mutedLargeStyle,
    mutedSmallStyle: mutedSmallStyle ?? this.mutedSmallStyle,
    errorStyle: errorStyle ?? this.errorStyle,
    errorLargeStyle: errorLargeStyle ?? this.errorLargeStyle,
    errorSmallStyle: errorSmallStyle ?? this.errorSmallStyle,
    successStyle: successStyle ?? this.successStyle,
    successLargeStyle: successLargeStyle ?? this.successLargeStyle,
    successSmallStyle: successSmallStyle ?? this.successSmallStyle,
    warningStyle: warningStyle ?? this.warningStyle,
    warningLargeStyle: warningLargeStyle ?? this.warningLargeStyle,
    warningSmallStyle: warningSmallStyle ?? this.warningSmallStyle,
    linkStyle: linkStyle ?? this.linkStyle,
    linkLargeStyle: linkLargeStyle ?? this.linkLargeStyle,
    linkSmallStyle: linkSmallStyle ?? this.linkSmallStyle,
    inverseStyle: inverseStyle ?? this.inverseStyle,
    inverseLargeStyle: inverseLargeStyle ?? this.inverseLargeStyle,
    inverseSmallStyle: inverseSmallStyle ?? this.inverseSmallStyle,
  );

  @override
  ThemeExtension<TextStyles> lerp(ThemeExtension<TextStyles>? other, double t) {
    if (other is! TextStyles) {
      return this;
    }

    return TextStyles(
      primaryStyle: TextStyle.lerp(primaryStyle, other.primaryStyle, t),
      primaryLargeStyle: TextStyle.lerp(
        primaryLargeStyle,
        other.primaryLargeStyle,
        t,
      ),
      primarySmallStyle: TextStyle.lerp(
        primarySmallStyle,
        other.primarySmallStyle,
        t,
      ),
      secondaryStyle: TextStyle.lerp(secondaryStyle, other.secondaryStyle, t),
      secondaryLargeStyle: TextStyle.lerp(
        secondaryLargeStyle,
        other.secondaryLargeStyle,
        t,
      ),
      secondarySmallStyle: TextStyle.lerp(
        secondarySmallStyle,
        other.secondarySmallStyle,
        t,
      ),
      emphasisStyle: TextStyle.lerp(emphasisStyle, other.emphasisStyle, t),
      emphasisLargeStyle: TextStyle.lerp(
        emphasisLargeStyle,
        other.emphasisLargeStyle,
        t,
      ),
      emphasisSmallStyle: TextStyle.lerp(
        emphasisSmallStyle,
        other.emphasisSmallStyle,
        t,
      ),
      mutedStyle: TextStyle.lerp(mutedStyle, other.mutedStyle, t),
      mutedLargeStyle: TextStyle.lerp(
        mutedLargeStyle,
        other.mutedLargeStyle,
        t,
      ),
      mutedSmallStyle: TextStyle.lerp(
        mutedSmallStyle,
        other.mutedSmallStyle,
        t,
      ),
      errorStyle: TextStyle.lerp(errorStyle, other.errorStyle, t),
      errorLargeStyle: TextStyle.lerp(
        errorLargeStyle,
        other.errorLargeStyle,
        t,
      ),
      errorSmallStyle: TextStyle.lerp(
        errorSmallStyle,
        other.errorSmallStyle,
        t,
      ),
      successStyle: TextStyle.lerp(successStyle, other.successStyle, t),
      successLargeStyle: TextStyle.lerp(
        successLargeStyle,
        other.successLargeStyle,
        t,
      ),
      successSmallStyle: TextStyle.lerp(
        successSmallStyle,
        other.successSmallStyle,
        t,
      ),
      warningStyle: TextStyle.lerp(warningStyle, other.warningStyle, t),
      warningLargeStyle: TextStyle.lerp(
        warningLargeStyle,
        other.warningLargeStyle,
        t,
      ),
      warningSmallStyle: TextStyle.lerp(
        warningSmallStyle,
        other.warningSmallStyle,
        t,
      ),
      linkStyle: TextStyle.lerp(linkStyle, other.linkStyle, t),
      linkLargeStyle: TextStyle.lerp(linkLargeStyle, other.linkLargeStyle, t),
      linkSmallStyle: TextStyle.lerp(linkSmallStyle, other.linkSmallStyle, t),
      inverseStyle: TextStyle.lerp(inverseStyle, other.inverseStyle, t),
      inverseLargeStyle: TextStyle.lerp(
        inverseLargeStyle,
        other.inverseLargeStyle,
        t,
      ),
      inverseSmallStyle: TextStyle.lerp(
        inverseSmallStyle,
        other.inverseSmallStyle,
        t,
      ),
    );
  }
}
