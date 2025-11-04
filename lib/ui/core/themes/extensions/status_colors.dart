import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../../core/config/constants/spacing.dart';
import '../../extensions/build_context.dart';
import '../../ui/utils/preview/wrapper.dart';

@Preview(name: 'Theme Colors Palette', wrapper: wrapper)
Widget themeColorsPalette() => Builder(
  builder: (context) {
    final statusColors = context.statusColors;
    final colorScheme = context.colorScheme;

    return Wrap(
      children: [
        _PaletteGroup(
          children: [
            _Palette(
              labelText: 'success',
              color: statusColors.success,
              onColor: statusColors.onSuccess,
            ),
            _Palette(
              labelText: 'onSuccess',
              color: statusColors.onSuccess,
              onColor: statusColors.success,
            ),
            _Palette(
              labelText: 'successContainer',
              color: statusColors.successContainer,
              onColor: statusColors.onSuccessContainer,
            ),
            _Palette(
              labelText: 'onSuccessContainer',
              color: statusColors.onSuccessContainer,
              onColor: statusColors.successContainer,
            ),
          ],
        ),
        _PaletteGroup(
          children: [
            _Palette(
              labelText: 'failed',
              color: statusColors.failed,
              onColor: statusColors.onFailed,
            ),
            _Palette(
              labelText: 'onFailed',
              color: statusColors.onFailed,
              onColor: statusColors.failed,
            ),
            _Palette(
              labelText: 'failedContainer',
              color: statusColors.failedContainer,
              onColor: statusColors.onFailedContainer,
            ),
            _Palette(
              labelText: 'onFailedContainer',
              color: statusColors.onFailedContainer,
              onColor: statusColors.failedContainer,
            ),
          ],
        ),
        _PaletteGroup(
          children: [
            _Palette(
              labelText: 'primary',
              color: colorScheme.primary,
              onColor: colorScheme.onPrimary,
            ),
            _Palette(
              labelText: 'onPrimary',
              color: colorScheme.onPrimary,
              onColor: colorScheme.primary,
            ),
            _Palette(
              labelText: 'primaryContainer',
              color: colorScheme.primaryContainer,
              onColor: colorScheme.onPrimaryContainer,
            ),
            _Palette(
              labelText: 'onPrimaryContainer',
              color: colorScheme.onPrimaryContainer,
              onColor: colorScheme.primaryContainer,
            ),
            _Palette(
              labelText: 'primaryFixed',
              color: colorScheme.primaryFixed,
              onColor: colorScheme.onPrimaryFixed,
            ),
            _Palette(
              labelText: 'onPrimaryFixed',
              color: colorScheme.onPrimaryFixed,
              onColor: colorScheme.primaryFixed,
            ),
            _Palette(
              labelText: 'primaryFixedDim',
              color: colorScheme.primaryFixedDim,
              onColor: colorScheme.onPrimaryFixedVariant,
            ),
            _Palette(
              labelText: 'onPrimaryFixedVariant',
              color: colorScheme.onPrimaryFixedVariant,
              onColor: colorScheme.primaryFixedDim,
            ),
            _Palette(
              labelText: 'inversePrimary',
              color: colorScheme.inversePrimary,
              onColor: colorScheme.primary,
            ),
          ],
        ),
        _PaletteGroup(
          children: [
            _Palette(
              labelText: 'secondary',
              color: colorScheme.secondary,
              onColor: colorScheme.onSecondary,
            ),
            _Palette(
              labelText: 'onSecondary',
              color: colorScheme.onSecondary,
              onColor: colorScheme.secondary,
            ),
            _Palette(
              labelText: 'secondaryContainer',
              color: colorScheme.secondaryContainer,
              onColor: colorScheme.onSecondaryContainer,
            ),
            _Palette(
              labelText: 'onSecondaryContainer',
              color: colorScheme.onSecondaryContainer,
              onColor: colorScheme.secondaryContainer,
            ),
            _Palette(
              labelText: 'secondaryFixed',
              color: colorScheme.secondaryFixed,
              onColor: colorScheme.onSecondaryFixed,
            ),
            _Palette(
              labelText: 'onSecondaryFixed',
              color: colorScheme.onSecondaryFixed,
              onColor: colorScheme.secondaryFixed,
            ),
            _Palette(
              labelText: 'secondaryFixedDim',
              color: colorScheme.secondaryFixedDim,
              onColor: colorScheme.onSecondaryFixedVariant,
            ),
            _Palette(
              labelText: 'onSecondaryFixedVariant',
              color: colorScheme.onSecondaryFixedVariant,
              onColor: colorScheme.secondaryFixedDim,
            ),
          ],
        ),
        _PaletteGroup(
          children: [
            _Palette(
              labelText: 'tertiary',
              color: colorScheme.tertiary,
              onColor: colorScheme.onTertiary,
            ),
            _Palette(
              labelText: 'onTertiary',
              color: colorScheme.onTertiary,
              onColor: colorScheme.tertiary,
            ),
            _Palette(
              labelText: 'tertiaryContainer',
              color: colorScheme.tertiaryContainer,
              onColor: colorScheme.onTertiaryContainer,
            ),
            _Palette(
              labelText: 'onTertiaryContainer',
              color: colorScheme.onTertiaryContainer,
              onColor: colorScheme.tertiaryContainer,
            ),
            _Palette(
              labelText: 'tertiaryFixed',
              color: colorScheme.tertiaryFixed,
              onColor: colorScheme.onTertiaryFixed,
            ),
            _Palette(
              labelText: 'onTertiaryFixed',
              color: colorScheme.onTertiaryFixed,
              onColor: colorScheme.tertiaryFixed,
            ),
            _Palette(
              labelText: 'tertiaryFixedDim',
              color: colorScheme.tertiaryFixedDim,
              onColor: colorScheme.onTertiaryFixedVariant,
            ),
            _Palette(
              labelText: 'onTertiaryFixedVariant',
              color: colorScheme.onTertiaryFixedVariant,
              onColor: colorScheme.tertiaryFixedDim,
            ),
          ],
        ),
        _PaletteGroup(
          children: [
            _Palette(
              labelText: 'error',
              color: colorScheme.error,
              onColor: colorScheme.onError,
            ),
            _Palette(
              labelText: 'onError',
              color: colorScheme.onError,
              onColor: colorScheme.error,
            ),
            _Palette(
              labelText: 'errorContainer',
              color: colorScheme.errorContainer,
              onColor: colorScheme.onErrorContainer,
            ),
            _Palette(
              labelText: 'onErrorContainer',
              color: colorScheme.onErrorContainer,
              onColor: colorScheme.errorContainer,
            ),
          ],
        ),
        _PaletteGroup(
          children: [
            _Palette(
              labelText: 'surface',
              color: colorScheme.surface,
              onColor: colorScheme.onSurface,
            ),
            _Palette(
              labelText: 'onSurface',
              color: colorScheme.onSurface,
              onColor: colorScheme.surface,
            ),
            _Palette(
              labelText: 'surfaceDim',
              color: colorScheme.surfaceDim,
              onColor: colorScheme.onSurfaceVariant,
            ),
            _Palette(
              labelText: 'surfaceBright',
              color: colorScheme.surfaceBright,
              onColor: colorScheme.onSurfaceVariant,
            ),
            _Palette(
              labelText: 'surfaceContainerLowest',
              color: colorScheme.surfaceContainerLowest,
              onColor: colorScheme.onSurfaceVariant,
            ),
            _Palette(
              labelText: 'surfaceContainerLow',
              color: colorScheme.surfaceContainerLow,
              onColor: colorScheme.onSurfaceVariant,
            ),
            _Palette(
              labelText: 'surfaceContainer',
              color: colorScheme.surfaceContainer,
              onColor: colorScheme.onSurfaceVariant,
            ),
            _Palette(
              labelText: 'surfaceContainerHigh',
              color: colorScheme.surfaceContainerHigh,
              onColor: colorScheme.onSurfaceVariant,
            ),
            _Palette(
              labelText: 'surfaceContainerHighest',
              color: colorScheme.surfaceContainerHighest,
              onColor: colorScheme.onSurfaceVariant,
            ),
            _Palette(
              labelText: 'onSurfaceVariant',
              color: colorScheme.onSurfaceVariant,
              onColor: colorScheme.surfaceContainer,
            ),
            _Palette(
              labelText: 'surfaceTint',
              color: colorScheme.surfaceTint,
              onColor: colorScheme.surfaceContainer,
            ),
            _Palette(
              labelText: 'inverseSurface',
              color: colorScheme.inverseSurface,
              onColor: colorScheme.onInverseSurface,
            ),
            _Palette(
              labelText: 'onInverseSurface',
              color: colorScheme.onInverseSurface,
              onColor: colorScheme.inverseSurface,
            ),
          ],
        ),
        _PaletteGroup(
          children: [
            _Palette(
              labelText: 'outline',
              color: colorScheme.outline,
              onColor: colorScheme.outlineVariant,
            ),
            _Palette(
              labelText: 'outlineVariant',
              color: colorScheme.outlineVariant,
              onColor: colorScheme.outline,
            ),
          ],
        ),
        _PaletteGroup(
          children: [
            _Palette(
              labelText: 'shadow',
              color: colorScheme.shadow,
              onColor: colorScheme.surface,
            ),
          ],
        ),
        _PaletteGroup(
          children: [
            _Palette(
              labelText: 'scrim',
              color: colorScheme.scrim,
              onColor: colorScheme.surface,
            ),
          ],
        ),
      ],
    );
  },
);

