import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/config/constants/spacing.dart';
import '../../../../../core/config/constants/widget_keys.dart';
import '../../../../../core/utils/extensions/async_snapshot.dart';
import '../../../../../core/utils/extensions/build_context.dart';
import '../../../../../core/utils/extensions/nullable.dart';
import '../../../../../core/utils/extensions/string.dart';
import '../../../../../core/utils/l10n/app_localizations.dart';
import '../../../../../core/utils/logging/log_message.dart';
import '../../../../../core/utils/logging/logger.dart';
import '../../../../../data/repositories/firebase/auth/auth_repository.dart';
import '../../../../core/ui/callout.dart';
import '../../../../core/ui/error_retry.dart';
import '../../../../core/ui/label.dart';
import '../../../../core/ui/property_table.dart';
import '../../../../core/ui/utils/preview/preview_mock_data.dart';
import '../../../../core/ui/utils/preview/wrapper.dart';

@Preview(name: 'User Auth Detail Card', wrapper: wrapper)
Widget userAuthDetailCard() => ProviderScope(
  overrides: [
    // ignore: scoped_providers_should_specify_dependencies
    firebaseAuthProvider.overrideWith(
      (_) => PreviewMockData.mockFirebaseAuth,
    ),
  ],
  child: const UserAuthDetailCard(),
);

@immutable
class UserAuthDetailCard extends HookConsumerWidget {
  const UserAuthDetailCard({super.key});

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

    return Card.outlined(
      key: WidgetKeys.userAuthDetailCard,
      child: Padding(
        padding: EdgeInsetsGeometry.all(Spacing.sm.dp),
        child: Column(
          spacing: Spacing.md.dp,
          children: [
            if (errorMessage.value.isNotNullAndNotEmpty)
              Callout(
                errorMessage.value!,
                type: CalloutType.error,
                onDismiss: () => errorMessage.value = null,
              ),
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Label(
                key: WidgetKeys.refreshToken,
                l10n.refreshToken,
                child: Text(
                  currentUser.refreshToken.orNullString(
                    objectName: 'currentUser.refreshToken',
                  ),
                ),
              ),
            ),
            // TODO(b150005): firebase_auth_mocks パッケージの対応待ち
            // Align(
            //   alignment: AlignmentGeometry.centerLeft,
            //   child: Label(
            //     key: WidgetKeys.tenantId,
            //     l10n.tenantId,
            //     child: Text(
            //       currentUser.tenantId.orNullString(
            //         objectName: 'currentUser.tenantId',
            //       ),
            //     ),
            //   ),
            // ),
            PropertyTable(
              cellData: [
                PropertyTableCellData(
                  key: WidgetKeys.creationTime,
                  label: l10n.createdAt,
                  value: currentUser.metadata.creationTime.orNullString(
                    objectName: 'currentUser.metadata.creationTime',
                  ),
                ),
                PropertyTableCellData(
                  key: WidgetKeys.lastSignInTime,
                  label: l10n.lastSignInAt,
                  value: currentUser.metadata.lastSignInTime.orNullString(
                    objectName: 'currentUser.metadata.creationTime',
                  ),
                ),
              ],
              columnCount: 2,
            ),
            ...currentUser.providerData.map(
              (userInfo) => Card.outlined(
                child: Padding(
                  padding: EdgeInsets.all(Spacing.sm.dp),
                  child: PropertyTable(
                    cellData: [
                      PropertyTableCellData(
                        key: WidgetKeys.providerId,
                        label: l10n.providerId,
                        value: userInfo.providerId,
                      ),
                      PropertyTableCellData(
                        key: WidgetKeys.uid,
                        label: l10n.uid,
                        value: userInfo.uid.orNullString(
                          objectName: 'userInfo.uid',
                        ),
                      ),
                      PropertyTableCellData(
                        key: WidgetKeys.displayName,
                        label: l10n.displayName,
                        value: userInfo.displayName.orNullString(
                          objectName: 'userInfo.displayName',
                        ),
                      ),
                      PropertyTableCellData(
                        key: WidgetKeys.email,
                        label: l10n.email,
                        value: userInfo.email.orNullString(
                          objectName: 'userInfo.email',
                        ),
                      ),
                      PropertyTableCellData(
                        key: WidgetKeys.phoneNumber,
                        label: l10n.phoneNumber,
                        value: userInfo.phoneNumber.orNullString(
                          objectName: 'userInfo.phoneNumber',
                        ),
                      ),
                      PropertyTableCellData(
                        key: WidgetKeys.photoURL,
                        label: l10n.photoURL,
                        value: userInfo.photoURL.orNullString(
                          objectName: 'userInfo.photoURL',
                        ),
                      ),
                    ],
                    columnCount: 2,
                  ),
                ),
              ),
            ),
            _IdTokenResultTable(
              user: currentUser,
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
class _IdTokenResultTable extends HookConsumerWidget {
  const _IdTokenResultTable({required this.user});

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final retriedAt = useState<DateTime?>(null);

    final idTokenResultFuture = useMemoized(user.getIdTokenResult, [
      retriedAt,
    ]);
    final idTokenResultAsyncSnapshot = useFuture(idTokenResultFuture);

    return idTokenResultAsyncSnapshot.when(
      loading: () => context.loadingIndicator,
      error: (error, stackTrace) {
        Logger.instance.e(
          LogMessage.unhandledError,
          error: error,
          stackTrace: stackTrace,
        );

        return ErrorRetry(
          onPressed: () => retriedAt.value = DateTime.now(),
        );
      },
      data: (idTokenResult) => Column(
        spacing: Spacing.md.dp,
        children: [
          PropertyTable(
            cellData: [
              PropertyTableCellData(
                key: WidgetKeys.signInProvider,
                label: l10n.signInProvider,
                value: (idTokenResult?.signInProvider).orNullString(
                  objectName: 'idTokenResult?.signInProvider',
                ),
              ),
              PropertyTableCellData(
                key: WidgetKeys.signInSecondFactor,
                label: l10n.signInSecondFactor,
                value: (idTokenResult?.signInSecondFactor).orNullString(
                  objectName: 'idTokenResult?.signInSecondFactor',
                ),
              ),
              PropertyTableCellData(
                key: WidgetKeys.token,
                label: l10n.idToken,
                value: (idTokenResult?.token).orNullString(
                  objectName: 'idTokenResult?.token',
                ),
              ),
              PropertyTableCellData(
                key: WidgetKeys.authTime,
                label: l10n.authenticatedAt,
                value: (idTokenResult?.authTime).orNullString(
                  objectName: 'idTokenResult?.authTime',
                ),
              ),
              PropertyTableCellData(
                key: WidgetKeys.issuedAtTime,
                label: l10n.issuedAt,
                value: (idTokenResult?.issuedAtTime).orNullString(
                  objectName: 'idTokenResult?.issuedAtTime',
                ),
              ),
              PropertyTableCellData(
                key: WidgetKeys.expirationTime,
                label: l10n.expiredAt,
                value: (idTokenResult?.expirationTime).orNullString(
                  objectName: 'idTokenResult?.expirationTime',
                ),
              ),
            ],
            columnCount: 2,
          ),
          Label(
            key: WidgetKeys.claims,
            l10n.payloadClaims,
            child: Text(
              (idTokenResult?.claims).orNullString(
                objectName: 'idTokenResult?.claims',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
