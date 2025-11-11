import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/env/env.dart';

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

  Future<void> write({
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
    String? accessControlSettings,
  }) => state.write(
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
      accessControlSettings: accessControlSettings,
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
      accessControlSettings: accessControlSettings,
    ),
  );

  Future<String?> read({required String key}) => state.read(key: key);
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
    String? accessControlSettings,
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
    accessControlSettings: accessControlSettings ?? this.accessControlSettings,
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
    String? accessControlSettings,
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
    accessControlSettings: accessControlSettings ?? this.accessControlSettings,
    usesDataProtectionKeychain:
        usesDataProtectionKeychain ?? this.usesDataProtectionKeychain,
  );
}
