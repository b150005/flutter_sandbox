import 'package:flutter/material.dart';
import 'package:flutter_sandbox/features/capture.dart';
import 'package:screenshot/screenshot.dart';

class MainStatefulWidget extends StatefulWidget {
  const MainStatefulWidget({super.key});

  @override
  State<StatefulWidget> createState() => MainStatefulWidgetState();
}

class MainStatefulWidgetState extends State<MainStatefulWidget> {
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: _screenshotController,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sandbox'),
        ),
        body: const Center(
          child: Text('撮影できそう?'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => captureScreenshot(context, _screenshotController),
          child: Icon(Icons.camera),
        ),
      ),
    );
  }
}
