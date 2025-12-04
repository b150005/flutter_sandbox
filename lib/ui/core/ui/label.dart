import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../core/config/constants/spacing.dart';
import '../extensions/build_context.dart';
import 'utils/preview/wrapper.dart';

@Preview(name: 'Label', wrapper: wrapper)
Widget label() => Builder(
  builder: (context) => Label(
    'label',
    child: Text('Child', style: context.textTheme.bodyMedium),
  ),
);

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
