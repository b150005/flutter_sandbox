part of '../../../../../../core/routing/router.dart';

class EmailSentScreenRoute extends GoRouteData with _$EmailSentScreenRoute {
  static const path = 'email-sent';
  static const absolutePath = '/sample/firebase/signup/email-sent';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EmailSentScreen();
}

class EmailSentScreen extends ConsumerWidget {
  const EmailSentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

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
