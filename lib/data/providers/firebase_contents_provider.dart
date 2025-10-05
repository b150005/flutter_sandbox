import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/routing/router.dart';
import '../../core/utils/l10n/app_localizations.dart';
import '../../domain/models/content.dart';

part 'firebase_contents_provider.g.dart';

@riverpod
List<Content> firebaseContents(Ref ref) {
  final l10n = ref.watch(appLocalizationsProvider);

  return [
    // TODO(b150005): Firebase コンテンツの追加
    Content(
      path: AuthScreenRoute.absolutePath,
      title: 'Auth',
      description: l10n.authScreenDescription,
      subtitle: 'Firebase Auth',
    ),
    Content(
      path: DataConnectScreenRoute.absolutePath,
      title: 'Data Connect',
      description: l10n.dataConnectScreenDescription,
      subtitle: 'Firebase Data Connect',
    ),
  ];
}
