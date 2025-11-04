import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/config/constants/spacing.dart';
import '../../../core/utils/extensions/string.dart';
import '../extensions/build_context.dart';
import 'utils/preview/wrapper.dart';

@Preview(name: 'Status Indicator', wrapper: wrapper)
Widget statusIndicator() => Column(
  spacing: Spacing.sm.dp,
  children: const [
    StatusIndicator(isValid: true, message: 'valid'),
    StatusIndicator(isValid: false, message: 'invalid'),
  ],
);

class StatusIndicator extends HookWidget {
  const StatusIndicator({
    super.key,
    required this.isValid,
    this.message,
  });

  final bool isValid;

  final String? message;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 400),
    );

    useEffect(() {
      animationController
        ..reset()
        ..forward();

      return null;
    }, [isValid]);

    final scale = useAnimation(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutCirc,
      ),
    );

    final color = isValid
        ? context.statusColors.successContainer
        : context.statusColors.failed;

    final icon = Transform.scale(
      scale: scale,
      child: Icon(
        isValid ? Icons.check_circle_rounded : Icons.cancel_rounded,
        color: color,
      ),
    );

    if (message.isNullOrEmpty) {
      return icon;
    }

    return Row(
      spacing: Spacing.xs.dp,
      children: [
        icon,
        Flexible(
          child: Text(
            message!,
            style: context.textTheme.bodyMedium?.copyWith(
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
