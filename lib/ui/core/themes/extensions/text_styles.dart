import 'package:flutter/material.dart';

import '../../../../core/config/constants/alpha_channel.dart';

@immutable
class TextStyles extends ThemeExtension<TextStyles> {
  const TextStyles({
    this.primaryBodyMediumStyle,
    this.primaryBodyLargeStyle,
    this.primaryBodySmallStyle,
    this.primaryDisplayLargeStyle,
    this.primaryDisplayMediumStyle,
    this.primaryDisplaySmallStyle,
    this.primaryHeadlineLargeStyle,
    this.primaryHeadlineMediumStyle,
    this.primaryHeadlineSmallStyle,
    this.primaryTitleLargeStyle,
    this.primaryTitleMediumStyle,
    this.primaryTitleSmallStyle,
    this.primaryLabelLargeStyle,
    this.primaryLabelMediumStyle,
    this.primaryLabelSmallStyle,
    this.secondaryBodyMediumStyle,
    this.secondaryBodyLargeStyle,
    this.secondaryBodySmallStyle,
    this.secondaryDisplayLargeStyle,
    this.secondaryDisplayMediumStyle,
    this.secondaryDisplaySmallStyle,
    this.secondaryHeadlineLargeStyle,
    this.secondaryHeadlineMediumStyle,
    this.secondaryHeadlineSmallStyle,
    this.secondaryTitleLargeStyle,
    this.secondaryTitleMediumStyle,
    this.secondaryTitleSmallStyle,
    this.secondaryLabelLargeStyle,
    this.secondaryLabelMediumStyle,
    this.secondaryLabelSmallStyle,
    this.emphasisBodyMediumStyle,
    this.emphasisBodyLargeStyle,
    this.emphasisBodySmallStyle,
    this.emphasisDisplayLargeStyle,
    this.emphasisDisplayMediumStyle,
    this.emphasisDisplaySmallStyle,
    this.emphasisHeadlineLargeStyle,
    this.emphasisHeadlineMediumStyle,
    this.emphasisHeadlineSmallStyle,
    this.emphasisTitleLargeStyle,
    this.emphasisTitleMediumStyle,
    this.emphasisTitleSmallStyle,
    this.emphasisLabelLargeStyle,
    this.emphasisLabelMediumStyle,
    this.emphasisLabelSmallStyle,
    this.mutedBodyMediumStyle,
    this.mutedBodyLargeStyle,
    this.mutedBodySmallStyle,
    this.mutedDisplayLargeStyle,
    this.mutedDisplayMediumStyle,
    this.mutedDisplaySmallStyle,
    this.mutedHeadlineLargeStyle,
    this.mutedHeadlineMediumStyle,
    this.mutedHeadlineSmallStyle,
    this.mutedTitleLargeStyle,
    this.mutedTitleMediumStyle,
    this.mutedTitleSmallStyle,
    this.mutedLabelLargeStyle,
    this.mutedLabelMediumStyle,
    this.mutedLabelSmallStyle,
    this.errorBodyMediumStyle,
    this.errorBodyLargeStyle,
    this.errorBodySmallStyle,
    this.errorDisplayLargeStyle,
    this.errorDisplayMediumStyle,
    this.errorDisplaySmallStyle,
    this.errorHeadlineLargeStyle,
    this.errorHeadlineMediumStyle,
    this.errorHeadlineSmallStyle,
    this.errorTitleLargeStyle,
    this.errorTitleMediumStyle,
    this.errorTitleSmallStyle,
    this.errorLabelLargeStyle,
    this.errorLabelMediumStyle,
    this.errorLabelSmallStyle,
    this.successBodyMediumStyle,
    this.successBodyLargeStyle,
    this.successBodySmallStyle,
    this.successDisplayLargeStyle,
    this.successDisplayMediumStyle,
    this.successDisplaySmallStyle,
    this.successHeadlineLargeStyle,
    this.successHeadlineMediumStyle,
    this.successHeadlineSmallStyle,
    this.successTitleLargeStyle,
    this.successTitleMediumStyle,
    this.successTitleSmallStyle,
    this.successLabelLargeStyle,
    this.successLabelMediumStyle,
    this.successLabelSmallStyle,
    this.warningBodyMediumStyle,
    this.warningBodyLargeStyle,
    this.warningBodySmallStyle,
    this.warningDisplayLargeStyle,
    this.warningDisplayMediumStyle,
    this.warningDisplaySmallStyle,
    this.warningHeadlineLargeStyle,
    this.warningHeadlineMediumStyle,
    this.warningHeadlineSmallStyle,
    this.warningTitleLargeStyle,
    this.warningTitleMediumStyle,
    this.warningTitleSmallStyle,
    this.warningLabelLargeStyle,
    this.warningLabelMediumStyle,
    this.warningLabelSmallStyle,
    this.linkBodyMediumStyle,
    this.linkBodyLargeStyle,
    this.linkBodySmallStyle,
    this.linkDisplayLargeStyle,
    this.linkDisplayMediumStyle,
    this.linkDisplaySmallStyle,
    this.linkHeadlineLargeStyle,
    this.linkHeadlineMediumStyle,
    this.linkHeadlineSmallStyle,
    this.linkTitleLargeStyle,
    this.linkTitleMediumStyle,
    this.linkTitleSmallStyle,
    this.linkLabelLargeStyle,
    this.linkLabelMediumStyle,
    this.linkLabelSmallStyle,
    this.inverseBodyMediumStyle,
    this.inverseBodyLargeStyle,
    this.inverseBodySmallStyle,
    this.inverseDisplayLargeStyle,
    this.inverseDisplayMediumStyle,
    this.inverseDisplaySmallStyle,
    this.inverseHeadlineLargeStyle,
    this.inverseHeadlineMediumStyle,
    this.inverseHeadlineSmallStyle,
    this.inverseTitleLargeStyle,
    this.inverseTitleMediumStyle,
    this.inverseTitleSmallStyle,
    this.inverseLabelLargeStyle,
    this.inverseLabelMediumStyle,
    this.inverseLabelSmallStyle,
  });

