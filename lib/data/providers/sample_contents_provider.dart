import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/routing/router.dart';
import '../../core/utils/l10n/app_localizations.dart';
import '../../domain/models/content.dart';

part 'sample_contents_provider.g.dart';

@riverpod
List<Content> sampleContents(Ref ref) {
  final l10n = ref.watch(appLocalizationsProvider);

  return [
    Content(
      path: FirebaseScreenRoute.absolutePath,
      title: 'Firebase',
      description: l10n.signInScreenDescription,
      subtitle: 'Firebase Sign-In',
    ),
    Content(
      path: LocalStorageScreenRoute.absolutePath,
      title: 'Local Storage',
      description: l10n.localStorageScreenDescription,
      subtitle: 'Local Storage Sandbox',
    ),
  ];
}
