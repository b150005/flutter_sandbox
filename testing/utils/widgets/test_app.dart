import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@visibleForTesting
class TestApp extends StatelessWidget {
  const TestApp({
    super.key,
    this.overrides = const [],
    this.brightness = .light,
    this.extensions = const [],
    required this.child,
  });

  final List<Override> overrides;

  final Brightness brightness;

  final Iterable<ThemeExtension<dynamic>> extensions;

  final Widget child;

  @override
  Widget build(BuildContext context) => ProviderScope(
    overrides: overrides,
    child: MaterialApp(
      home: Scaffold(body: child),
      theme: ThemeData(
        useMaterial3: true,
        brightness: brightness,
      ).copyWith(extensions: extensions),
    ),
  );
}
