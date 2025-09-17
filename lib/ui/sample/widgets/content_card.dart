import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants/assets.dart';
import '../../../core/utils/extensions/string.dart';
import '../../../domain/models/content.dart';
import '../../core/themes/extensions/card_text_styles.dart';

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
                  style: Theme.of(
                    context,
                  ).extension<CardTextStyles>()?.titleStyle,
                ),
                if (content.subtitle.isNotNullAndNotEmpty)
                  Text(
                    content.subtitle!,
                    style: Theme.of(
                      context,
                    ).extension<CardTextStyles>()?.subtitleStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                Text(
                  content.description,
                  style: Theme.of(
                    context,
                  ).extension<CardTextStyles>()?.descriptionStyle,
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