@immutable
class _PaletteGroup extends StatelessWidget {
  const _PaletteGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    child: IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    ),
  );
}

@immutable
class _Palette extends StatelessWidget {
  const _Palette({
    required this.labelText,
    required this.color,
    required this.onColor,
  });

  final String labelText;
  final Color color;
  final Color onColor;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: color,
    child: Padding(
      padding: EdgeInsets.all(Spacing.sm.dp),
      child: Text(
        labelText,
        style: TextStyle(color: onColor),
      ),
    ),
  );
}

@immutable
class StatusColors extends ThemeExtension<StatusColors> {
  const StatusColors._({
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.failed,
    required this.onFailed,
    required this.failedContainer,
    required this.onFailedContainer,
  });

  factory StatusColors.fromSeed({
    Color successSeedColor = Colors.green,
    Brightness brightness = Brightness.light,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: successSeedColor,
      brightness: brightness,
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    );

    return StatusColors._(
      success: colorScheme.primary,
      onSuccess: colorScheme.onPrimary,
      successContainer: colorScheme.primaryContainer,
      onSuccessContainer: colorScheme.onPrimaryContainer,
      failed: colorScheme.error,
      onFailed: colorScheme.onError,
      failedContainer: colorScheme.errorContainer,
      onFailedContainer: colorScheme.onErrorContainer,
    );
  }

  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color failed;
  final Color onFailed;
  final Color failedContainer;
  final Color onFailedContainer;

