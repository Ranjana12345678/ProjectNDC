import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
class AppNoticePdfViewer extends StatefulWidget {
  final String pdfName;
  const AppNoticePdfViewer({Key? key, required this.pdfName}) : super(key: key);

  @override
  State<AppNoticePdfViewer> createState() => _AppNoticePdfViewerState();
}

class _AppNoticePdfViewerState extends State<AppNoticePdfViewer> {

  late File Pfile;
  bool isLoading = false;

  Future<void> loadNetwork() async {
    setState(() {
      isLoading = true;
    });
    var url = widget.pdfName;
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final filename = basename(url);
    final dir = await getTemporaryDirectory();
    var file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);

    setState(() {
      Pfile = file;
    });

    print(Pfile);

    setState(() {
      isLoading = false;
    });

  }



  @override
  void initState() {
    loadNetwork();
    super.initState();
    print("pdf url ${widget.pdfName}");


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading ? Center(child: CircularProgressIndicator(),):
        SafeArea(
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black87,
                    width: 2.0
                )
            ),
            child: PDFView(
              filePath: Pfile.path,
              // nightMode: true,
            ),
          ),
        )
    );
  }
}
