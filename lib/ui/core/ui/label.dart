import 'package:flutter/material.dart';

import '../../../core/config/constants/spacing.dart';
import '../extensions/build_context.dart';

class Label extends StatelessWidget {
  const Label(this.text, {super.key, this.child});

  final String text;
  final Widget? child;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: Spacing.xxs.dp,
    children: [
      Text(
        text,
        style: context.textTheme.labelMedium,
      ),
      ?child,
    ],
  );
}
