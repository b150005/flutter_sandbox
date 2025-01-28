import 'package:flutter/material.dart';
import 'package:flutter_sandbox/main_stateful_widget.dart';
import 'package:flutter_sandbox/main_stateless_widget.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainStatefulWidget(),
      // home: const MainStatelessWidget(),
    );
  }
}
