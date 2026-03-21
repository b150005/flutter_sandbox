import 'package:flutter/material.dart';

import '../../../core/config/constants/assets.dart';
import '../../../core/config/constants/spacing.dart';
import '../../../core/utils/extensions/string.dart';
import '../../../domain/models/content.dart';
import '../../core/extensions/build_context.dart';

@immutable
class ContentCard extends StatelessWidget {
  const ContentCard({super.key, required this.content});

  final Content content;

  @override
  Widget build(BuildContext context) => Card.outlined(
    clipBehavior: .antiAlias,
    child: InkWell(
      onTap: () => content.route.go(context),
      child: Column(
        children: [
          Flexible(
            child: Image.asset(
              content.thumbnailPath ?? Assets.flutterIcon.path,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                Assets.flutterIcon.path,
                fit: .cover,
                width: .infinity,
              ),
              fit: .cover,
              width: .infinity,
            ),
          ),
          Padding(
            padding: .all(Spacing.sm.dp),
            child: Column(
              crossAxisAlignment: .stretch,
              spacing: Spacing.xxs.dp,
              children: [
                Text(
                  content.title,
                  style: context.textTheme.titleLarge,
                ),
                if (content.subtitle.isNotNullAndNotEmpty)
                  Text(
                    content.subtitle!,
                    style: context.textTheme.bodySmall,
                    overflow: .ellipsis,
                  ),
                Text(
                  content.description,
                  style: context.textTheme.bodyMedium,
                  overflow: .ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
