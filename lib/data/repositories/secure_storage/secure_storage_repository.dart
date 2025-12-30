import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/env/env.dart';
import '../../../core/utils/exceptions/app_exception.dart';
import '../../../core/utils/exceptions/exception_handler.dart';
import '../../../core/utils/l10n/app_localizations.dart';

part 'secure_storage_repository.g.dart';

@Riverpod(keepAlive: true)
class SecureStorageRepository extends _$SecureStorageRepository {
  @override
  FlutterSecureStorage build() => FlutterSecureStorage(
    iOptions: IOSOptions(
      accountName: Env.instance.appleKeychainAccountName,
      groupId: Env.instance.appleKeychainGroupId,
      accessibility: KeychainAccessibility.passcode,
      synchronizable: true,
    ),
    aOptions: AndroidOptions(
      sharedPreferencesName: Env.instance.androidSharedPreferencesName,
    ),
    webOptions: WebOptions(
      dbName: Env.instance.webDbName,
      publicKey: Env.instance.webPublicKey,
      wrapKey: Env.instance.webKeyEncryptionKey,
      wrapKeyIv: Env.instance.webKeyEncryptionIv,
    ),
    mOptions: MacOsOptions(
      accountName: Env.instance.appleKeychainAccountName,
      groupId: Env.instance.appleKeychainGroupId,
      accessibility: KeychainAccessibility.passcode,
      synchronizable: true,
    ),
  );

  Future<Result<void, AppException>> write({
    required String key,
    required String? value,
    String? label,
    String? description,
    String? comment,
    bool? isInvisible,
    bool? isNegative,
    DateTime? creationDate,
    DateTime? lastModifiedDate,
    int? resultLimit,
    bool? shouldReturnPersistentReference,
    String? authenticationUIBehavior,
    List<AccessControlFlag>? accessControlFlags,
  }) => ExceptionHandler.executeAsync(
    () => state.write(
      key: key,
      value: value,
      iOptions: state.iOptions.copyWith(
        label: label,
        description: description,
        comment: comment,
        isInvisible: isInvisible,
        isNegative: isNegative,
        creationDate: creationDate,
        lastModifiedDate: lastModifiedDate,
        resultLimit: resultLimit,
        shouldReturnPersistentReference: shouldReturnPersistentReference,
        authenticationUIBehavior: authenticationUIBehavior,
        accessControlFlags: accessControlFlags,
      ),
      mOptions: (state.mOptions as MacOsOptions).copyWith(
        label: label,
        description: description,
        comment: comment,
        isInvisible: isInvisible,
        isNegative: isNegative,
        creationDate: creationDate,
        lastModifiedDate: lastModifiedDate,
        resultLimit: resultLimit,
        shouldReturnPersistentReference: shouldReturnPersistentReference,
        authenticationUIBehavior: authenticationUIBehavior,
        accessControlFlags: accessControlFlags,
      ),
    ),
    l10n: ref.read(appLocalizationsProvider),
  );

  Future<Result<String?, AppException>> read({required String key}) =>
      ExceptionHandler.executeAsync(
        () => state.read(key: key),
        l10n: ref.read(appLocalizationsProvider),
      );
}

enum SecureStorageKey { email }

extension IOSOptionsExtension on IOSOptions {
  IOSOptions copyWith({
    String? accountName,
    String? groupId,
    KeychainAccessibility? accessibility,
    bool? synchronizable,
    String? label,
    String? description,
    String? comment,
    bool? isInvisible,
    bool? isNegative,
    DateTime? creationDate,
    DateTime? lastModifiedDate,
    int? resultLimit,
    bool? shouldReturnPersistentReference,
    String? authenticationUIBehavior,
    List<AccessControlFlag>? accessControlFlags,
  }) => IOSOptions(
    accountName: accountName ?? this.accountName,
    groupId: groupId ?? this.groupId,
    accessibility: accessibility ?? this.accessibility,
    synchronizable: synchronizable ?? this.synchronizable,
    label: label ?? this.label,
    description: description ?? this.description,
    comment: comment ?? this.comment,
    isInvisible: isInvisible ?? this.isInvisible,
    isNegative: isNegative ?? this.isNegative,
    creationDate: creationDate ?? this.creationDate,
    lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
    resultLimit: resultLimit ?? this.resultLimit,
    shouldReturnPersistentReference:
        shouldReturnPersistentReference ?? this.shouldReturnPersistentReference,
    authenticationUIBehavior:
        authenticationUIBehavior ?? this.authenticationUIBehavior,
    accessControlFlags: accessControlFlags ?? this.accessControlFlags,
  );
}

extension MacOsOptionsExtension on MacOsOptions {
  MacOsOptions copyWith({
    String? accountName,
    String? groupId,
    KeychainAccessibility? accessibility,
    bool? synchronizable,
    String? label,
    String? description,
    String? comment,
    bool? isInvisible,
    bool? isNegative,
    DateTime? creationDate,
    DateTime? lastModifiedDate,
    int? resultLimit,
    bool? shouldReturnPersistentReference,
    String? authenticationUIBehavior,
    List<AccessControlFlag>? accessControlFlags,
    bool? usesDataProtectionKeychain,
  }) => MacOsOptions(
    accountName: accountName ?? this.accountName,
    groupId: groupId ?? this.groupId,
    accessibility: accessibility ?? this.accessibility,
    synchronizable: synchronizable ?? this.synchronizable,
    label: label ?? this.label,
    description: description ?? this.description,
    comment: comment ?? this.comment,
    isInvisible: isInvisible ?? this.isInvisible,
    isNegative: isNegative ?? this.isNegative,
    creationDate: creationDate ?? this.creationDate,
    lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
    resultLimit: resultLimit ?? this.resultLimit,
    shouldReturnPersistentReference:
        shouldReturnPersistentReference ?? this.shouldReturnPersistentReference,
    authenticationUIBehavior:
        authenticationUIBehavior ?? this.authenticationUIBehavior,
    accessControlFlags: accessControlFlags ?? this.accessControlFlags,
    usesDataProtectionKeychain:
        usesDataProtectionKeychain ?? this.usesDataProtectionKeychain,
  );
}
