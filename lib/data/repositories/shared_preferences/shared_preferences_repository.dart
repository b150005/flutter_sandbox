import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_repository.g.dart';

@riverpod
SharedPreferencesAsync sharedPreferencesRepository(Ref ref) =>
    SharedPreferencesAsync();

enum SharedPreferencesKeys { emailForSignIn }
