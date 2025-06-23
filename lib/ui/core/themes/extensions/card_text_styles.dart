import 'package:flutter/material.dart';

@immutable
class CardTextStyles extends ThemeExtension<CardTextStyles> {
  const CardTextStyles({
    this.titleStyle,
    this.subtitleStyle,
    this.descriptionStyle,
  });

  CardTextStyles.light(BuildContext context)
    : titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      subtitleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
      descriptionStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(
          context,
        ).colorScheme.onSurfaceVariant.withAlpha((255 * 0.8).round()),
      );

  CardTextStyles.dark(BuildContext context)
    : titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      subtitleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w500,
      ),
      descriptionStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(
          context,
        ).colorScheme.onSurfaceVariant.withAlpha((255 * 0.7).round()),
      );

  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? descriptionStyle;

  @override
  ThemeExtension<CardTextStyles> copyWith({
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    TextStyle? descriptionStyle,
  }) => CardTextStyles(
    titleStyle: titleStyle ?? this.titleStyle,
    subtitleStyle: subtitleStyle ?? this.subtitleStyle,
    descriptionStyle: descriptionStyle ?? this.descriptionStyle,
  );

  @override
  ThemeExtension<CardTextStyles> lerp(
    ThemeExtension<CardTextStyles>? other,
    double t,
  ) {
    if (other is! CardTextStyles) {
      return this;
    }

    return CardTextStyles(
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t),
      subtitleStyle: TextStyle.lerp(subtitleStyle, other.subtitleStyle, t),
      descriptionStyle: TextStyle.lerp(
        descriptionStyle,
        other.descriptionStyle,
        t,
      ),
    );
  }
}
