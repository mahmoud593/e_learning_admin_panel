import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class OpenPdf extends StatefulWidget {
  final String pdfUrl;
  final String title;
  final bool isImage;

  const OpenPdf({super.key, required this.pdfUrl, required this.title,required this.isImage});

  @override
  State<OpenPdf> createState() => _OpenPdfState();
}

class _OpenPdfState extends State<OpenPdf> {
  bool _isPdfError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorManager.white),
        backgroundColor: ColorManager.primary,
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 22, color: ColorManager.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.isImage
                ? Center(
              child: Image.network(
                widget.pdfUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text("⚠️ لا يمكن عرض الملف"),
                  );
                },
              ),
            )
                : SfPdfViewer.network(
              widget.pdfUrl,
              onDocumentLoadFailed: (error) {
              },
            ),
          ),
        ],
      ),
    );
  }
}
