import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/config/constants/spacing.dart';
import '../../../../../core/config/constants/widget_keys.dart';
import '../../../../../core/utils/extensions/async_snapshot.dart';
import '../../../../../core/utils/extensions/nullable.dart';
import '../../../../../core/utils/extensions/string.dart';
import '../../../../../core/utils/l10n/app_localizations.dart';
import '../../../../../core/utils/logging/log_message.dart';
import '../../../../../core/utils/logging/logger.dart';
import '../../../../core/extensions/build_context.dart';
import '../../../../core/ui/callout.dart';
import '../../../../core/ui/label.dart';
import '../../../../core/ui/property_table.dart';
import '../../../../core/ui/retry_button.dart';

@immutable
class UserAuthDetailCard extends HookConsumerWidget {
  const UserAuthDetailCard({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

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
                  user.refreshToken.orNullString(
                    objectName: 'user.refreshToken',
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Label(
                key: WidgetKeys.tenantId,
                l10n.tenantId,
                child: Text(
                  user.tenantId.orNullString(
                    objectName: 'user.tenantId',
                  ),
                ),
              ),
            ),
            PropertyTable(
              cellData: [
                PropertyTableCellData(
                  key: WidgetKeys.creationTime,
                  label: l10n.createdAt,
                  value: user.metadata.creationTime.orNullString(
                    objectName: 'user.metadata.creationTime',
                  ),
                ),
                PropertyTableCellData(
                  key: WidgetKeys.lastSignInTime,
                  label: l10n.lastSignInAt,
                  value: user.metadata.lastSignInTime.orNullString(
                    objectName: 'user.metadata.creationTime',
                  ),
                ),
              ],
              columnCount: 2,
            ),
            ...user.providerData.map(
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
              user: user,
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

        return RetryButton(
          onPressed: () => retriedAt.value = DateTime.now(),
        );
      },
      data: (idTokenResult) => Column(
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
            ],
            columnCount: 2,
          ),
          Align(
            alignment: AlignmentGeometry.centerLeft,
            child: Label(
              key: WidgetKeys.token,
              l10n.idToken,
              child: Text(
                (idTokenResult?.token).orNullString(
                  objectName: 'idTokenResult?.token',
                ),
              ),
            ),
          ),
          PropertyTable(
            cellData: [
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
          Align(
            alignment: AlignmentGeometry.centerLeft,
            child: Label(
              key: WidgetKeys.claims,
              l10n.payloadClaims,
              child: Text(
                (idTokenResult?.claims).orNullString(
                  objectName: 'idTokenResult?.claims',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
