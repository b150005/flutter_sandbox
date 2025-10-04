import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/config/constants/icon_size.dart';
import '../../../../../core/config/constants/spacing.dart';
import '../../../../../core/config/constants/widget_keys.dart';
import '../../../../../core/utils/extensions/async_snapshot.dart';
import '../../../../../core/utils/extensions/bool.dart';
import '../../../../../core/utils/extensions/string.dart';
import '../../../../../core/utils/l10n/app_localizations.dart';
import '../../../../../core/utils/logging/log_message.dart';
import '../../../../../core/utils/logging/logger.dart';
import '../../../../../data/repositories/firebase/auth/auth_repository.dart';

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
          idTokenAuthTime: DateTime.utc(2006),
          idTokenExp: DateTime.utc(2007),
          customClaim: {
            'sub': 'user-123',
            'email': 'test@example.com',
            'email_verified': true,
            'name': 'John Doe',
            'picture': 'https://picsum.photos/200',
            'exp': 1704603600,
            'iat': 1704600000,
            'auth_time': 1704599999,
          },
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
            extensions: [],
          ),
      darkTheme:
          ThemeData.dark(
            useMaterial3: true,
          ).copyWith(
            extensions: [],
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

    final idTokenResultFuture = useMemoized(
      () => currentUser?.getIdTokenResult(),
    );
    final idTokenResultAsyncSnapshot = useFuture(idTokenResultFuture);

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
                decoration: InputDecoration(labelText: l10n.displayName),
              ),
              TextFormField(
                initialValue: currentUser?.email,
                decoration: InputDecoration(
                  labelText: l10n.email,
                ),
              ),
              TextFormField(
                initialValue: currentUser?.phoneNumber,
                decoration: InputDecoration(
                  labelText: l10n.phoneNumber,
                ),
              ),
              TextFormField(
                initialValue: currentUser?.photoURL,
                decoration: InputDecoration(
                  labelText: l10n.photoURL,
                ),
              ),
              TextFormField(
                initialValue: (currentUser?.uid).orNullString(
                  objectName: 'currentUser?.uid',
                ),
                decoration: InputDecoration(
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
                    l10n.anonymousUser,
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge,
                  ),
                  Switch.adaptive(
                    value: (currentUser?.isAnonymous).orFalse(
                      objectName: 'currentUser?.isAnonymous',
                    ),
                    onChanged: null,
                  ),
                ],
              ),
              Row(
                spacing: Spacing.sm.dp,
                children: [
                  Text(
                    l10n.emailVerification,
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge,
                  ),
                  Switch.adaptive(
                    value: (currentUser?.emailVerified).orFalse(
                      objectName: 'currentUser?.emailVerified',
                    ),
                    onChanged: null,
                  ),
                ],
              ),
              TextFormField(
                initialValue: (currentUser?.refreshToken).orNullString(
                  objectName: 'currentUser?.refreshToken',
                ),
                decoration: InputDecoration(
                  labelText: l10n.refreshToken,
                ),
                readOnly: true,
              ),
              TextFormField(
                initialValue: (currentUser?.metadata.creationTime.toString())
                    .orNullString(
                      objectName:
                          'currentUser?.metadata.creationTime.toString()',
                    ),
                decoration: InputDecoration(
                  labelText: l10n.createdAt,
                ),
                readOnly: true,
              ),
              TextFormField(
                initialValue: (currentUser?.metadata.lastSignInTime.toString())
                    .orNullString(
                      objectName:
                          'currentUser?.metadata.creationTime.toString()',
                    ),
                decoration: InputDecoration(
                  labelText: l10n.lastSignInAt,
                ),
                readOnly: true,
              ),
              idTokenResultAsyncSnapshot.when(
                loading: () => CircularProgressIndicator.adaptive(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                error: (error, stackTrace) {
                  Logger.instance.e(
                    LogMessage.unhandledError,
                    error: error,
                    stackTrace: stackTrace,
                  );

                  return const Placeholder();
                },
                data: (idTokenResult) => Column(
                  spacing: Spacing.sm.dp,
                  children: [
                    TextFormField(
                      initialValue: (idTokenResult?.signInProvider?.toString())
                          .orNullString(
                            objectName:
                                'idTokenResult?.signInProvider?.toString()',
                          ),
                      decoration: InputDecoration(
                        labelText: l10n.signInProvider,
                      ),
                      readOnly: true,
                    ),
                    TextFormField(
                      initialValue: (idTokenResult?.signInSecondFactor?.toString())
                          .orNullString(
                            objectName:
                                'idTokenResult?.signInSecondFactor?.toString()',
                          ),
                      decoration: InputDecoration(
                        labelText: l10n.signInSecondFactor,
                      ),
                      readOnly: true,
                    ),
                    TextFormField(
                      initialValue: (idTokenResult?.authTime?.toString())
                          .orNullString(
                            objectName: 'idTokenResult?.authTime?.toString()',
                          ),
                      decoration: InputDecoration(
                        labelText: l10n.authenticatedAt,
                      ),
                      readOnly: true,
                    ),
                    TextFormField(
                      initialValue: (idTokenResult?.token?.toString())
                          .orNullString(
                            objectName: 'idTokenResult?.token?.toString()',
                          ),
                      decoration: InputDecoration(labelText: l10n.idToken),
                      readOnly: true,
                    ),
                    TextFormField(
                      initialValue: (idTokenResult?.claims?.toString())
                          .orNullString(
                            objectName: 'idTokenResult?.claims?.toString()',
                          ),
                      decoration: InputDecoration(
                        labelText: l10n.payloadClaims,
                      ),
                      readOnly: true,
                    ),
                    TextFormField(
                      initialValue: (idTokenResult?.issuedAtTime?.toString())
                          .orNullString(
                            objectName:
                                'idTokenResult?.issuedAtTime?.toString()',
                          ),
                      decoration: InputDecoration(labelText: l10n.issuedAt),
                      readOnly: true,
                    ),
                    TextFormField(
                      initialValue: (idTokenResult?.expirationTime?.toString())
                          .orNullString(
                            objectName:
                                'idTokenResult?.expirationTime?.toString()',
                          ),
                      decoration: InputDecoration(labelText: l10n.expiredAt),
                      readOnly: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
