import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants/assets.dart';
import '../../../core/config/constants/spacing.dart';
import '../../../core/utils/extensions/string.dart';
import '../../../domain/models/content.dart';
import '../../core/extensions/build_context.dart';
import '../../core/ui/utils/preview/wrapper.dart';

@Preview(name: 'Content Card', size: Size(200, 200), wrapper: wrapper)
Widget contentCard() => const ContentCard(
  content: Content(
    path: 'sample',
    title: 'title',
    description: 'description',
    subtitle: 'subtitle',
  ),
);

@immutable
class ContentCard extends StatelessWidget {
  const ContentCard({super.key, required this.content});

  final Content content;

  @override
  Widget build(BuildContext context) => Card.outlined(
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () => context.go(content.path),
      child: Column(
        children: [
          Flexible(
            child: Image.asset(
              content.thumbnailPath ?? Assets.flutterIcon.path,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                Assets.flutterIcon.path,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Spacing.sm.dp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    overflow: TextOverflow.ellipsis,
                  ),
                Text(
                  content.description,
                  style: context.textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
