import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/nilai_pkl_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DownloadLembarPenilaianPage extends StatelessWidget {
  const DownloadLembarPenilaianPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nilaiPkl = ModalRoute.of(context)?.settings.arguments as NilaiPkl;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: blackColor),
        title: Text(
          'Cetak PDF Lembar Penilaian',
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
          nilaiPkl.pdfUrl,
          canShowPaginationDialog: true,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () async {
            try {
              await launch(
                nilaiPkl.pdfUrl,
                customTabsOption: CustomTabsOption(
                  enableDefaultShare: true,
                  enableUrlBarHiding: true,
                  showPageTitle: true,
                  animation: CustomTabsSystemAnimation.slideIn(),
                  extraCustomTabs: const <String>[
                    'org.mozilla.firefox',
                    'com.microsoft.emmx',
                  ],
                ),
              );
            } catch (e) {
              debugPrint(e.toString());
            }
          },
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
