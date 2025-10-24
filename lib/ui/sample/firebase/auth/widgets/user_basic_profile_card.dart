import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/config/constants/icon_size.dart';
import '../../../../../core/config/constants/spacing.dart';
import '../../../../../core/config/constants/widget_keys.dart';
import '../../../../../core/utils/extensions/build_context.dart';
import '../../../../../core/utils/extensions/nullable.dart';
import '../../../../../core/utils/extensions/string.dart';
import '../../../../../core/utils/l10n/app_localizations.dart';
import '../../../../../core/utils/logging/log_message.dart';
import '../../../../../core/utils/logging/logger.dart';
import '../../../../../data/repositories/firebase/auth/auth_repository.dart';
import '../../../../core/ui/callout.dart';
import '../../../../core/ui/label.dart';
import '../../../../core/ui/pill.dart';

@Preview(name: 'User Basic Profile')
Widget userBasicProfile() => ProviderScope(
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
      home: const UserBasicProfileCard(),
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

// TODO(b150005): バリデーションチェック, 変更処理
// email, password: EmailAuthProvider.credential
// reauthenticateWithCredential
// → updateEmail, updatePassword
// phoneNumber: PhoneAuthProvider.verifyPhoneNumber
// → PhoneAuthProvider.credential → updatePhoneNumber
// 上記以外: updateProfile
@immutable
class UserBasicProfileCard extends HookConsumerWidget {
  const UserBasicProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    final currentUser = firebaseAuth.currentUser;

    final l10n = ref.watch(appLocalizationsProvider);

    if (currentUser == null) {
      return Callout(
        l10n.notFound,
        type: CalloutType.error,
      );
    }

    final errorMessage = useState<String?>(null);

    final idTokenResultFuture = useMemoized(currentUser.getIdTokenResult);
    final idTokenResultAsyncSnapshot = useFuture(idTokenResultFuture);

    final isLoading = useState<bool>(false);

    return Card.outlined(
      child: Padding(
        padding: EdgeInsets.all(Spacing.md.dp),
        child: Column(
          spacing: Spacing.md.dp,
          children: [
            if (errorMessage.value.isNotNullAndNotEmpty)
              Callout(
                errorMessage.value!,
                type: CalloutType.error,
                onDismiss: () => errorMessage.value = null,
              ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: Spacing.md.dp,
              runSpacing: Spacing.xxs.dp,
              children: [
                CircleAvatar(
                  key: WidgetKeys.avatar,
                  backgroundImage: NetworkImage(
                    currentUser.photoURL.orNullString(
                      objectName: 'currentUser.photoURL',
                    ),
                  ),
                  onBackgroundImageError: (exception, stackTrace) =>
                      Logger.instance.e(
                        LogMessage.failedToFetch(
                          Uri(path: currentUser.photoURL),
                        ),
                        error: exception,
                        stackTrace: stackTrace,
                      ),
                  radius: IconSize.lg.dp,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: Spacing.xxs.dp,
                  children: [
                    if (currentUser.displayName.isNotNullAndNotEmpty)
                      Text(
                        key: WidgetKeys.displayName,
                        currentUser.displayName!,
                        style: context.textTheme.headlineSmall,
                      ),
                    Text(
                      key: WidgetKeys.uid,
                      '@${currentUser.uid}',
                      style: context.supportTextStyle,
                    ),
                    Wrap(
                      spacing: Spacing.xxs.dp,
                      runSpacing: Spacing.xxs.dp,
                      children: [
                        Pill(
                          key: WidgetKeys.emailVerified,
                          text: currentUser.emailVerified
                              ? l10n.emailVerified
                              : l10n.emailUnverified,
                          iconData: currentUser.emailVerified
                              ? Icons.verified_outlined
                              : Icons.warning_amber_outlined,
                        ),
                        if (currentUser.isAnonymous)
                          Pill(
                            key: WidgetKeys.isAnonymous,
                            text: l10n.anonymousUser,
                            iconData: Icons.masks_outlined,
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Table(
              children: [
                TableRow(
                  children: [
                    Label(
                      l10n.email,
                      child: Text(
                        currentUser.email.orNullString(
                          objectName: 'currentUser.email',
                        ),
                        key: WidgetKeys.email,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    Label(
                      l10n.phoneNumber,
                      child: Text(
                        currentUser.phoneNumber.orNullString(
                          objectName: 'currentUser.phoneNumber',
                        ),
                        key: WidgetKeys.phoneNumber,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Label(
                l10n.photoURL,
                child: Text(
                  currentUser.photoURL.orNullString(
                    objectName: 'currentUser.photoURL',
                  ),
                  key: WidgetKeys.photoURL,
                  style: context.textTheme.bodyMedium,
                ),
              ),
            ),
            // Column(
            //   spacing: Spacing.sm.dp,
            //   children: [
            //     TextFormField(
            //       initialValue: currentUser.refreshToken.orNullString(
            //         objectName: 'currentUser.refreshToken',
            //       ),
            //       decoration: InputDecoration(
            //         labelText: l10n.refreshToken,
            //       ),
            //       readOnly: true,
            //     ),
            //     TextFormField(
            //       initialValue: currentUser.metadata.creationTime.orNullString(
            //         objectName: 'currentUser.metadata.creationTime',
            //       ),
            //       decoration: InputDecoration(
            //         labelText: l10n.createdAt,
            //       ),
            //       readOnly: true,
            //     ),
            //     TextFormField(
            //       initialValue: currentUser.metadata.lastSignInTime.orNullString(
            //         objectName: 'currentUser.metadata.creationTime',
            //       ),
            //       decoration: InputDecoration(
            //         labelText: l10n.lastSignInAt,
            //       ),
            //       readOnly: true,
            //     ),
            //     idTokenResultAsyncSnapshot.when(
            //       loading: () => CircularProgressIndicator.adaptive(
            //         backgroundColor: context.colorScheme.onPrimary,
            //       ),
            //       error: (error, stackTrace) {
            //         Logger.instance.e(
            //           LogMessage.unhandledError,
            //           error: error,
            //           stackTrace: stackTrace,
            //         );

            //         return const Placeholder();
            //       },
            //       data: (idTokenResult) => Column(
            //         spacing: Spacing.sm.dp,
            //         children: [
            //           TextFormField(
            //             initialValue: idTokenResult?.signInProvider.orNullString(
            //               objectName: 'idTokenResult?.signInProvider',
            //             ),
            //             decoration: InputDecoration(
            //               labelText: l10n.signInProvider,
            //             ),
            //             readOnly: true,
            //           ),
            //           TextFormField(
            //             initialValue: idTokenResult?.signInSecondFactor
            //                 .orNullString(
            //                   objectName: 'idTokenResult?.signInSecondFactor',
            //                 ),
            //             decoration: InputDecoration(
            //               labelText: l10n.signInSecondFactor,
            //             ),
            //             readOnly: true,
            //           ),
            //           TextFormField(
            //             initialValue: idTokenResult?.authTime.orNullString(
            //               objectName: 'idTokenResult?.authTime',
            //             ),
            //             decoration: InputDecoration(
            //               labelText: l10n.authenticatedAt,
            //             ),
            //             readOnly: true,
            //           ),
            //           TextFormField(
            //             initialValue: idTokenResult?.token.orNullString(
            //               objectName: 'idTokenResult?.token',
            //             ),
            //             decoration: InputDecoration(labelText: l10n.idToken),
            //             readOnly: true,
            //           ),
            //           TextFormField(
            //             initialValue: idTokenResult?.claims.orNullString(
            //               objectName: 'idTokenResult?.claims',
            //             ),
            //             decoration: InputDecoration(
            //               labelText: l10n.payloadClaims,
            //             ),
            //             readOnly: true,
            //           ),
            //           TextFormField(
            //             initialValue: idTokenResult?.issuedAtTime.orNullString(
            //               objectName: 'idTokenResult?.issuedAtTime',
            //             ),
            //             decoration: InputDecoration(labelText: l10n.issuedAt),
            //             readOnly: true,
            //           ),
            //           TextFormField(
            //             initialValue: idTokenResult?.expirationTime.orNullString(
            //               objectName: 'idTokenResult?.expirationTime',
            //             ),
            //             decoration: InputDecoration(labelText: l10n.expiredAt),
            //             readOnly: true,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
