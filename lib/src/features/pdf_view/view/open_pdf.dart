import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdfreader/src/models/file_info.dart';

class OpenPDF extends StatelessWidget {
  final FileInfo fileInfo;
  const OpenPDF({super.key, required this.fileInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          fileInfo.name,
          style: const TextStyle(color: Colors.white,fontSize: 15),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: PDFView(
        filePath: fileInfo.path,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onError: (error) {},
        onPageError: (page, error) {},
        onViewCreated: (_) {},
      ),
    );
  }
}