  TextStyles.light(BuildContext context)
    : primaryBodyMediumStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      primaryBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      primaryBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      primaryDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      primaryDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      primaryDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      primaryHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      primaryHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      primaryHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      primaryTitleLargeStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      primaryTitleMediumStyle = Theme.of(context).textTheme.titleMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      primaryTitleSmallStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      primaryLabelLargeStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      primaryLabelMediumStyle = Theme.of(context).textTheme.labelMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      primaryLabelSmallStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),

      secondaryBodyMediumStyle = Theme.of(context).textTheme.bodyMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      secondaryBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      secondaryDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryTitleLargeStyle = Theme.of(context).textTheme.titleLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryTitleMediumStyle = Theme.of(context).textTheme.titleMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryTitleSmallStyle = Theme.of(context).textTheme.titleSmall
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryLabelLargeStyle = Theme.of(context).textTheme.labelLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryLabelMediumStyle = Theme.of(context).textTheme.labelMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryLabelSmallStyle = Theme.of(context).textTheme.labelSmall
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),

      emphasisBodyMediumStyle = Theme.of(context).textTheme.bodyMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
      emphasisBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
      emphasisDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisTitleLargeStyle = Theme.of(context).textTheme.titleLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisTitleMediumStyle = Theme.of(context).textTheme.titleMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisTitleSmallStyle = Theme.of(context).textTheme.titleSmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisLabelLargeStyle = Theme.of(context).textTheme.labelLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisLabelMediumStyle = Theme.of(context).textTheme.labelMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisLabelSmallStyle = Theme.of(context).textTheme.labelSmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),

      mutedBodyMediumStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
              alpha: AlphaChannel.medium.value,
            ),
          ),
      mutedDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
              alpha: AlphaChannel.medium.value,
            ),
          ),
      mutedDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
              alpha: AlphaChannel.medium.value,
            ),
          ),
      mutedHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
              alpha: AlphaChannel.medium.value,
            ),
          ),
      mutedHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
              alpha: AlphaChannel.medium.value,
            ),
          ),
      mutedHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
              alpha: AlphaChannel.medium.value,
            ),
          ),
      mutedTitleLargeStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedTitleMediumStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedTitleSmallStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedLabelLargeStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedLabelMediumStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedLabelSmallStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),

      errorBodyMediumStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
      errorDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
      errorDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
      errorHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
      errorHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
      errorHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
      errorTitleLargeStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorTitleMediumStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorTitleSmallStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorLabelLargeStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorLabelMediumStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorLabelSmallStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),

      successBodyMediumStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),
      successBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),
      successBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),
      successDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
      successDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
      successDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
      successHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
      successHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
      successHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
      successTitleLargeStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),
      successTitleMediumStyle = Theme.of(context).textTheme.titleMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
      successTitleSmallStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),
      successLabelLargeStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),
      successLabelMediumStyle = Theme.of(context).textTheme.labelMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
      successLabelSmallStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),

      warningBodyMediumStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      warningBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      warningBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      warningDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
      warningDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
      warningDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
      warningHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
      warningHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
      warningHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
      warningTitleLargeStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      warningTitleMediumStyle = Theme.of(context).textTheme.titleMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
      warningTitleSmallStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      warningLabelLargeStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      warningLabelMediumStyle = Theme.of(context).textTheme.labelMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
      warningLabelSmallStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),

      linkBodyMediumStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
      linkDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
      linkDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
      linkHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
      linkHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
      linkHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
      linkTitleLargeStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkTitleMediumStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkTitleSmallStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkLabelLargeStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkLabelMediumStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkLabelSmallStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),

      inverseBodyMediumStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      inverseBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      inverseBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      inverseDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      inverseDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      inverseDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      inverseHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      inverseHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      inverseHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      inverseTitleLargeStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      inverseTitleMediumStyle = Theme.of(context).textTheme.titleMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      inverseTitleSmallStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      inverseLabelLargeStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      inverseLabelMediumStyle = Theme.of(context).textTheme.labelMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      inverseLabelSmallStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      );

  TextStyles.dark(BuildContext context)
    : primaryBodyMediumStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      primaryBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      primaryBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      primaryDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      primaryDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      primaryDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      primaryHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      primaryHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      primaryHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      primaryTitleLargeStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      primaryTitleMediumStyle = Theme.of(context).textTheme.titleMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      primaryTitleSmallStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      primaryLabelLargeStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      primaryLabelMediumStyle = Theme.of(context).textTheme.labelMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      primaryLabelSmallStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),

      secondaryBodyMediumStyle = Theme.of(context).textTheme.bodyMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      secondaryBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      secondaryDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryTitleLargeStyle = Theme.of(context).textTheme.titleLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryTitleMediumStyle = Theme.of(context).textTheme.titleMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryTitleSmallStyle = Theme.of(context).textTheme.titleSmall
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryLabelLargeStyle = Theme.of(context).textTheme.labelLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryLabelMediumStyle = Theme.of(context).textTheme.labelMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      secondaryLabelSmallStyle = Theme.of(context).textTheme.labelSmall
          ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),

      emphasisBodyMediumStyle = Theme.of(context).textTheme.bodyMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
      emphasisBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
      emphasisDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisTitleLargeStyle = Theme.of(context).textTheme.titleLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisTitleMediumStyle = Theme.of(context).textTheme.titleMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisTitleSmallStyle = Theme.of(context).textTheme.titleSmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisLabelLargeStyle = Theme.of(context).textTheme.labelLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisLabelMediumStyle = Theme.of(context).textTheme.labelMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
      emphasisLabelSmallStyle = Theme.of(context).textTheme.labelSmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),

      mutedBodyMediumStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
              alpha: AlphaChannel.medium.value,
            ),
          ),
      mutedDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
              alpha: AlphaChannel.medium.value,
            ),
          ),
      mutedDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
              alpha: AlphaChannel.medium.value,
            ),
          ),
      mutedHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
              alpha: AlphaChannel.medium.value,
            ),
          ),
      mutedHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
              alpha: AlphaChannel.medium.value,
            ),
          ),
      mutedHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
              alpha: AlphaChannel.medium.value,
            ),
          ),
      mutedTitleLargeStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedTitleMediumStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedTitleSmallStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedLabelLargeStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedLabelMediumStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),
      mutedLabelSmallStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(
          alpha: AlphaChannel.medium.value,
        ),
      ),

      errorBodyMediumStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
      errorDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
      errorDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
      errorHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
      errorHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
      errorHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w500,
          ),
      errorTitleLargeStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorTitleMediumStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorTitleSmallStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorLabelLargeStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorLabelMediumStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
      errorLabelSmallStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w500,
      ),

      successBodyMediumStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),
      successBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),
      successBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),
      successDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
      successDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
      successDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
      successHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
      successHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
      successHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
      successTitleLargeStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),
      successTitleMediumStyle = Theme.of(context).textTheme.titleMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
      successTitleSmallStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),
      successLabelLargeStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),
      successLabelMediumStyle = Theme.of(context).textTheme.labelMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.w500,
          ),
      successLabelSmallStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.tertiary,
        fontWeight: FontWeight.w500,
      ),

      warningBodyMediumStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      warningBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      warningBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      warningDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
      warningDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
      warningDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
      warningHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
      warningHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
      warningHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
      warningTitleLargeStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      warningTitleMediumStyle = Theme.of(context).textTheme.titleMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
      warningTitleSmallStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      warningLabelLargeStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),
      warningLabelMediumStyle = Theme.of(context).textTheme.labelMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
      warningLabelSmallStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
        fontWeight: FontWeight.w500,
      ),

      linkBodyMediumStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
      linkDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
      linkDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
      linkHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
      linkHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
      linkHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
      linkTitleLargeStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkTitleMediumStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkTitleSmallStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkLabelLargeStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkLabelMediumStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      linkLabelSmallStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),

      inverseBodyMediumStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      inverseBodyLargeStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      inverseBodySmallStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      inverseDisplayLargeStyle = Theme.of(context).textTheme.displayLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      inverseDisplayMediumStyle = Theme.of(context).textTheme.displayMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      inverseDisplaySmallStyle = Theme.of(context).textTheme.displaySmall
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      inverseHeadlineLargeStyle = Theme.of(context).textTheme.headlineLarge
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      inverseHeadlineMediumStyle = Theme.of(context).textTheme.headlineMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      inverseHeadlineSmallStyle = Theme.of(context).textTheme.headlineSmall
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      inverseTitleLargeStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      inverseTitleMediumStyle = Theme.of(context).textTheme.titleMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      inverseTitleSmallStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      inverseLabelLargeStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      inverseLabelMediumStyle = Theme.of(context).textTheme.labelMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      inverseLabelSmallStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      );

  final TextStyle? primaryBodyMediumStyle;
  final TextStyle? primaryBodyLargeStyle;
  final TextStyle? primaryBodySmallStyle;
  final TextStyle? primaryDisplayLargeStyle;
  final TextStyle? primaryDisplayMediumStyle;
  final TextStyle? primaryDisplaySmallStyle;
  final TextStyle? primaryHeadlineLargeStyle;
  final TextStyle? primaryHeadlineMediumStyle;
  final TextStyle? primaryHeadlineSmallStyle;
  final TextStyle? primaryTitleLargeStyle;
  final TextStyle? primaryTitleMediumStyle;
  final TextStyle? primaryTitleSmallStyle;
  final TextStyle? primaryLabelLargeStyle;
  final TextStyle? primaryLabelMediumStyle;
  final TextStyle? primaryLabelSmallStyle;

  final TextStyle? secondaryBodyMediumStyle;
  final TextStyle? secondaryBodyLargeStyle;
  final TextStyle? secondaryBodySmallStyle;
  final TextStyle? secondaryDisplayLargeStyle;
  final TextStyle? secondaryDisplayMediumStyle;
  final TextStyle? secondaryDisplaySmallStyle;
  final TextStyle? secondaryHeadlineLargeStyle;
  final TextStyle? secondaryHeadlineMediumStyle;
  final TextStyle? secondaryHeadlineSmallStyle;
  final TextStyle? secondaryTitleLargeStyle;
  final TextStyle? secondaryTitleMediumStyle;
  final TextStyle? secondaryTitleSmallStyle;
  final TextStyle? secondaryLabelLargeStyle;
  final TextStyle? secondaryLabelMediumStyle;
  final TextStyle? secondaryLabelSmallStyle;

  final TextStyle? emphasisBodyMediumStyle;
  final TextStyle? emphasisBodyLargeStyle;
  final TextStyle? emphasisBodySmallStyle;
  final TextStyle? emphasisDisplayLargeStyle;
  final TextStyle? emphasisDisplayMediumStyle;
  final TextStyle? emphasisDisplaySmallStyle;
  final TextStyle? emphasisHeadlineLargeStyle;
  final TextStyle? emphasisHeadlineMediumStyle;
  final TextStyle? emphasisHeadlineSmallStyle;
  final TextStyle? emphasisTitleLargeStyle;
  final TextStyle? emphasisTitleMediumStyle;
  final TextStyle? emphasisTitleSmallStyle;
  final TextStyle? emphasisLabelLargeStyle;
  final TextStyle? emphasisLabelMediumStyle;
  final TextStyle? emphasisLabelSmallStyle;

  final TextStyle? mutedBodyMediumStyle;
  final TextStyle? mutedBodyLargeStyle;
  final TextStyle? mutedBodySmallStyle;
  final TextStyle? mutedDisplayLargeStyle;
  final TextStyle? mutedDisplayMediumStyle;
  final TextStyle? mutedDisplaySmallStyle;
  final TextStyle? mutedHeadlineLargeStyle;
  final TextStyle? mutedHeadlineMediumStyle;
  final TextStyle? mutedHeadlineSmallStyle;
  final TextStyle? mutedTitleLargeStyle;
  final TextStyle? mutedTitleMediumStyle;
  final TextStyle? mutedTitleSmallStyle;
  final TextStyle? mutedLabelLargeStyle;
  final TextStyle? mutedLabelMediumStyle;
  final TextStyle? mutedLabelSmallStyle;

  final TextStyle? errorBodyMediumStyle;
  final TextStyle? errorBodyLargeStyle;
  final TextStyle? errorBodySmallStyle;
  final TextStyle? errorDisplayLargeStyle;
  final TextStyle? errorDisplayMediumStyle;
  final TextStyle? errorDisplaySmallStyle;
  final TextStyle? errorHeadlineLargeStyle;
  final TextStyle? errorHeadlineMediumStyle;
  final TextStyle? errorHeadlineSmallStyle;
  final TextStyle? errorTitleLargeStyle;
  final TextStyle? errorTitleMediumStyle;
  final TextStyle? errorTitleSmallStyle;
  final TextStyle? errorLabelLargeStyle;
  final TextStyle? errorLabelMediumStyle;
  final TextStyle? errorLabelSmallStyle;

  final TextStyle? successBodyMediumStyle;
  final TextStyle? successBodyLargeStyle;
  final TextStyle? successBodySmallStyle;
  final TextStyle? successDisplayLargeStyle;
  final TextStyle? successDisplayMediumStyle;
  final TextStyle? successDisplaySmallStyle;
  final TextStyle? successHeadlineLargeStyle;
  final TextStyle? successHeadlineMediumStyle;
  final TextStyle? successHeadlineSmallStyle;
  final TextStyle? successTitleLargeStyle;
  final TextStyle? successTitleMediumStyle;
  final TextStyle? successTitleSmallStyle;
  final TextStyle? successLabelLargeStyle;
  final TextStyle? successLabelMediumStyle;
  final TextStyle? successLabelSmallStyle;

  final TextStyle? warningBodyMediumStyle;
  final TextStyle? warningBodyLargeStyle;
  final TextStyle? warningBodySmallStyle;
  final TextStyle? warningDisplayLargeStyle;
  final TextStyle? warningDisplayMediumStyle;
  final TextStyle? warningDisplaySmallStyle;
  final TextStyle? warningHeadlineLargeStyle;
  final TextStyle? warningHeadlineMediumStyle;
  final TextStyle? warningHeadlineSmallStyle;
  final TextStyle? warningTitleLargeStyle;
  final TextStyle? warningTitleMediumStyle;
  final TextStyle? warningTitleSmallStyle;
  final TextStyle? warningLabelLargeStyle;
  final TextStyle? warningLabelMediumStyle;
  final TextStyle? warningLabelSmallStyle;

  final TextStyle? linkBodyMediumStyle;
  final TextStyle? linkBodyLargeStyle;
  final TextStyle? linkBodySmallStyle;
  final TextStyle? linkDisplayLargeStyle;
  final TextStyle? linkDisplayMediumStyle;
  final TextStyle? linkDisplaySmallStyle;
  final TextStyle? linkHeadlineLargeStyle;
  final TextStyle? linkHeadlineMediumStyle;
  final TextStyle? linkHeadlineSmallStyle;
  final TextStyle? linkTitleLargeStyle;
  final TextStyle? linkTitleMediumStyle;
  final TextStyle? linkTitleSmallStyle;
  final TextStyle? linkLabelLargeStyle;
  final TextStyle? linkLabelMediumStyle;
  final TextStyle? linkLabelSmallStyle;

  final TextStyle? inverseBodyMediumStyle;
  final TextStyle? inverseBodyLargeStyle;
  final TextStyle? inverseBodySmallStyle;
  final TextStyle? inverseDisplayLargeStyle;
  final TextStyle? inverseDisplayMediumStyle;
  final TextStyle? inverseDisplaySmallStyle;
  final TextStyle? inverseHeadlineLargeStyle;
  final TextStyle? inverseHeadlineMediumStyle;
  final TextStyle? inverseHeadlineSmallStyle;
  final TextStyle? inverseTitleLargeStyle;
  final TextStyle? inverseTitleMediumStyle;
  final TextStyle? inverseTitleSmallStyle;
  final TextStyle? inverseLabelLargeStyle;
  final TextStyle? inverseLabelMediumStyle;
  final TextStyle? inverseLabelSmallStyle;

  @override
  ThemeExtension<TextStyles> copyWith({
    TextStyle? primaryBodyMediumStyle,
    TextStyle? primaryBodyLargeStyle,
    TextStyle? primaryBodySmallStyle,
    TextStyle? primaryDisplayLargeStyle,
    TextStyle? primaryDisplayMediumStyle,
    TextStyle? primaryDisplaySmallStyle,
    TextStyle? primaryHeadlineLargeStyle,
    TextStyle? primaryHeadlineMediumStyle,
    TextStyle? primaryHeadlineSmallStyle,
    TextStyle? primaryTitleLargeStyle,
    TextStyle? primaryTitleMediumStyle,
    TextStyle? primaryTitleSmallStyle,
    TextStyle? primaryLabelLargeStyle,
    TextStyle? primaryLabelMediumStyle,
    TextStyle? primaryLabelSmallStyle,
    TextStyle? secondaryBodyMediumStyle,
    TextStyle? secondaryBodyLargeStyle,
    TextStyle? secondaryBodySmallStyle,
    TextStyle? secondaryDisplayLargeStyle,
    TextStyle? secondaryDisplayMediumStyle,
    TextStyle? secondaryDisplaySmallStyle,
    TextStyle? secondaryHeadlineLargeStyle,
    TextStyle? secondaryHeadlineMediumStyle,
    TextStyle? secondaryHeadlineSmallStyle,
    TextStyle? secondaryTitleLargeStyle,
    TextStyle? secondaryTitleMediumStyle,
    TextStyle? secondaryTitleSmallStyle,
    TextStyle? secondaryLabelLargeStyle,
    TextStyle? secondaryLabelMediumStyle,
    TextStyle? secondaryLabelSmallStyle,
    TextStyle? emphasisBodyMediumStyle,
    TextStyle? emphasisBodyLargeStyle,
    TextStyle? emphasisBodySmallStyle,
    TextStyle? emphasisDisplayLargeStyle,
    TextStyle? emphasisDisplayMediumStyle,
    TextStyle? emphasisDisplaySmallStyle,
    TextStyle? emphasisHeadlineLargeStyle,
    TextStyle? emphasisHeadlineMediumStyle,
    TextStyle? emphasisHeadlineSmallStyle,
    TextStyle? emphasisTitleLargeStyle,
    TextStyle? emphasisTitleMediumStyle,
    TextStyle? emphasisTitleSmallStyle,
    TextStyle? emphasisLabelLargeStyle,
    TextStyle? emphasisLabelMediumStyle,
    TextStyle? emphasisLabelSmallStyle,
    TextStyle? mutedBodyMediumStyle,
    TextStyle? mutedBodyLargeStyle,
    TextStyle? mutedBodySmallStyle,
    TextStyle? mutedDisplayLargeStyle,
    TextStyle? mutedDisplayMediumStyle,
    TextStyle? mutedDisplaySmallStyle,
    TextStyle? mutedHeadlineLargeStyle,
    TextStyle? mutedHeadlineMediumStyle,
    TextStyle? mutedHeadlineSmallStyle,
    TextStyle? mutedTitleLargeStyle,
    TextStyle? mutedTitleMediumStyle,
    TextStyle? mutedTitleSmallStyle,
    TextStyle? mutedLabelLargeStyle,
    TextStyle? mutedLabelMediumStyle,
    TextStyle? mutedLabelSmallStyle,
    TextStyle? errorBodyMediumStyle,
    TextStyle? errorBodyLargeStyle,
    TextStyle? errorBodySmallStyle,
    TextStyle? errorDisplayLargeStyle,
    TextStyle? errorDisplayMediumStyle,
    TextStyle? errorDisplaySmallStyle,
    TextStyle? errorHeadlineLargeStyle,
    TextStyle? errorHeadlineMediumStyle,
    TextStyle? errorHeadlineSmallStyle,
    TextStyle? errorTitleLargeStyle,
    TextStyle? errorTitleMediumStyle,
    TextStyle? errorTitleSmallStyle,
    TextStyle? errorLabelLargeStyle,
    TextStyle? errorLabelMediumStyle,
    TextStyle? errorLabelSmallStyle,
    TextStyle? successBodyMediumStyle,
    TextStyle? successBodyLargeStyle,
    TextStyle? successBodySmallStyle,
    TextStyle? successDisplayLargeStyle,
    TextStyle? successDisplayMediumStyle,
    TextStyle? successDisplaySmallStyle,
    TextStyle? successHeadlineLargeStyle,
    TextStyle? successHeadlineMediumStyle,
    TextStyle? successHeadlineSmallStyle,
    TextStyle? successTitleLargeStyle,
    TextStyle? successTitleMediumStyle,
    TextStyle? successTitleSmallStyle,
    TextStyle? successLabelLargeStyle,
    TextStyle? successLabelMediumStyle,
    TextStyle? successLabelSmallStyle,
    TextStyle? warningBodyMediumStyle,
    TextStyle? warningBodyLargeStyle,
    TextStyle? warningBodySmallStyle,
    TextStyle? warningDisplayLargeStyle,
    TextStyle? warningDisplayMediumStyle,
    TextStyle? warningDisplaySmallStyle,
    TextStyle? warningHeadlineLargeStyle,
    TextStyle? warningHeadlineMediumStyle,
    TextStyle? warningHeadlineSmallStyle,
    TextStyle? warningTitleLargeStyle,
    TextStyle? warningTitleMediumStyle,
    TextStyle? warningTitleSmallStyle,
    TextStyle? warningLabelLargeStyle,
    TextStyle? warningLabelMediumStyle,
    TextStyle? warningLabelSmallStyle,
    TextStyle? linkBodyMediumStyle,
    TextStyle? linkBodyLargeStyle,
    TextStyle? linkBodySmallStyle,
    TextStyle? linkDisplayLargeStyle,
    TextStyle? linkDisplayMediumStyle,
    TextStyle? linkDisplaySmallStyle,
    TextStyle? linkHeadlineLargeStyle,
    TextStyle? linkHeadlineMediumStyle,
    TextStyle? linkHeadlineSmallStyle,
    TextStyle? linkTitleLargeStyle,
    TextStyle? linkTitleMediumStyle,
    TextStyle? linkTitleSmallStyle,
    TextStyle? linkLabelLargeStyle,
    TextStyle? linkLabelMediumStyle,
    TextStyle? linkLabelSmallStyle,
    TextStyle? inverseBodyMediumStyle,
    TextStyle? inverseBodyLargeStyle,
    TextStyle? inverseBodySmallStyle,
    TextStyle? inverseDisplayLargeStyle,
    TextStyle? inverseDisplayMediumStyle,
    TextStyle? inverseDisplaySmallStyle,
    TextStyle? inverseHeadlineLargeStyle,
    TextStyle? inverseHeadlineMediumStyle,
    TextStyle? inverseHeadlineSmallStyle,
    TextStyle? inverseTitleLargeStyle,
    TextStyle? inverseTitleMediumStyle,
    TextStyle? inverseTitleSmallStyle,
    TextStyle? inverseLabelLargeStyle,
    TextStyle? inverseLabelMediumStyle,
    TextStyle? inverseLabelSmallStyle,
  }) => TextStyles(
    primaryBodyMediumStyle:
        primaryBodyMediumStyle ?? this.primaryBodyMediumStyle,
    primaryBodyLargeStyle: primaryBodyLargeStyle ?? this.primaryBodyLargeStyle,
    primaryBodySmallStyle: primaryBodySmallStyle ?? this.primaryBodySmallStyle,
    primaryDisplayLargeStyle:
        primaryDisplayLargeStyle ?? this.primaryDisplayLargeStyle,
    primaryDisplayMediumStyle:
        primaryDisplayMediumStyle ?? this.primaryDisplayMediumStyle,
    primaryDisplaySmallStyle:
        primaryDisplaySmallStyle ?? this.primaryDisplaySmallStyle,
    primaryHeadlineLargeStyle:
        primaryHeadlineLargeStyle ?? this.primaryHeadlineLargeStyle,
    primaryHeadlineMediumStyle:
        primaryHeadlineMediumStyle ?? this.primaryHeadlineMediumStyle,
    primaryHeadlineSmallStyle:
        primaryHeadlineSmallStyle ?? this.primaryHeadlineSmallStyle,
    primaryTitleLargeStyle:
        primaryTitleLargeStyle ?? this.primaryTitleLargeStyle,
    primaryTitleMediumStyle:
        primaryTitleMediumStyle ?? this.primaryTitleMediumStyle,
    primaryTitleSmallStyle:
        primaryTitleSmallStyle ?? this.primaryTitleSmallStyle,
    primaryLabelLargeStyle:
        primaryLabelLargeStyle ?? this.primaryLabelLargeStyle,
    primaryLabelMediumStyle:
        primaryLabelMediumStyle ?? this.primaryLabelMediumStyle,
    primaryLabelSmallStyle:
        primaryLabelSmallStyle ?? this.primaryLabelSmallStyle,
    secondaryBodyMediumStyle:
        secondaryBodyMediumStyle ?? this.secondaryBodyMediumStyle,
    secondaryBodyLargeStyle:
        secondaryBodyLargeStyle ?? this.secondaryBodyLargeStyle,
    secondaryBodySmallStyle:
        secondaryBodySmallStyle ?? this.secondaryBodySmallStyle,
    secondaryDisplayLargeStyle:
        secondaryDisplayLargeStyle ?? this.secondaryDisplayLargeStyle,
    secondaryDisplayMediumStyle:
        secondaryDisplayMediumStyle ?? this.secondaryDisplayMediumStyle,
    secondaryDisplaySmallStyle:
        secondaryDisplaySmallStyle ?? this.secondaryDisplaySmallStyle,
    secondaryHeadlineLargeStyle:
        secondaryHeadlineLargeStyle ?? this.secondaryHeadlineLargeStyle,
    secondaryHeadlineMediumStyle:
        secondaryHeadlineMediumStyle ?? this.secondaryHeadlineMediumStyle,
    secondaryHeadlineSmallStyle:
        secondaryHeadlineSmallStyle ?? this.secondaryHeadlineSmallStyle,
    secondaryTitleLargeStyle:
        secondaryTitleLargeStyle ?? this.secondaryTitleLargeStyle,
    secondaryTitleMediumStyle:
        secondaryTitleMediumStyle ?? this.secondaryTitleMediumStyle,
    secondaryTitleSmallStyle:
        secondaryTitleSmallStyle ?? this.secondaryTitleSmallStyle,
    secondaryLabelLargeStyle:
        secondaryLabelLargeStyle ?? this.secondaryLabelLargeStyle,
    secondaryLabelMediumStyle:
        secondaryLabelMediumStyle ?? this.secondaryLabelMediumStyle,
    secondaryLabelSmallStyle:
        secondaryLabelSmallStyle ?? this.secondaryLabelSmallStyle,
    emphasisBodyMediumStyle:
        emphasisBodyMediumStyle ?? this.emphasisBodyMediumStyle,
    emphasisBodyLargeStyle:
        emphasisBodyLargeStyle ?? this.emphasisBodyLargeStyle,
    emphasisBodySmallStyle:
        emphasisBodySmallStyle ?? this.emphasisBodySmallStyle,
    emphasisDisplayLargeStyle:
        emphasisDisplayLargeStyle ?? this.emphasisDisplayLargeStyle,
    emphasisDisplayMediumStyle:
        emphasisDisplayMediumStyle ?? this.emphasisDisplayMediumStyle,
    emphasisDisplaySmallStyle:
        emphasisDisplaySmallStyle ?? this.emphasisDisplaySmallStyle,
    emphasisHeadlineLargeStyle:
        emphasisHeadlineLargeStyle ?? this.emphasisHeadlineLargeStyle,
    emphasisHeadlineMediumStyle:
        emphasisHeadlineMediumStyle ?? this.emphasisHeadlineMediumStyle,
    emphasisHeadlineSmallStyle:
        emphasisHeadlineSmallStyle ?? this.emphasisHeadlineSmallStyle,
    emphasisTitleLargeStyle:
        emphasisTitleLargeStyle ?? this.emphasisTitleLargeStyle,
    emphasisTitleMediumStyle:
        emphasisTitleMediumStyle ?? this.emphasisTitleMediumStyle,
    emphasisTitleSmallStyle:
        emphasisTitleSmallStyle ?? this.emphasisTitleSmallStyle,
    emphasisLabelLargeStyle:
        emphasisLabelLargeStyle ?? this.emphasisLabelLargeStyle,
    emphasisLabelMediumStyle:
        emphasisLabelMediumStyle ?? this.emphasisLabelMediumStyle,
    emphasisLabelSmallStyle:
        emphasisLabelSmallStyle ?? this.emphasisLabelSmallStyle,
    mutedBodyMediumStyle: mutedBodyMediumStyle ?? this.mutedBodyMediumStyle,
    mutedBodyLargeStyle: mutedBodyLargeStyle ?? this.mutedBodyLargeStyle,
    mutedBodySmallStyle: mutedBodySmallStyle ?? this.mutedBodySmallStyle,
    mutedDisplayLargeStyle:
        mutedDisplayLargeStyle ?? this.mutedDisplayLargeStyle,
    mutedDisplayMediumStyle:
        mutedDisplayMediumStyle ?? this.mutedDisplayMediumStyle,
    mutedDisplaySmallStyle:
        mutedDisplaySmallStyle ?? this.mutedDisplaySmallStyle,
    mutedHeadlineLargeStyle:
        mutedHeadlineLargeStyle ?? this.mutedHeadlineLargeStyle,
    mutedHeadlineMediumStyle:
        mutedHeadlineMediumStyle ?? this.mutedHeadlineMediumStyle,
    mutedHeadlineSmallStyle:
        mutedHeadlineSmallStyle ?? this.mutedHeadlineSmallStyle,
    mutedTitleLargeStyle: mutedTitleLargeStyle ?? this.mutedTitleLargeStyle,
    mutedTitleMediumStyle: mutedTitleMediumStyle ?? this.mutedTitleMediumStyle,
    mutedTitleSmallStyle: mutedTitleSmallStyle ?? this.mutedTitleSmallStyle,
    mutedLabelLargeStyle: mutedLabelLargeStyle ?? this.mutedLabelLargeStyle,
    mutedLabelMediumStyle: mutedLabelMediumStyle ?? this.mutedLabelMediumStyle,
    mutedLabelSmallStyle: mutedLabelSmallStyle ?? this.mutedLabelSmallStyle,
    errorBodyMediumStyle: errorBodyMediumStyle ?? this.errorBodyMediumStyle,
    errorBodyLargeStyle: errorBodyLargeStyle ?? this.errorBodyLargeStyle,
    errorBodySmallStyle: errorBodySmallStyle ?? this.errorBodySmallStyle,
    errorDisplayLargeStyle:
        errorDisplayLargeStyle ?? this.errorDisplayLargeStyle,
    errorDisplayMediumStyle:
        errorDisplayMediumStyle ?? this.errorDisplayMediumStyle,
    errorDisplaySmallStyle:
        errorDisplaySmallStyle ?? this.errorDisplaySmallStyle,
    errorHeadlineLargeStyle:
        errorHeadlineLargeStyle ?? this.errorHeadlineLargeStyle,
    errorHeadlineMediumStyle:
        errorHeadlineMediumStyle ?? this.errorHeadlineMediumStyle,
    errorHeadlineSmallStyle:
        errorHeadlineSmallStyle ?? this.errorHeadlineSmallStyle,
    errorTitleLargeStyle: errorTitleLargeStyle ?? this.errorTitleLargeStyle,
    errorTitleMediumStyle: errorTitleMediumStyle ?? this.errorTitleMediumStyle,
    errorTitleSmallStyle: errorTitleSmallStyle ?? this.errorTitleSmallStyle,
    errorLabelLargeStyle: errorLabelLargeStyle ?? this.errorLabelLargeStyle,
    errorLabelMediumStyle: errorLabelMediumStyle ?? this.errorLabelMediumStyle,
    errorLabelSmallStyle: errorLabelSmallStyle ?? this.errorLabelSmallStyle,
    successBodyMediumStyle:
        successBodyMediumStyle ?? this.successBodyMediumStyle,
    successBodyLargeStyle: successBodyLargeStyle ?? this.successBodyLargeStyle,
    successBodySmallStyle: successBodySmallStyle ?? this.successBodySmallStyle,
    successDisplayLargeStyle:
        successDisplayLargeStyle ?? this.successDisplayLargeStyle,
    successDisplayMediumStyle:
        successDisplayMediumStyle ?? this.successDisplayMediumStyle,
    successDisplaySmallStyle:
        successDisplaySmallStyle ?? this.successDisplaySmallStyle,
    successHeadlineLargeStyle:
        successHeadlineLargeStyle ?? this.successHeadlineLargeStyle,
    successHeadlineMediumStyle:
        successHeadlineMediumStyle ?? this.successHeadlineMediumStyle,
    successHeadlineSmallStyle:
        successHeadlineSmallStyle ?? this.successHeadlineSmallStyle,
    successTitleLargeStyle:
        successTitleLargeStyle ?? this.successTitleLargeStyle,
    successTitleMediumStyle:
        successTitleMediumStyle ?? this.successTitleMediumStyle,
    successTitleSmallStyle:
        successTitleSmallStyle ?? this.successTitleSmallStyle,
    successLabelLargeStyle:
        successLabelLargeStyle ?? this.successLabelLargeStyle,
    successLabelMediumStyle:
        successLabelMediumStyle ?? this.successLabelMediumStyle,
    successLabelSmallStyle:
        successLabelSmallStyle ?? this.successLabelSmallStyle,
    warningBodyMediumStyle:
        warningBodyMediumStyle ?? this.warningBodyMediumStyle,
    warningBodyLargeStyle: warningBodyLargeStyle ?? this.warningBodyLargeStyle,
    warningBodySmallStyle: warningBodySmallStyle ?? this.warningBodySmallStyle,
    warningDisplayLargeStyle:
        warningDisplayLargeStyle ?? this.warningDisplayLargeStyle,
    warningDisplayMediumStyle:
        warningDisplayMediumStyle ?? this.warningDisplayMediumStyle,
    warningDisplaySmallStyle:
        warningDisplaySmallStyle ?? this.warningDisplaySmallStyle,
    warningHeadlineLargeStyle:
        warningHeadlineLargeStyle ?? this.warningHeadlineLargeStyle,
    warningHeadlineMediumStyle:
        warningHeadlineMediumStyle ?? this.warningHeadlineMediumStyle,
    warningHeadlineSmallStyle:
        warningHeadlineSmallStyle ?? this.warningHeadlineSmallStyle,
    warningTitleLargeStyle:
        warningTitleLargeStyle ?? this.warningTitleLargeStyle,
    warningTitleMediumStyle:
        warningTitleMediumStyle ?? this.warningTitleMediumStyle,
    warningTitleSmallStyle:
        warningTitleSmallStyle ?? this.warningTitleSmallStyle,
    warningLabelLargeStyle:
        warningLabelLargeStyle ?? this.warningLabelLargeStyle,
    warningLabelMediumStyle:
        warningLabelMediumStyle ?? this.warningLabelMediumStyle,
    warningLabelSmallStyle:
        warningLabelSmallStyle ?? this.warningLabelSmallStyle,
    linkBodyMediumStyle: linkBodyMediumStyle ?? this.linkBodyMediumStyle,
    linkBodyLargeStyle: linkBodyLargeStyle ?? this.linkBodyLargeStyle,
    linkBodySmallStyle: linkBodySmallStyle ?? this.linkBodySmallStyle,
    linkDisplayLargeStyle: linkDisplayLargeStyle ?? this.linkDisplayLargeStyle,
    linkDisplayMediumStyle:
        linkDisplayMediumStyle ?? this.linkDisplayMediumStyle,
    linkDisplaySmallStyle: linkDisplaySmallStyle ?? this.linkDisplaySmallStyle,
    linkHeadlineLargeStyle:
        linkHeadlineLargeStyle ?? this.linkHeadlineLargeStyle,
    linkHeadlineMediumStyle:
        linkHeadlineMediumStyle ?? this.linkHeadlineMediumStyle,
    linkHeadlineSmallStyle:
        linkHeadlineSmallStyle ?? this.linkHeadlineSmallStyle,
    linkTitleLargeStyle: linkTitleLargeStyle ?? this.linkTitleLargeStyle,
    linkTitleMediumStyle: linkTitleMediumStyle ?? this.linkTitleMediumStyle,
    linkTitleSmallStyle: linkTitleSmallStyle ?? this.linkTitleSmallStyle,
    linkLabelLargeStyle: linkLabelLargeStyle ?? this.linkLabelLargeStyle,
    linkLabelMediumStyle: linkLabelMediumStyle ?? this.linkLabelMediumStyle,
    linkLabelSmallStyle: linkLabelSmallStyle ?? this.linkLabelSmallStyle,
    inverseBodyMediumStyle:
        inverseBodyMediumStyle ?? this.inverseBodyMediumStyle,
    inverseBodyLargeStyle: inverseBodyLargeStyle ?? this.inverseBodyLargeStyle,
    inverseBodySmallStyle: inverseBodySmallStyle ?? this.inverseBodySmallStyle,
    inverseDisplayLargeStyle:
        inverseDisplayLargeStyle ?? this.inverseDisplayLargeStyle,
    inverseDisplayMediumStyle:
        inverseDisplayMediumStyle ?? this.inverseDisplayMediumStyle,
    inverseDisplaySmallStyle:
        inverseDisplaySmallStyle ?? this.inverseDisplaySmallStyle,
    inverseHeadlineLargeStyle:
        inverseHeadlineLargeStyle ?? this.inverseHeadlineLargeStyle,
    inverseHeadlineMediumStyle:
        inverseHeadlineMediumStyle ?? this.inverseHeadlineMediumStyle,
    inverseHeadlineSmallStyle:
        inverseHeadlineSmallStyle ?? this.inverseHeadlineSmallStyle,
    inverseTitleLargeStyle:
        inverseTitleLargeStyle ?? this.inverseTitleLargeStyle,
    inverseTitleMediumStyle:
        inverseTitleMediumStyle ?? this.inverseTitleMediumStyle,
    inverseTitleSmallStyle:
        inverseTitleSmallStyle ?? this.inverseTitleSmallStyle,
    inverseLabelLargeStyle:
        inverseLabelLargeStyle ?? this.inverseLabelLargeStyle,
    inverseLabelMediumStyle:
        inverseLabelMediumStyle ?? this.inverseLabelMediumStyle,
    inverseLabelSmallStyle:
        inverseLabelSmallStyle ?? this.inverseLabelSmallStyle,
  );

  @override
  ThemeExtension<TextStyles> lerp(ThemeExtension<TextStyles>? other, double t) {
    if (other is! TextStyles) {
      return this;
    }

    return TextStyles(
      primaryBodyMediumStyle: TextStyle.lerp(
        primaryBodyMediumStyle,
        other.primaryBodyMediumStyle,
        t,
      ),
      primaryBodyLargeStyle: TextStyle.lerp(
        primaryBodyLargeStyle,
        other.primaryBodyLargeStyle,
        t,
      ),
      primaryBodySmallStyle: TextStyle.lerp(
        primaryBodySmallStyle,
        other.primaryBodySmallStyle,
        t,
      ),
      primaryDisplayLargeStyle: TextStyle.lerp(
        primaryDisplayLargeStyle,
        other.primaryDisplayLargeStyle,
        t,
      ),
      primaryDisplayMediumStyle: TextStyle.lerp(
        primaryDisplayMediumStyle,
        other.primaryDisplayMediumStyle,
        t,
      ),
      primaryDisplaySmallStyle: TextStyle.lerp(
        primaryDisplaySmallStyle,
        other.primaryDisplaySmallStyle,
        t,
      ),
      primaryHeadlineLargeStyle: TextStyle.lerp(
        primaryHeadlineLargeStyle,
        other.primaryHeadlineLargeStyle,
        t,
      ),
      primaryHeadlineMediumStyle: TextStyle.lerp(
        primaryHeadlineMediumStyle,
        other.primaryHeadlineMediumStyle,
        t,
      ),
      primaryHeadlineSmallStyle: TextStyle.lerp(
        primaryHeadlineSmallStyle,
        other.primaryHeadlineSmallStyle,
        t,
      ),
      primaryTitleLargeStyle: TextStyle.lerp(
        primaryTitleLargeStyle,
        other.primaryTitleLargeStyle,
        t,
      ),
      primaryTitleMediumStyle: TextStyle.lerp(
        primaryTitleMediumStyle,
        other.primaryTitleMediumStyle,
        t,
      ),
      primaryTitleSmallStyle: TextStyle.lerp(
        primaryTitleSmallStyle,
        other.primaryTitleSmallStyle,
        t,
      ),
      primaryLabelLargeStyle: TextStyle.lerp(
        primaryLabelLargeStyle,
        other.primaryLabelLargeStyle,
        t,
      ),
      primaryLabelMediumStyle: TextStyle.lerp(
        primaryLabelMediumStyle,
        other.primaryLabelMediumStyle,
        t,
      ),
      primaryLabelSmallStyle: TextStyle.lerp(
        primaryLabelSmallStyle,
        other.primaryLabelSmallStyle,
        t,
      ),
      secondaryBodyMediumStyle: TextStyle.lerp(
        secondaryBodyMediumStyle,
        other.secondaryBodyMediumStyle,
        t,
      ),
      secondaryBodyLargeStyle: TextStyle.lerp(
        secondaryBodyLargeStyle,
        other.secondaryBodyLargeStyle,
        t,
      ),
      secondaryBodySmallStyle: TextStyle.lerp(
        secondaryBodySmallStyle,
        other.secondaryBodySmallStyle,
        t,
      ),
      secondaryDisplayLargeStyle: TextStyle.lerp(
        secondaryDisplayLargeStyle,
        other.secondaryDisplayLargeStyle,
        t,
      ),
      secondaryDisplayMediumStyle: TextStyle.lerp(
        secondaryDisplayMediumStyle,
        other.secondaryDisplayMediumStyle,
        t,
      ),
      secondaryDisplaySmallStyle: TextStyle.lerp(
        secondaryDisplaySmallStyle,
        other.secondaryDisplaySmallStyle,
        t,
      ),
      secondaryHeadlineLargeStyle: TextStyle.lerp(
        secondaryHeadlineLargeStyle,
        other.secondaryHeadlineLargeStyle,
        t,
      ),
      secondaryHeadlineMediumStyle: TextStyle.lerp(
        secondaryHeadlineMediumStyle,
        other.secondaryHeadlineMediumStyle,
        t,
      ),
      secondaryHeadlineSmallStyle: TextStyle.lerp(
        secondaryHeadlineSmallStyle,
        other.secondaryHeadlineSmallStyle,
        t,
      ),
      secondaryTitleLargeStyle: TextStyle.lerp(
        secondaryTitleLargeStyle,
        other.secondaryTitleLargeStyle,
        t,
      ),
      secondaryTitleMediumStyle: TextStyle.lerp(
        secondaryTitleMediumStyle,
        other.secondaryTitleMediumStyle,
        t,
      ),
      secondaryTitleSmallStyle: TextStyle.lerp(
        secondaryTitleSmallStyle,
        other.secondaryTitleSmallStyle,
        t,
      ),
      secondaryLabelLargeStyle: TextStyle.lerp(
        secondaryLabelLargeStyle,
        other.secondaryLabelLargeStyle,
        t,
      ),
      secondaryLabelMediumStyle: TextStyle.lerp(
        secondaryLabelMediumStyle,
        other.secondaryLabelMediumStyle,
        t,
      ),
      secondaryLabelSmallStyle: TextStyle.lerp(
        secondaryLabelSmallStyle,
        other.secondaryLabelSmallStyle,
        t,
      ),
      emphasisBodyMediumStyle: TextStyle.lerp(
        emphasisBodyMediumStyle,
        other.emphasisBodyMediumStyle,
        t,
      ),
      emphasisBodyLargeStyle: TextStyle.lerp(
        emphasisBodyLargeStyle,
        other.emphasisBodyLargeStyle,
        t,
      ),
      emphasisBodySmallStyle: TextStyle.lerp(
        emphasisBodySmallStyle,
        other.emphasisBodySmallStyle,
        t,
      ),
      emphasisDisplayLargeStyle: TextStyle.lerp(
        emphasisDisplayLargeStyle,
        other.emphasisDisplayLargeStyle,
        t,
      ),
      emphasisDisplayMediumStyle: TextStyle.lerp(
        emphasisDisplayMediumStyle,
        other.emphasisDisplayMediumStyle,
        t,
      ),
      emphasisDisplaySmallStyle: TextStyle.lerp(
        emphasisDisplaySmallStyle,
        other.emphasisDisplaySmallStyle,
        t,
      ),
      emphasisHeadlineLargeStyle: TextStyle.lerp(
        emphasisHeadlineLargeStyle,
        other.emphasisHeadlineLargeStyle,
        t,
      ),
      emphasisHeadlineMediumStyle: TextStyle.lerp(
        emphasisHeadlineMediumStyle,
        other.emphasisHeadlineMediumStyle,
        t,
      ),
      emphasisHeadlineSmallStyle: TextStyle.lerp(
        emphasisHeadlineSmallStyle,
        other.emphasisHeadlineSmallStyle,
        t,
      ),
      emphasisTitleLargeStyle: TextStyle.lerp(
        emphasisTitleLargeStyle,
        other.emphasisTitleLargeStyle,
        t,
      ),
      emphasisTitleMediumStyle: TextStyle.lerp(
        emphasisTitleMediumStyle,
        other.emphasisTitleMediumStyle,
        t,
      ),
      emphasisTitleSmallStyle: TextStyle.lerp(
        emphasisTitleSmallStyle,
        other.emphasisTitleSmallStyle,
        t,
      ),
      emphasisLabelLargeStyle: TextStyle.lerp(
        emphasisLabelLargeStyle,
        other.emphasisLabelLargeStyle,
        t,
      ),
      emphasisLabelMediumStyle: TextStyle.lerp(
        emphasisLabelMediumStyle,
        other.emphasisLabelMediumStyle,
        t,
      ),
      emphasisLabelSmallStyle: TextStyle.lerp(
        emphasisLabelSmallStyle,
        other.emphasisLabelSmallStyle,
        t,
      ),
      mutedBodyMediumStyle: TextStyle.lerp(
        mutedBodyMediumStyle,
        other.mutedBodyMediumStyle,
        t,
      ),
      mutedBodyLargeStyle: TextStyle.lerp(
        mutedBodyLargeStyle,
        other.mutedBodyLargeStyle,
        t,
      ),
      mutedBodySmallStyle: TextStyle.lerp(
        mutedBodySmallStyle,
        other.mutedBodySmallStyle,
        t,
      ),
      mutedDisplayLargeStyle: TextStyle.lerp(
        mutedDisplayLargeStyle,
        other.mutedDisplayLargeStyle,
        t,
      ),
      mutedDisplayMediumStyle: TextStyle.lerp(
        mutedDisplayMediumStyle,
        other.mutedDisplayMediumStyle,
        t,
      ),
      mutedDisplaySmallStyle: TextStyle.lerp(
        mutedDisplaySmallStyle,
        other.mutedDisplaySmallStyle,
        t,
      ),
      mutedHeadlineLargeStyle: TextStyle.lerp(
        mutedHeadlineLargeStyle,
        other.mutedHeadlineLargeStyle,
        t,
      ),
      mutedHeadlineMediumStyle: TextStyle.lerp(
        mutedHeadlineMediumStyle,
        other.mutedHeadlineMediumStyle,
        t,
      ),
      mutedHeadlineSmallStyle: TextStyle.lerp(
        mutedHeadlineSmallStyle,
        other.mutedHeadlineSmallStyle,
        t,
      ),
      mutedTitleLargeStyle: TextStyle.lerp(
        mutedTitleLargeStyle,
        other.mutedTitleLargeStyle,
        t,
      ),
      mutedTitleMediumStyle: TextStyle.lerp(
        mutedTitleMediumStyle,
        other.mutedTitleMediumStyle,
        t,
      ),
      mutedTitleSmallStyle: TextStyle.lerp(
        mutedTitleSmallStyle,
        other.mutedTitleSmallStyle,
        t,
      ),
      mutedLabelLargeStyle: TextStyle.lerp(
        mutedLabelLargeStyle,
        other.mutedLabelLargeStyle,
        t,
      ),
      mutedLabelMediumStyle: TextStyle.lerp(
        mutedLabelMediumStyle,
        other.mutedLabelMediumStyle,
        t,
      ),
      mutedLabelSmallStyle: TextStyle.lerp(
        mutedLabelSmallStyle,
        other.mutedLabelSmallStyle,
        t,
      ),
      errorBodyMediumStyle: TextStyle.lerp(
        errorBodyMediumStyle,
        other.errorBodyMediumStyle,
        t,
      ),
      errorBodyLargeStyle: TextStyle.lerp(
        errorBodyLargeStyle,
        other.errorBodyLargeStyle,
        t,
      ),
      errorBodySmallStyle: TextStyle.lerp(
        errorBodySmallStyle,
        other.errorBodySmallStyle,
        t,
      ),
      errorDisplayLargeStyle: TextStyle.lerp(
        errorDisplayLargeStyle,
        other.errorDisplayLargeStyle,
        t,
      ),
      errorDisplayMediumStyle: TextStyle.lerp(
        errorDisplayMediumStyle,
        other.errorDisplayMediumStyle,
        t,
      ),
      errorDisplaySmallStyle: TextStyle.lerp(
        errorDisplaySmallStyle,
        other.errorDisplaySmallStyle,
        t,
      ),
      errorHeadlineLargeStyle: TextStyle.lerp(
        errorHeadlineLargeStyle,
        other.errorHeadlineLargeStyle,
        t,
      ),
      errorHeadlineMediumStyle: TextStyle.lerp(
        errorHeadlineMediumStyle,
        other.errorHeadlineMediumStyle,
        t,
      ),
      errorHeadlineSmallStyle: TextStyle.lerp(
        errorHeadlineSmallStyle,
        other.errorHeadlineSmallStyle,
        t,
      ),
      errorTitleLargeStyle: TextStyle.lerp(
        errorTitleLargeStyle,
        other.errorTitleLargeStyle,
        t,
      ),
      errorTitleMediumStyle: TextStyle.lerp(
        errorTitleMediumStyle,
        other.errorTitleMediumStyle,
        t,
      ),
      errorTitleSmallStyle: TextStyle.lerp(
        errorTitleSmallStyle,
        other.errorTitleSmallStyle,
        t,
      ),
      errorLabelLargeStyle: TextStyle.lerp(
        errorLabelLargeStyle,
        other.errorLabelLargeStyle,
        t,
      ),
      errorLabelMediumStyle: TextStyle.lerp(
        errorLabelMediumStyle,
        other.errorLabelMediumStyle,
        t,
      ),
      errorLabelSmallStyle: TextStyle.lerp(
        errorLabelSmallStyle,
        other.errorLabelSmallStyle,
        t,
      ),
      successBodyMediumStyle: TextStyle.lerp(
        successBodyMediumStyle,
        other.successBodyMediumStyle,
        t,
      ),
      successBodyLargeStyle: TextStyle.lerp(
        successBodyLargeStyle,
        other.successBodyLargeStyle,
        t,
      ),
      successBodySmallStyle: TextStyle.lerp(
        successBodySmallStyle,
        other.successBodySmallStyle,
        t,
      ),
      successDisplayLargeStyle: TextStyle.lerp(
        successDisplayLargeStyle,
        other.successDisplayLargeStyle,
        t,
      ),
      successDisplayMediumStyle: TextStyle.lerp(
        successDisplayMediumStyle,
        other.successDisplayMediumStyle,
        t,
      ),
      successDisplaySmallStyle: TextStyle.lerp(
        successDisplaySmallStyle,
        other.successDisplaySmallStyle,
        t,
      ),
      successHeadlineLargeStyle: TextStyle.lerp(
        successHeadlineLargeStyle,
        other.successHeadlineLargeStyle,
        t,
      ),
      successHeadlineMediumStyle: TextStyle.lerp(
        successHeadlineMediumStyle,
        other.successHeadlineMediumStyle,
        t,
      ),
      successHeadlineSmallStyle: TextStyle.lerp(
        successHeadlineSmallStyle,
        other.successHeadlineSmallStyle,
        t,
      ),
      successTitleLargeStyle: TextStyle.lerp(
        successTitleLargeStyle,
        other.successTitleLargeStyle,
        t,
      ),
      successTitleMediumStyle: TextStyle.lerp(
        successTitleMediumStyle,
        other.successTitleMediumStyle,
        t,
      ),
      successTitleSmallStyle: TextStyle.lerp(
        successTitleSmallStyle,
        other.successTitleSmallStyle,
        t,
      ),
      successLabelLargeStyle: TextStyle.lerp(
        successLabelLargeStyle,
        other.successLabelLargeStyle,
        t,
      ),
      successLabelMediumStyle: TextStyle.lerp(
        successLabelMediumStyle,
        other.successLabelMediumStyle,
        t,
      ),
      successLabelSmallStyle: TextStyle.lerp(
        successLabelSmallStyle,
        other.successLabelSmallStyle,
        t,
      ),
      warningBodyMediumStyle: TextStyle.lerp(
        warningBodyMediumStyle,
        other.warningBodyMediumStyle,
        t,
      ),
      warningBodyLargeStyle: TextStyle.lerp(
        warningBodyLargeStyle,
        other.warningBodyLargeStyle,
        t,
      ),
      warningBodySmallStyle: TextStyle.lerp(
        warningBodySmallStyle,
        other.warningBodySmallStyle,
        t,
      ),
      warningDisplayLargeStyle: TextStyle.lerp(
        warningDisplayLargeStyle,
        other.warningDisplayLargeStyle,
        t,
      ),
      warningDisplayMediumStyle: TextStyle.lerp(
        warningDisplayMediumStyle,
        other.warningDisplayMediumStyle,
        t,
      ),
      warningDisplaySmallStyle: TextStyle.lerp(
        warningDisplaySmallStyle,
        other.warningDisplaySmallStyle,
        t,
      ),
      warningHeadlineLargeStyle: TextStyle.lerp(
        warningHeadlineLargeStyle,
        other.warningHeadlineLargeStyle,
        t,
      ),
      warningHeadlineMediumStyle: TextStyle.lerp(
        warningHeadlineMediumStyle,
        other.warningHeadlineMediumStyle,
        t,
      ),
      warningHeadlineSmallStyle: TextStyle.lerp(
        warningHeadlineSmallStyle,
        other.warningHeadlineSmallStyle,
        t,
      ),
      warningTitleLargeStyle: TextStyle.lerp(
        warningTitleLargeStyle,
        other.warningTitleLargeStyle,
        t,
      ),
      warningTitleMediumStyle: TextStyle.lerp(
        warningTitleMediumStyle,
        other.warningTitleMediumStyle,
        t,
      ),
      warningTitleSmallStyle: TextStyle.lerp(
        warningTitleSmallStyle,
        other.warningTitleSmallStyle,
        t,
      ),
      warningLabelLargeStyle: TextStyle.lerp(
        warningLabelLargeStyle,
        other.warningLabelLargeStyle,
        t,
      ),
      warningLabelMediumStyle: TextStyle.lerp(
        warningLabelMediumStyle,
        other.warningLabelMediumStyle,
        t,
      ),
      warningLabelSmallStyle: TextStyle.lerp(
        warningLabelSmallStyle,
        other.warningLabelSmallStyle,
        t,
      ),
      linkBodyMediumStyle: TextStyle.lerp(
        linkBodyMediumStyle,
        other.linkBodyMediumStyle,
        t,
      ),
      linkBodyLargeStyle: TextStyle.lerp(
        linkBodyLargeStyle,
        other.linkBodyLargeStyle,
        t,
      ),
      linkBodySmallStyle: TextStyle.lerp(
        linkBodySmallStyle,
        other.linkBodySmallStyle,
        t,
      ),
      linkDisplayLargeStyle: TextStyle.lerp(
        linkDisplayLargeStyle,
        other.linkDisplayLargeStyle,
        t,
      ),
      linkDisplayMediumStyle: TextStyle.lerp(
        linkDisplayMediumStyle,
        other.linkDisplayMediumStyle,
        t,
      ),
      linkDisplaySmallStyle: TextStyle.lerp(
        linkDisplaySmallStyle,
        other.linkDisplaySmallStyle,
        t,
      ),
      linkHeadlineLargeStyle: TextStyle.lerp(
        linkHeadlineLargeStyle,
        other.linkHeadlineLargeStyle,
        t,
      ),
      linkHeadlineMediumStyle: TextStyle.lerp(
        linkHeadlineMediumStyle,
        other.linkHeadlineMediumStyle,
        t,
      ),
      linkHeadlineSmallStyle: TextStyle.lerp(
        linkHeadlineSmallStyle,
        other.linkHeadlineSmallStyle,
        t,
      ),
      linkTitleLargeStyle: TextStyle.lerp(
        linkTitleLargeStyle,
        other.linkTitleLargeStyle,
        t,
      ),
      linkTitleMediumStyle: TextStyle.lerp(
        linkTitleMediumStyle,
        other.linkTitleMediumStyle,
        t,
      ),
      linkTitleSmallStyle: TextStyle.lerp(
        linkTitleSmallStyle,
        other.linkTitleSmallStyle,
        t,
      ),
      linkLabelLargeStyle: TextStyle.lerp(
        linkLabelLargeStyle,
        other.linkLabelLargeStyle,
        t,
      ),
      linkLabelMediumStyle: TextStyle.lerp(
        linkLabelMediumStyle,
        other.linkLabelMediumStyle,
        t,
      ),
      linkLabelSmallStyle: TextStyle.lerp(
        linkLabelSmallStyle,
        other.linkLabelSmallStyle,
        t,
      ),
      inverseBodyMediumStyle: TextStyle.lerp(
        inverseBodyMediumStyle,
        other.inverseBodyMediumStyle,
        t,
      ),
      inverseBodyLargeStyle: TextStyle.lerp(
        inverseBodyLargeStyle,
        other.inverseBodyLargeStyle,
        t,
      ),
      inverseBodySmallStyle: TextStyle.lerp(
        inverseBodySmallStyle,
        other.inverseBodySmallStyle,
        t,
      ),
      inverseDisplayLargeStyle: TextStyle.lerp(
        inverseDisplayLargeStyle,
        other.inverseDisplayLargeStyle,
        t,
      ),
      inverseDisplayMediumStyle: TextStyle.lerp(
        inverseDisplayMediumStyle,
        other.inverseDisplayMediumStyle,
        t,
      ),
      inverseDisplaySmallStyle: TextStyle.lerp(
        inverseDisplaySmallStyle,
        other.inverseDisplaySmallStyle,
        t,
      ),
      inverseHeadlineLargeStyle: TextStyle.lerp(
        inverseHeadlineLargeStyle,
        other.inverseHeadlineLargeStyle,
        t,
      ),
      inverseHeadlineMediumStyle: TextStyle.lerp(
        inverseHeadlineMediumStyle,
        other.inverseHeadlineMediumStyle,
        t,
      ),
      inverseHeadlineSmallStyle: TextStyle.lerp(
        inverseHeadlineSmallStyle,
        other.inverseHeadlineSmallStyle,
        t,
      ),
      inverseTitleLargeStyle: TextStyle.lerp(
        inverseTitleLargeStyle,
        other.inverseTitleLargeStyle,
        t,
      ),
      inverseTitleMediumStyle: TextStyle.lerp(
        inverseTitleMediumStyle,
        other.inverseTitleMediumStyle,
        t,
      ),
      inverseTitleSmallStyle: TextStyle.lerp(
        inverseTitleSmallStyle,
        other.inverseTitleSmallStyle,
        t,
      ),
      inverseLabelLargeStyle: TextStyle.lerp(
        inverseLabelLargeStyle,
        other.inverseLabelLargeStyle,
        t,
      ),
      inverseLabelMediumStyle: TextStyle.lerp(
        inverseLabelMediumStyle,
        other.inverseLabelMediumStyle,
        t,
      ),
      inverseLabelSmallStyle: TextStyle.lerp(
        inverseLabelSmallStyle,
        other.inverseLabelSmallStyle,
        t,
      ),
    );
  }
}
