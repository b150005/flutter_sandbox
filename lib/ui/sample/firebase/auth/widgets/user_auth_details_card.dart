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
import '../../../../core/ui/label.dart';
import '../../../../core/ui/property_table.dart';
import '../../../../core/ui/utils/preview/preview_mock_data.dart';
import '../../../../core/ui/utils/preview/wrapper.dart';

@Preview(name: 'User Auth Details Card', wrapper: wrapper)
Widget userAuthDetailsCard() => ProviderScope(
  overrides: [
    // ignore: scoped_providers_should_specify_dependencies
    firebaseAuthProvider.overrideWith(
      (_) => PreviewMockData.mockFirebaseAuth,
    ),
  ],
  child: const UserAuthDetailsCard(),
);

@immutable
class UserAuthDetailsCard extends HookConsumerWidget {
  const UserAuthDetailsCard({super.key});

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

    return Card.outlined(
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
            PropertyTable(
              cellData: [
                PropertyTableCellData(
                  key: WidgetKeys.createdAt,
                  label: l10n.createdAt,
                  value: currentUser.metadata.creationTime.orNullString(
                    objectName: 'currentUser.metadata.creationTime',
                  ),
                ),
                PropertyTableCellData(
                  key: WidgetKeys.lastSignInAt,
                  label: l10n.lastSignInAt,
                  value: currentUser.metadata.lastSignInTime.orNullString(
                    objectName: 'currentUser.metadata.creationTime',
                  ),
                ),
              ],
              columnCount: 2,
            ),
            idTokenResultAsyncSnapshot.when(
              loading: () => context.loadingIndicator,
              error: (error, stackTrace) {
                Logger.instance.e(
                  LogMessage.unhandledError,
                  error: error,
                  stackTrace: stackTrace,
                );

                // TODO(b150005): ID Token 取得に失敗した場合のエラー UI 実装
                return const Placeholder();
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
                        key: WidgetKeys.authenticatedAt,
                        label: l10n.authenticatedAt,
                        value: (idTokenResult?.authTime).orNullString(
                          objectName: 'idTokenResult?.authTime',
                        ),
                      ),
                      PropertyTableCellData(
                        key: WidgetKeys.issuedAt,
                        label: l10n.issuedAt,
                        value: (idTokenResult?.issuedAtTime).orNullString(
                          objectName: 'idTokenResult?.issuedAtTime',
                        ),
                      ),
                      PropertyTableCellData(
                        key: WidgetKeys.expiredAt,
                        label: l10n.expiredAt,
                        value: (idTokenResult?.expirationTime).orNullString(
                          objectName: 'idTokenResult?.expirationTime',
                        ),
                      ),
                    ],
                    columnCount: 2,
                  ),
                  Label(
                    key: WidgetKeys.payloadClaims,
                    l10n.payloadClaims,
                    child: Text(
                      (idTokenResult?.claims).orNullString(
                        objectName: 'idTokenResult?.claims',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
