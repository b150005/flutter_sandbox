import 'package:flutter/material.dart';

import '../../../../core/config/constants/spacing.dart';

class ScrollableContainer extends StatelessWidget {
  const ScrollableContainer({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(padding: EdgeInsets.all(Spacing.sm.dp), child: child),
  );
}
