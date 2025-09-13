import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';

@visibleForTesting
enum TestUser {
  valid(email: 'valid@example.com', password: 'Val1dP@ssw0rd'),
  invalidEmail(email: 'invalid@example,com', password: 'Inval1dP@ssw0rd'),
  invalidPassword(email: 'invalid@example.com', password: 'Inval1dP@ssw0rd'),
  unknown(
    email: 'unknown@example.com',
    password: 'Unkn0wnP@ssw0rd',
  );

  const TestUser({required this.email, required this.password});

  final String email;
  final String password;

  MockUser get mock => MockUser(email: email);
}
