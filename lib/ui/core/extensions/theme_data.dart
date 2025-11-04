import 'package:flutter/material.dart';

import '../themes/extensions/status_colors.dart';

extension ThemeDataExtension on ThemeData {
  StatusColors get statusColors =>
      extension<StatusColors>() ?? StatusColors.fromSeed();
}
