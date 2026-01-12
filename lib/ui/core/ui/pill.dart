import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../core/config/constants/spacing.dart';
import '../../../core/utils/extensions/string.dart';
import '../extensions/build_context.dart';
import 'utils/preview/wrapper.dart';

@Preview(name: 'Pill', wrapper: wrapper)
Widget pill() => Wrap(
  spacing: Spacing.xs.dp,
  runSpacing: Spacing.xs.dp,
  children: const [
    Pill(),
    Pill(
      text: 'Text Only',
    ),
    Pill(
      iconData: Icons.check_circle_sharp,
    ),
    Pill(
      text: 'Text + Icon',
      iconData: Icons.check_circle_sharp,
    ),
    Pill(
      text: 'Small',
      iconData: Icons.check_circle_sharp,
      pillSize: PillSize.small,
    ),
    Pill(
      text: 'Medium',
      iconData: Icons.check_circle_sharp,
    ),
    Pill(
      text: 'Large',
      iconData: Icons.check_circle_sharp,
      pillSize: PillSize.large,
    ),
  ],
);

enum PillSize {
  small(dp: 12, padding: EdgeInsets.symmetric(vertical: 2)),
  medium(dp: 16, padding: EdgeInsets.symmetric(vertical: 2)),
  large(dp: 20, padding: EdgeInsets.symmetric(vertical: 2));

  const PillSize({required this.dp, required this.padding});

  final double dp;
  final EdgeInsetsGeometry padding;
}

@immutable
class Pill extends StatelessWidget {
  const Pill({
    super.key,
    this.text,
    this.iconData,
    this.foregroundColor,
    this.backgroundColor,
    this.pillSize = PillSize.medium,
  });

  final String? text;
  final IconData? iconData;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final PillSize pillSize;

  @override
  Widget build(BuildContext context) {
    final textColor = foregroundColor ?? context.colorScheme.onPrimary;
    final textSize = pillSize.dp;

    return Badge(
      backgroundColor: backgroundColor ?? context.colorScheme.primary,
      textColor: textColor,
      largeSize: textSize,
      textStyle: TextStyle(fontSize: textSize),
      label: Padding(
        padding: text.isNullOrEmpty
            ? EdgeInsetsGeometry.zero
            : pillSize.padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null)
              Icon(
                iconData,
                size: textSize,
                color: textColor,
              ),
            if (text.isNotNullAndNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.xxs.dp),
                child: Text(text!),
              ),
          ],
        ),
      ),
    );
  }
}
