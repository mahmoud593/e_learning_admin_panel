import 'package:e_learning_dathboard/styles/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class OpenPdf extends StatelessWidget {
  final String pdfUrl;
  final String title;
  const OpenPdf({super.key,required this.pdfUrl,required this.title});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: ColorManager.white
        ),
        backgroundColor: ColorManager.primary,
        title: Text(title,style: TextStyle(
          fontSize: 25,
          color: ColorManager.white
        ),),
      ),
      body: Column(
        children: [
          Expanded(
            child: SfPdfViewer.network(
                pdfUrl
            ),
          ),
        ],
      ),
    );
  }
}
