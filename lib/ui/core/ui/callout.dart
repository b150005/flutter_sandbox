import 'package:flutter/material.dart';

import '../../../core/config/constants/border_radii.dart';
import '../../../core/config/constants/icon_size.dart';
import '../../../core/config/constants/spacing.dart';
import '../../../core/config/constants/widget_keys.dart';
import '../../../core/config/l10n/app_localizations.dart';
import '../themes/extensions/text_styles.dart';

enum CalloutType {
  info(icon: Icons.info_outlined, color: Colors.blue),
  success(icon: Icons.check_circle_outlined, color: Colors.green),
  warning(icon: Icons.warning_amber_outlined, color: Colors.orange),
  error(icon: Icons.error_outline_outlined, color: Colors.red);

  const CalloutType({required this.icon, required this.color});

  final IconData icon;

  final MaterialColor color;

  String semanticsLabel(AppLocalizations l10n) => switch (this) {
    info => l10n.info,
    success => l10n.success,
    warning => l10n.warning,
    error => l10n.error,
  };

  Color get backgroundColor => color.shade50;

  Color get borderColor => color.shade200;

  Color get iconColor => switch (this) {
    info => color.shade700,
    _ => color.shade600,
  };

  Color get foregroundColor => color.shade900;
}

class Callout extends StatelessWidget {
  const Callout(
    this.message, {
    super.key,
    this.type = CalloutType.info,
    this.canDismiss = true,
    this.onDismiss,
    this.child,
  });

  final String message;

  final CalloutType type;

  final bool canDismiss;

  final VoidCallback? onDismiss;

  final Widget? child;

  @override
  Widget build(BuildContext context) => Container(
    key: WidgetKeys.callout,
    padding: EdgeInsets.all(Spacing.sm.dp),
    decoration: BoxDecoration(
      color: type.backgroundColor,
      border: Border.all(color: type.borderColor),
      borderRadius: BorderRadius.circular(BorderRadii.sm.value),
    ),
    child: Column(
      spacing: Spacing.xxs.dp,
      children: [
        Row(
          spacing: Spacing.xs.dp,
          children: [
            Icon(
              key: WidgetKeys.icon,
              type.icon,
              size: IconSize.sm.iconSize,
              color: type.iconColor,
            ),
            Expanded(
              child: Text(
                key: WidgetKeys.message,
                message,
                style: Theme.of(context)
                    .extension<TextStyles>()
                    ?.emphasisBodyLargeStyle
                    ?.copyWith(color: type.foregroundColor),
              ),
            ),
            if (canDismiss) ...[
              IconButton(
                key: WidgetKeys.dismiss,
                onPressed: onDismiss?.call,
                icon: Icon(
                  Icons.close,
                  color: type.iconColor,
                  size: IconSize.lg.iconSize,
                ),
              ),
            ],
          ],
        ),
        ?child,
      ],
    ),
  );
}
