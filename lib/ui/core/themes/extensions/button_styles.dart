import 'package:flutter/material.dart';

import '../../../../core/config/constants/border.dart';
import '../../../../core/config/constants/colors.dart';
import '../../../../core/config/constants/sizes.dart';

@immutable
class ButtonStyles extends ThemeExtension<ButtonStyles> {
  const ButtonStyles({
    required this.primary,
    required this.secondary,
    required this.outlined,
    required this.text,
    required this.destructive,
    required this.ghost,
    required this.link,
  });

  ButtonStyles.light(BuildContext context)
    : primary = ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shadowColor: Theme.of(
          context,
        ).colorScheme.shadow.withValues(alpha: AlphaChannel.light.value),
        elevation: 2,
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.md.dp,
          vertical: Spacing.sm.dp,
        ),
        minimumSize: ButtonSize.sm.size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
      ),
      secondary = ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shadowColor: Theme.of(
          context,
        ).colorScheme.shadow.withValues(alpha: AlphaChannel.light.value),
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.md.dp,
          vertical: Spacing.sm.dp,
        ),
        minimumSize: ButtonSize.sm.size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
      ),
      outlined = OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.md.dp,
          vertical: Spacing.sm.dp,
        ),
        minimumSize: ButtonSize.sm.size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: BorderWidth.thin.value,
        ),
      ),
      text = TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.sm.dp,
          vertical: Spacing.xs.dp,
        ),
        minimumSize: ButtonSize.xs.size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.xs.value),
        ),
      ),
      destructive = ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onError,
        backgroundColor: Theme.of(context).colorScheme.error,
        shadowColor: Theme.of(
          context,
        ).colorScheme.shadow.withValues(alpha: AlphaChannel.light.value),
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.md.dp,
          vertical: Spacing.sm.dp,
        ),
        minimumSize: ButtonSize.sm.size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
      ),
      ghost = TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.md.dp,
          vertical: Spacing.sm.dp,
        ),
        minimumSize: ButtonSize.sm.size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
      ),
      link = TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.xs.dp,
          vertical: Spacing.xxs.dp,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.xs.value),
        ),
      );

  ButtonStyles.dark(BuildContext context)
    : primary = ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shadowColor: Theme.of(
          context,
        ).colorScheme.shadow.withValues(alpha: AlphaChannel.medium.value),
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.md.dp,
          vertical: Spacing.sm.dp,
        ),
        minimumSize: ButtonSize.sm.size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
      ),
      secondary = ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shadowColor: Theme.of(
          context,
        ).colorScheme.shadow.withValues(alpha: AlphaChannel.medium.value),
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.md.dp,
          vertical: Spacing.sm.dp,
        ),
        minimumSize: ButtonSize.sm.size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
      ),
      outlined = OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.md.dp,
          vertical: Spacing.sm.dp,
        ),
        minimumSize: ButtonSize.sm.size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: BorderWidth.thin.value,
        ),
      ),
      text = TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.sm.dp,
          vertical: Spacing.xs.dp,
        ),
        minimumSize: ButtonSize.xs.size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.xs.value),
        ),
      ),
      destructive = ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onError,
        backgroundColor: Theme.of(context).colorScheme.error,
        shadowColor: Theme.of(
          context,
        ).colorScheme.shadow.withValues(alpha: AlphaChannel.medium.value),
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.md.dp,
          vertical: Spacing.sm.dp,
        ),
        minimumSize: ButtonSize.sm.size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
      ),
      ghost = TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.md.dp,
          vertical: Spacing.sm.dp,
        ),
        minimumSize: ButtonSize.sm.size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
      ),
      link = TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: Spacing.xs.dp,
          vertical: Spacing.xxs.dp,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BorderRadii.xs.value),
        ),
      );

  final ButtonStyle primary;

  final ButtonStyle secondary;

  final ButtonStyle outlined;

  final ButtonStyle text;

  final ButtonStyle destructive;

  final ButtonStyle ghost;

  final ButtonStyle link;

  @override
  ThemeExtension<ButtonStyles> copyWith({
    ButtonStyle? primary,
    ButtonStyle? secondary,
    ButtonStyle? outlined,
    ButtonStyle? text,
    ButtonStyle? destructive,
    ButtonStyle? ghost,
    ButtonStyle? link,
  }) => ButtonStyles(
    primary: primary ?? this.primary,
    secondary: secondary ?? this.secondary,
    outlined: outlined ?? this.outlined,
    text: text ?? this.text,
    destructive: destructive ?? this.destructive,
    ghost: ghost ?? this.ghost,
    link: link ?? this.link,
  );

  @override
  ThemeExtension<ButtonStyles> lerp(
    ThemeExtension<ButtonStyles>? other,
    double t,
  ) {
    if (other is! ButtonStyles) {
      return this;
    }

    return ButtonStyles(
      primary: ButtonStyle.lerp(primary, other.primary, t)!,
      secondary: ButtonStyle.lerp(secondary, other.secondary, t)!,
      outlined: ButtonStyle.lerp(outlined, other.outlined, t)!,
      text: ButtonStyle.lerp(text, other.text, t)!,
      destructive: ButtonStyle.lerp(destructive, other.destructive, t)!,
      ghost: ButtonStyle.lerp(ghost, other.ghost, t)!,
      link: ButtonStyle.lerp(link, other.link, t)!,
    );
  }
}
