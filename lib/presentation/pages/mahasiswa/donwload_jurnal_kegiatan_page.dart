import 'package:flutter/material.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/jurnal_kegiatan_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DownloadJurnalKegiatanPage extends StatelessWidget {
  const DownloadJurnalKegiatanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final jurnalKegiatan =
        ModalRoute.of(context)?.settings.arguments as ListJurnalKegiatan;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: blackColor),
        title: Text(
          'Cetak PDF Jurnal Kegiatan',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: ListView(
        children: [
          Text(
            "Minggu ${jurnalKegiatan.minggu}",
            textAlign: TextAlign.center,
            style: kMedium.copyWith(color: blackColor, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: tertiaryColor.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 40,
                offset: const Offset(0, 4),
              ),
            ]),
            height: MediaQuery.of(context).size.height * 0.7,
            width: double.infinity,
            child: SfPdfViewer.network(
              jurnalKegiatan.pdfUrl,
              canShowPaginationDialog: true,
            ),
          ),
        ],
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
