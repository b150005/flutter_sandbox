import 'dart:typed_data';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';

/// スクリーンショット撮影を行う
Future<void> captureScreenshot(BuildContext context, ScreenshotController controller, Widget widget) async {
  try {
    // 現在の画面をキャプチャ
    // WARNING: HTML Renderer だと以下の例外が発生する
    // DartError: Unsupported operation: toImage is not supported on the Web
    controller
        .captureFromLongWidget(
      InheritedTheme.captureAll(
        context,
        Material(
          child: widget,
        ),
      ),
      delay: Duration(milliseconds: 100),
      context: context,
    )
        .then((Uint8List? capturedImage) async {
      if (!context.mounted) return;
      showDialog(
        useSafeArea: false,
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Captured screenshot'),
            ),
            body: Center(
              child: Image.memory(capturedImage!),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                printImage(capturedImage);
              },
              child: Icon(Icons.print),
            ),
          );
        },
      );
    }).catchError((dynamic onError) {
      developer.log(onError.toString());
    });
  } catch (e) {
    final String message = 'エラーが発生しました: $e';
    developer.log(message);

    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

/// PDF 変換, 印刷を行う
Future<void> printImage(Uint8List image) async {
  // PDFドキュメントを作成
  final pdf = pw.Document();
  final pdfImage = pw.MemoryImage(image);

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(pdfImage),
        );
      },
    ),
  );

  // 印刷プレビューダイアログを表示
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
    name: 'スクリーンショット_${DateTime.now().toString()}',
  );
}
