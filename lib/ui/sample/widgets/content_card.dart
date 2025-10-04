import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants/assets.dart';
import '../../../core/config/constants/spacing.dart';
import '../../../core/config/env/env.dart';
import '../../../core/utils/extensions/string.dart';
import '../../../domain/models/content.dart';

@Preview(name: 'Content Card', size: Size(200, 200))
Widget contentCard() => const ContentCard(
  content: Content(
    path: 'sample',
    title: 'title',
    description: 'description',
    subtitle: 'subtitle',
  ),
);

class ContentCard extends StatelessWidget {
  const ContentCard({super.key, required this.content});

  final Content content;

  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () => context.go(content.path),
      child: Column(
        children: [
          Flexible(
            child: kPreviewMode
                ? Image.network(
                    'https://picsum.photos/200',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Image.asset(
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
            padding: EdgeInsets.all(Spacing.xs.dp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  content.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (content.subtitle.isNotNullAndNotEmpty)
                  Text(
                    content.subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                Text(
                  content.description,
                  style: Theme.of(context).textTheme.bodySmall,
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
