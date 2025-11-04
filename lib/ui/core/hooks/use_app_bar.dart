import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../extensions/build_context.dart';
import '../providers/app_bar_state_provider.dart';

void useAppBar(
  WidgetRef ref, {
  required String path,
  required AppBarState state,
}) {
  final context = ref.context;

  final isActiveRoute = context.isAt(path);

  useEffect(() {
    if (isActiveRoute) {
      Future.microtask(
        () => ref.read(appBarStateProvider.notifier).update(state),
      );
    }

    return null;
  }, [isActiveRoute]);
}
