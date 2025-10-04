import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants/assets.dart';
import '../../../core/utils/extensions/string.dart';
import '../../../domain/models/content.dart';

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
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  content.title,
                ),
                if (content.subtitle.isNotNullAndNotEmpty)
                  Text(
                    content.subtitle!,
                    overflow: TextOverflow.ellipsis,
                  ),
                Text(
                  content.description,
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
