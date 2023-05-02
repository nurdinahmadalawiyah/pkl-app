import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart' as of;
import 'package:flutter/material.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/status_pengajuan_pkl_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DownloadSuratPengantarPklPage extends StatelessWidget {
  const DownloadSuratPengantarPklPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statusPengajuan =
        ModalRoute.of(context)?.settings.arguments as LitsStatus;

    Future<void> _downloadPdf(String url) async {
      final filename = url.split('/').last;
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/$filename';
      final file = File(path);
      if (file.existsSync()) {
        await file.delete();
      }

      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          await file.writeAsBytes(response.bodyBytes);
          final snackBar = SnackBar(
            content: Text('File $filename telah di unduh'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          await of.OpenFile.open(path);
        } else {
          final snackBar = SnackBar(
            content: Text('Gagal mengunduh file $filename'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (e) {
        final snackBar = SnackBar(
          content: Text('Terjadi kesalahan saat mengunduh file $filename'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: blackColor),
        title: Text(
          'Surat Pengantar PKL',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: tertiaryColor.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 40,
            offset: const Offset(0, 4),
          ),
        ]),
        child: SfPdfViewer.network(
          statusPengajuan.surat!,
          canShowPaginationDialog: true,
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () async {
            final status = await Permission.storage.request();
            if (status.isGranted) {
              final filename = statusPengajuan.surat!.split('/').last;
              final dir = await getApplicationDocumentsDirectory();
              final path = '${dir.path}/$filename';
              final file = File(path);
              if (file.existsSync()) {
                final snackBar = SnackBar(
                  content: Text('File $filename sedang di download'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                await _downloadPdf(statusPengajuan.surat!);
              }
            } else if (status.isDenied) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Akses Penyimpanan Diperlukan",
                        style: kMedium.copyWith(color: blackColor)),
                    content: Text(
                        "Aplikasi ini membutuhkan akses ke penyimpanan untuk menyimpan file unduhan. Buka pengaturan aplikasi untuk mengizinkan akses ke penyimpanan.",
                        style: kRegular.copyWith(color: blackColor)),
                    actions: [
                      TextButton(
                        child: Text("BATAL"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("BUKA PENGATURAN"),
                        onPressed: () {
                          openAppSettings();
                        },
                      ),
                    ],
                  );
                },
              );
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
