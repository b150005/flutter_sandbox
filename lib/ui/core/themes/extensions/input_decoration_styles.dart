import 'package:flutter/material.dart';

import '../../../../core/config/constants/border.dart';
import '../../../../core/config/constants/colors.dart';
import '../../../../core/config/constants/sizes.dart';

@immutable
class InputDecorationStyles extends ThemeExtension<InputDecorationStyles> {
  const InputDecorationStyles({
    required this.outlined,
    required this.filled,
    required this.underlined,
    required this.search,
    required this.compact,
  });

  InputDecorationStyles.light(BuildContext context)
    : outlined = InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: Spacing.sm.dp,
          vertical: Spacing.sm.dp,
        ),
        hintStyle: TextStyle(
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: AlphaChannel.medium.value),
        ),
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: 12,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withValues(
              alpha: AlphaChannel.extraLight.value,
            ),
            width: BorderWidth.thin.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: BorderWidth.thin.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
      ),
      filled = InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest
            .withValues(alpha: AlphaChannel.light.value),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Spacing.sm.dp,
          vertical: Spacing.sm.dp,
        ),
        hintStyle: TextStyle(
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: AlphaChannel.medium.value),
        ),
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: 12,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
      ),
      underlined = InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: Spacing.xs.dp,
          vertical: Spacing.sm.dp,
        ),
        hintStyle: TextStyle(
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: AlphaChannel.medium.value),
        ),
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: 12,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: BorderWidth.thin.value,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.medium.value,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: BorderWidth.medium.value,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.medium.value,
          ),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withValues(
              alpha: AlphaChannel.extraLight.value,
            ),
            width: BorderWidth.thin.value,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: BorderWidth.thin.value,
          ),
        ),
      ),
      search = InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest
            .withValues(alpha: AlphaChannel.extraLight.value),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Spacing.sm.dp,
          vertical: Spacing.sm.dp,
        ),
        hintStyle: TextStyle(
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: AlphaChannel.medium.value),
        ),
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: 12,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: AlphaChannel.medium.value),
          size: IconSize.xs.iconSize,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(BorderRadii.xl.value),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.xl.value),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.xl.value),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.xl.value),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(BorderRadii.xl.value),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(BorderRadii.xl.value),
        ),
      ),
      compact = InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: Spacing.xs.dp,
          vertical: Spacing.xs.dp,
        ),
        hintStyle: TextStyle(
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: AlphaChannel.medium.value),
          fontSize: 14,
        ),
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 14,
        ),
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: 11,
        ),
        isDense: true,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.thin.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.xs.value),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: BorderWidth.thin.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.xs.value),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.thin.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.xs.value),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withValues(
              alpha: AlphaChannel.extraLight.value,
            ),
            width: BorderWidth.thin.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.xs.value),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: BorderWidth.thin.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.xs.value),
        ),
      );

  InputDecorationStyles.dark(BuildContext context)
    : outlined = InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: Spacing.sm.dp,
          vertical: Spacing.sm.dp,
        ),
        hintStyle: TextStyle(
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: AlphaChannel.medium.value),
        ),
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: 12,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withValues(
              alpha: AlphaChannel.extraLight.value,
            ),
            width: BorderWidth.thin.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: BorderWidth.thin.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
      ),
      filled = InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest
            .withValues(alpha: AlphaChannel.medium.value),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Spacing.sm.dp,
          vertical: Spacing.sm.dp,
        ),
        hintStyle: TextStyle(
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: AlphaChannel.medium.value),
        ),
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: 12,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(BorderRadii.sm.value),
        ),
      ),
      underlined = InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: Spacing.xs.dp,
          vertical: Spacing.sm.dp,
        ),
        hintStyle: TextStyle(
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: AlphaChannel.medium.value),
        ),
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: 12,
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: BorderWidth.thin.value,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.medium.value,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: BorderWidth.medium.value,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.medium.value,
          ),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withValues(
              alpha: AlphaChannel.extraLight.value,
            ),
            width: BorderWidth.thin.value,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: BorderWidth.thin.value,
          ),
        ),
      ),
      search = InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest
            .withValues(alpha: AlphaChannel.light.value),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Spacing.sm.dp,
          vertical: Spacing.sm.dp,
        ),
        hintStyle: TextStyle(
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: AlphaChannel.medium.value),
        ),
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: 12,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: AlphaChannel.medium.value),
          size: IconSize.xs.iconSize,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(BorderRadii.xl.value),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.xl.value),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.xl.value),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.medium.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.xl.value),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(BorderRadii.xl.value),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(BorderRadii.xl.value),
        ),
      ),
      compact = InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: Spacing.xs.dp,
          vertical: Spacing.xs.dp,
        ),
        hintStyle: TextStyle(
          color: Theme.of(
            context,
          ).colorScheme.onSurface.withValues(alpha: AlphaChannel.medium.value),
          fontSize: 14,
        ),
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 14,
        ),
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: 11,
        ),
        isDense: true,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.thin.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.xs.value),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: BorderWidth.thin.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.xs.value),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: BorderWidth.thin.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.xs.value),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withValues(
              alpha: AlphaChannel.extraLight.value,
            ),
            width: BorderWidth.thin.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.xs.value),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: BorderWidth.thin.value,
          ),
          borderRadius: BorderRadius.circular(BorderRadii.xs.value),
        ),
      );

  final InputDecoration outlined;

  final InputDecoration filled;

  final InputDecoration underlined;

  final InputDecoration search;

  final InputDecoration compact;

  @override
  ThemeExtension<InputDecorationStyles> copyWith({
    InputDecoration? outlined,
    InputDecoration? filled,
    InputDecoration? underlined,
    InputDecoration? search,
    InputDecoration? compact,
  }) => InputDecorationStyles(
    outlined: outlined ?? this.outlined,
    filled: filled ?? this.filled,
    underlined: underlined ?? this.underlined,
    search: search ?? this.search,
    compact: compact ?? this.compact,
  );

  @override
  ThemeExtension<InputDecorationStyles> lerp(
    ThemeExtension<InputDecorationStyles>? other,
    double t,
  ) => this;
}
