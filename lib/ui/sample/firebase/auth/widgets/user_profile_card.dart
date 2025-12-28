import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/config/constants/icon_size.dart';
import '../../../../../core/config/constants/spacing.dart';
import '../../../../../core/config/constants/widget_keys.dart';
import '../../../../../core/utils/extensions/nullable.dart';
import '../../../../../core/utils/extensions/string.dart';
import '../../../../../core/utils/l10n/app_localizations.dart';
import '../../../../../core/utils/logging/log_message.dart';
import '../../../../../core/utils/logging/logger.dart';
import '../../../../core/extensions/build_context.dart';
import '../../../../core/ui/callout.dart';
import '../../../../core/ui/label.dart';
import '../../../../core/ui/pill.dart';
import '../../../../core/ui/property_table.dart';
import 'email_edit_dialog.dart';
import 'phone_number_edit_dialog.dart';

// TODO(b150005): バリデーションチェック, 変更処理
// email, password: EmailAuthProvider.credential
// reauthenticateWithCredential
// → updateEmail, updatePassword
// phoneNumber: PhoneAuthProvider.verifyPhoneNumber
// → PhoneAuthProvider.credential → updatePhoneNumber
// 上記以外: updateProfile
@immutable
class UserProfileCard extends HookConsumerWidget {
  const UserProfileCard({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = ref.watch(appLocalizationsProvider);

    final errorMessage = useState<String?>(null);

    return Card.outlined(
      key: WidgetKeys.userProfileCard,
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
              runSpacing: Spacing.sm.dp,
              children: [
                user.photoURL.isNullOrEmpty
                    ? ClipOval(
                        child: ColoredBox(
                          color: context.colorScheme.primaryContainer,
                          child: Padding(
                            padding: EdgeInsets.all(Spacing.sm.dp),
                            child: Icon(
                              Icons.person,
                              size: IconSize.lg.dp,
                            ),
                          ),
                        ),
                      )
                    : CircleAvatar(
                        key: WidgetKeys.avatar,
                        backgroundImage: NetworkImage(
                          user.photoURL!,
                        ),
                        onBackgroundImageError: (exception, stackTrace) =>
                            Logger.instance.e(
                              LogMessage.failedToFetch(
                                Uri(path: user.photoURL),
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
                    if (user.displayName.isNotNullAndNotEmpty)
                      Text(
                        key: WidgetKeys.displayName,
                        user.displayName!,
                        style: context.textTheme.headlineSmall,
                      ),
                    Text(
                      key: WidgetKeys.uid,
                      '@${user.uid}',
                      style: context.supportTextStyle,
                    ),
                    Wrap(
                      spacing: Spacing.xxs.dp,
                      runSpacing: Spacing.xxs.dp,
                      children: [
                        Pill(
                          key: WidgetKeys.emailVerified,
                          text: user.emailVerified
                              ? l10n.emailVerified
                              : l10n.emailUnverified,
                          iconData: user.emailVerified
                              ? Icons.verified_outlined
                              : Icons.warning_amber_outlined,
                          pillSize: PillSize.small,
                        ),
                        if (user.isAnonymous)
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
                  value: user.email.orNullString(
                    objectName: 'user.email',
                  ),
                  suffix: SelectionContainer.disabled(
                    child: TextButton(
                      key: WidgetKeys.editEmail,
                      onPressed: () => showAdaptiveDialog<void>(
                        context: context,
                        builder: (context) => EmailEditDialog(user: user),
                      ),
                      child: Text(l10n.edit),
                    ),
                  ),
                ),
                PropertyTableCellData(
                  key: WidgetKeys.phoneNumber,
                  label: l10n.phoneNumber,
                  value: user.phoneNumber.orNullString(
                    objectName: 'user.phoneNumber',
                  ),
                  suffix: SelectionContainer.disabled(
                    child: TextButton(
                      key: WidgetKeys.editPhoneNumber,
                      onPressed: () => showAdaptiveDialog<void>(
                        context: context,
                        builder: (context) => PhoneNumberEditDialog(user: user),
                      ),
                      child: Text(l10n.edit),
                    ),
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
                  user.photoURL.orNullString(
                    objectName: 'user.photoURL',
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