  @override
  StatusColors copyWith({
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? failed,
    Color? onFailed,
    Color? failedContainer,
    Color? onFailedContainer,
  }) => StatusColors._(
    success: success ?? this.success,
    onSuccess: onSuccess ?? this.onSuccess,
    successContainer: successContainer ?? this.successContainer,
    onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
    failed: failed ?? this.failed,
    onFailed: onFailed ?? this.onFailed,
    failedContainer: failedContainer ?? this.failedContainer,
    onFailedContainer: onFailedContainer ?? this.onFailedContainer,
  );

  @override
  StatusColors lerp(
    StatusColors? other,
    double t,
  ) => other is StatusColors
      ? StatusColors._(
          success: Color.lerp(success, other.success, t)!,
          onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
          successContainer: Color.lerp(
            successContainer,
            other.successContainer,
            t,
          )!,
          onSuccessContainer: Color.lerp(
            onSuccessContainer,
            other.onSuccessContainer,
            t,
          )!,
          failed: Color.lerp(failed, other.failed, t)!,
          onFailed: Color.lerp(onFailed, other.onFailed, t)!,
          failedContainer: Color.lerp(
            failedContainer,
            other.failedContainer,
            t,
          )!,
          onFailedContainer: Color.lerp(
            onFailedContainer,
            other.onFailedContainer,
            t,
          )!,
        )
      : this;
}
