import 'package:flutter/material.dart';
import 'package:flutter_sandbox/consts/text.dart';
import 'package:flutter_sandbox/features/capture.dart';
import 'package:screenshot/screenshot.dart';

import 'utils/string.dart';

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
        body: SingleChildScrollView(
          child: SelectionArea(
            child: Text(PlaceholderText.xxxxl.text),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => captureScreenshot(context, _screenshotController, longWidget(context)),
          child: Icon(Icons.camera),
        ),
      ),
    );
  }

  Widget longWidget(BuildContext context) {
    final List<Text> texts = splitStringByLength(PlaceholderText.xxxxl.text, maxLength: 200).map((String text) {
      return Text(text);
    }).toList();

    return Builder(builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: texts,
      );
    });
  }
}
