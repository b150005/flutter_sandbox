import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/router.dart';
import '../../../core/utils/extensions/string.dart';
import '../../core/themes/extensions/card_text_styles.dart';

class SampleContentCard extends StatelessWidget {
  const SampleContentCard({super.key, required this.content});

  final SampleContent content;

  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: () => context.go(content.path),
      child: Column(
        children: [
          Flexible(
            child: Image.asset(
              content.thumbnailPath ?? 'assets/images/flutter-icon.png',
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/images/flutter-icon.png',
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
                if (content.subtitle.isNotNullOrEmpty)
                  Text(
                    content.subtitle!,
                    style: Theme.of(
                      context,
                    ).extension<CardTextStyles>()?.subtitleStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (content.description.isNotNullOrEmpty)
                  Text(
                    content.description!,
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
