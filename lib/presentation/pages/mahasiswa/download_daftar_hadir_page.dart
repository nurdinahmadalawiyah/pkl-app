import 'package:flutter/material.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/daftar_hadir_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DownloadDaftarHadirPage extends StatelessWidget {
  const DownloadDaftarHadirPage({super.key});

  @override
  Widget build(BuildContext context) {
    final daftarHadir = ModalRoute.of(context)?.settings.arguments as DaftarHadir;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: blackColor),
        title: Text(
          'Cetak PDF Daftar Hadir',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: tertiaryColor.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 40,
            offset: const Offset(0, 4),
          ),
        ]),
        child: SfPdfViewer.network(
          daftarHadir.pdfUrl,
          canShowPaginationDialog: true,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: tertiaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.all(15)),
          child: FittedBox(
            child: Text(
              'Download',
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: kSemiBold.copyWith(
                fontSize: 16,
                color: backgroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
