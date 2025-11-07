part of '../../../../../../core/routing/router.dart';

class EmailSentScreenRoute extends GoRouteData with $EmailSentScreenRoute {
  static const path = '/email-sent';
  static const absolutePath = '/sample/firebase/signup/email-sent';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EmailSentScreen();
}

@immutable
class EmailSentScreen extends HookConsumerWidget {
  const EmailSentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    useAppBar(
      ref,
      path: EmailSentScreenRoute.absolutePath,
      state: AppBarState(title: Text(l10n.emailSent)),
    );

    return ScrollableContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: Spacing.xxxl.dp,
        children: [
          SizedBox(
            width: IconSize.xxxl.dp,
            child: Image.asset(Assets.firebase.path),
          ),
          Text(l10n.sentSignUpVerificationEmail),
        ],
      ),
    );
  }
}
