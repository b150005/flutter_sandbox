import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_check_repository.g.dart';

@Riverpod(keepAlive: true)
FirebaseAppCheck firebaseAppCheck(Ref ref) => FirebaseAppCheck.instance;
