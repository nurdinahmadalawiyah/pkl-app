import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/status_pengajuan_pkl_model.dart';


class DownloadSuratPengantarPklPage extends StatelessWidget {
  const DownloadSuratPengantarPklPage({super.key});

  @override
  Widget build(BuildContext context) {
    final status = ModalRoute.of(context)?.settings.arguments as LitsStatus;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: blackColor),
        title: Text(
          'Surat Pengantar PKL',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
     body: PDFView(
        filePath: status.surat!,
        // Menampilkan halaman PDF sesuai dengan ukuran layar perangkat
        fitEachPage: true,
        // Menampilkan kontrol untuk zoom in dan zoom out
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
      ),
    );
  }
}
