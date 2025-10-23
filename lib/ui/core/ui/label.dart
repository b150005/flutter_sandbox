import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../../../core/config/constants/spacing.dart';
import '../../../core/utils/extensions/build_context.dart';

@Preview(name: 'Label')
Widget label() => const Label(
  'label',
  child: Text('Child'),
);

class Label extends StatelessWidget {
  const Label(this.text, {super.key, this.child});

  final String text;
  final Widget? child;

  @override
  Widget build(BuildContext context) => Column(
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
