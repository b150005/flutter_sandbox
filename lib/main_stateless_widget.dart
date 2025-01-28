import 'package:flutter/material.dart';

class MainStatelessWidget extends StatelessWidget {
  const MainStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hello World!'),
      ),
    );
  }
}
