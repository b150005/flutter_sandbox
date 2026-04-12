import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sandbox/core/utils/exceptions/app_exception.dart';
import 'package:flutter_sandbox/core/utils/l10n/app_localizations.dart';
import 'package:flutter_sandbox/data/repositories/firebase/auth/auth_repository.dart';
import 'package:multiple_result/src/result.dart';

import 'test_user.dart';

@visibleForTesting
class FakeAuthRepository extends AuthRepository {
  FakeAuthRepository({
    bool isAuthenticated = true,
    Set<TestUser> registeredUsers = const {.valid},
    Completer<void>? signInCompleter,
    Completer<void>? updatePasswordCompleter,
  }) : _isAuthenticated = isAuthenticated,
       _registeredUsers = registeredUsers,
       _updatePasswordCompleter = updatePasswordCompleter,
       _signInCompleter = signInCompleter;

  final bool _isAuthenticated;

  final Set<TestUser> _registeredUsers;

  final Completer<void>? _updatePasswordCompleter;
  final Completer<void>? _signInCompleter;

  @override
  Stream<User?> build() => Stream.value(null);

  @override
  Future<Result<void, AppException>> updatePassword({
    required String password,
  }) async {
    await (_updatePasswordCompleter?.future ?? Future<void>.value());

    if (!_isAuthenticated) {
      final l10n = ref.read(appLocalizationsProvider);
      return .error(.unauthorized(l10n.authenticationFailed));
    }

    return const .success(null);
  }

  @override
  Future<Result<void, AppException>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await (_signInCompleter?.future ?? Future<void>.value());

    if (_registeredUsers.any(
      (user) => user.email == email && user.password == password,
    )) {
      return const .success(null);
    }

    final l10n = ref.read(appLocalizationsProvider);

    return .error(.unauthorized(l10n.invalidEmailOrPassword));
  }
}
