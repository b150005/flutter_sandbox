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
import '../../../../core/ui/property_table.dart';
import '../../../../core/ui/utils/preview/preview_mock_data.dart';
import '../../../../core/ui/utils/preview/wrapper.dart';

@Preview(name: 'User Profile Card', wrapper: wrapper)
Widget userProfileCard() => ProviderScope(
  overrides: [
    // ignore: scoped_providers_should_specify_dependencies
    firebaseAuthProvider.overrideWith(
      (_) => PreviewMockData.mockFirebaseAuth,
    ),
  ],
  child: const UserProfileCard(),
);

// TODO(b150005): バリデーションチェック, 変更処理
// email, password: EmailAuthProvider.credential
// reauthenticateWithCredential
// → updateEmail, updatePassword
// phoneNumber: PhoneAuthProvider.verifyPhoneNumber
// → PhoneAuthProvider.credential → updatePhoneNumber
// 上記以外: updateProfile
@immutable
class UserProfileCard extends HookConsumerWidget {
  const UserProfileCard({super.key});

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
                          pillSize: PillSize.small,
                        ),
                        if (currentUser.isAnonymous)
                          Pill(
                            key: WidgetKeys.isAnonymous,
                            text: l10n.anonymousUser,
                            iconData: Icons.masks_outlined,
                            pillSize: PillSize.small,
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            PropertyTable(
              cellData: [
                PropertyTableCellData(
                  key: WidgetKeys.email,
                  label: l10n.email,
                  value: currentUser.email.orNullString(
                    objectName: 'currentUser.email',
                  ),
                ),
                PropertyTableCellData(
                  key: WidgetKeys.phoneNumber,
                  label: l10n.phoneNumber,
                  value: currentUser.phoneNumber.orNullString(
                    objectName: 'currentUser.phoneNumber',
                  ),
                ),
              ],
              columnCount: 2,
            ),
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Label(
                key: WidgetKeys.photoURL,
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
          ],
        ),
      ),
    );
  }
}
