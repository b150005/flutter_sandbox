import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/config/constants/icon_size.dart';
import '../../../../../core/config/constants/spacing.dart';
import '../../../../../core/config/constants/widget_keys.dart';
import '../../../../../core/utils/extensions/bool.dart';
import '../../../../../core/utils/extensions/string.dart';
import '../../../../../core/utils/l10n/app_localizations.dart';
import '../../../../../core/utils/logging/log_message.dart';
import '../../../../../core/utils/logging/logger.dart';
import '../../../../../data/repositories/firebase/auth/auth_repository.dart';
import '../../../../core/themes/extensions/input_decoration_styles.dart';
import '../../../../core/themes/extensions/text_styles.dart';

@Preview(name: 'User Profile Form')
Widget userProfileForm() => ProviderScope(
  overrides: [
    // ignore: scoped_providers_should_specify_dependencies
    firebaseAuthProvider.overrideWith(
      (_) => MockFirebaseAuth(
        signedIn: true,
        mockUser: MockUser(
          uid: 'test-user-123',
          email: 'test@example.com',
          displayName: 'John Doe',
          phoneNumber: '+81-123-456-789',
          photoURL: 'https://picsum.photos/200',
          providerData: [
            UserInfo.fromJson({
              'uid': 'test@example.com',
              'email': 'test@example.com',
              'displayName': 'John Doe',
              'phoneNumber': '+81-123-456-789',
              'isAnonymous': false,
              'isEmailVerified': true,
              'providerId': 'password',
              'refreshToken': 'refresh-token-abc',
              'creationTimestamp': DateTime.utc(2000).millisecondsSinceEpoch,
              'lastSignInTimestamp': DateTime.utc(2001).millisecondsSinceEpoch,
            }),
            UserInfo.fromJson({
              'uid': 'test-user-abc',
              'email': 'test@example.com',
              'displayName': 'John Doe',
              'photoUrl': 'https://picsum.photos/200',
              'phoneNumber': '+81-123-456-789',
              'isAnonymous': false,
              'isEmailVerified': true,
              'providerId': 'google.com',
              'tenantId': 'google',
              'refreshToken': 'refresh-token-123',
              'creationTimestamp': DateTime.utc(2002).millisecondsSinceEpoch,
              'lastSignInTimestamp': DateTime.utc(2003).millisecondsSinceEpoch,
            }),
          ],
          refreshToken: 'refresh-token-123',
          metadata: UserMetadata(
            DateTime.utc(2004).millisecondsSinceEpoch,
            DateTime.utc(2005).millisecondsSinceEpoch,
          ),
        ),
      ),
    ),
  ],
  child: Builder(
    builder: (context) => MaterialApp(
      home: const UserProfileForm(),
      theme:
          ThemeData.light(
            useMaterial3: true,
          ).copyWith(
            extensions: [
              TextStyles.light(context),
              InputDecorationStyles.light(context),
            ],
          ),
      darkTheme:
          ThemeData.dark(
            useMaterial3: true,
          ).copyWith(
            extensions: [
              TextStyles.dark(context),
              InputDecorationStyles.dark(context),
            ],
          ),
      debugShowCheckedModeBanner: false,
    ),
  ),
);

class UserProfileForm extends HookConsumerWidget {
  const UserProfileForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final currentUser = firebaseAuth.currentUser;

    final l10n = ref.watch(appLocalizationsProvider);

    return Form(
      key: WidgetKeys.userProfileForm,
      child: Column(
        spacing: Spacing.md.dp,
        children: [
          CircleAvatar(
            key: WidgetKeys.avatar,
            backgroundImage: NetworkImage(
              (currentUser?.photoURL).orNullString(
                objectName: 'currentUser?.photoURL',
              ),
            ),
            onBackgroundImageError: (exception, stackTrace) =>
                Logger.instance.e(
                  LogMessage.failedToFetch(Uri(path: currentUser?.photoURL)),
                  error: exception,
                  stackTrace: stackTrace,
                ),
            radius: IconSize.lg.dp,
          ),
          Column(
            spacing: Spacing.sm.dp,
            children: [
              TextFormField(
                initialValue: currentUser?.displayName,
                decoration: Theme.of(context)
                    .extension<InputDecorationStyles>()
                    ?.outlined
                    .copyWith(
                      labelText: l10n.displayName,
                    ),
              ),
              TextFormField(
                initialValue: currentUser?.email,
                decoration: Theme.of(context)
                    .extension<InputDecorationStyles>()
                    ?.outlined
                    .copyWith(
                      labelText: l10n.email,
                    ),
              ),
              TextFormField(
                initialValue: currentUser?.phoneNumber,
                decoration: Theme.of(context)
                    .extension<InputDecorationStyles>()
                    ?.outlined
                    .copyWith(
                      labelText: l10n.phoneNumber,
                    ),
              ),
              TextFormField(
                initialValue: currentUser?.photoURL,
                decoration: Theme.of(context)
                    .extension<InputDecorationStyles>()
                    ?.outlined
                    .copyWith(
                      labelText: l10n.photoURL,
                    ),
              ),
              TextFormField(
                initialValue: (currentUser?.uid).orNullString(
                  // objectName: 'currentUser?.uid',
                ),
                decoration: Theme.of(context)
                    .extension<InputDecorationStyles>()
                    ?.outlined
                    .copyWith(
                      labelText: l10n.uid,
                    ),
                readOnly: true,
              ),
            ],
          ),
          const Divider(),
          Column(
            spacing: Spacing.sm.dp,
            children: [
              Row(
                spacing: Spacing.sm.dp,
                children: [
                  Text(
                    'User anonymous'.hardcoded,
                    style: Theme.of(
                      context,
                    ).extension<TextStyles>()?.emphasisLabelLargeStyle,
                  ),
                  Switch.adaptive(
                    value: (currentUser?.isAnonymous).orFalse(
                      // objectName: 'currentUser?.isAnonymous',
                    ),
                    onChanged: null,
                  ),
                ],
              ),
              Row(
                spacing: Spacing.sm.dp,
                children: [
                  Text(
                    'Email address verified'.hardcoded,
                    style: Theme.of(
                      context,
                    ).extension<TextStyles>()?.emphasisLabelLargeStyle,
                  ),
                  Switch.adaptive(
                    value: (currentUser?.emailVerified).orFalse(
                      // objectName: 'currentUser?.emailVerified',
                    ),
                    onChanged: null,
                  ),
                ],
              ),
              TextFormField(
                initialValue: (currentUser?.refreshToken).orNullString(
                  // objectName: 'currentUser?.refreshToken',
                ),
                decoration: Theme.of(context)
                    .extension<InputDecorationStyles>()
                    ?.outlined
                    .copyWith(
                      labelText: l10n.refreshToken,
                    ),
                readOnly: true,
              ),
              TextFormField(
                initialValue: (currentUser?.metadata.creationTime.toString())
                    .orNullString(
                      // objectName:
                      //     'currentUser?.metadata.creationTime.toString()',
                    ),
                decoration: Theme.of(context)
                    .extension<InputDecorationStyles>()
                    ?.outlined
                    .copyWith(
                      labelText: l10n.createdAt,
                    ),
                readOnly: true,
              ),
              TextFormField(
                initialValue: (currentUser?.metadata.lastSignInTime.toString())
                    .orNullString(
                      // objectName:
                      //     'currentUser?.metadata.creationTime.toString()',
                    ),
                decoration: Theme.of(context)
                    .extension<InputDecorationStyles>()
                    ?.outlined
                    .copyWith(
                      labelText: l10n.lastSignInAt,
                    ),
                readOnly: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
