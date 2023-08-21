import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/presentation/cubit/catatan_khusus/catatan_khusus_cubit.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_connection_animation.dart';
import 'package:magang_app/presentation/widgets/no_data_animation.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DownloadCatatanKhususPage extends StatefulWidget {
  const DownloadCatatanKhususPage({super.key});

  @override
  State<DownloadCatatanKhususPage> createState() =>
      _DownloadCatatanKhususPageState();
}

class _DownloadCatatanKhususPageState extends State<DownloadCatatanKhususPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: blackColor),
        title: Text(
          'Cetak PDF Catatan Khusus PKL',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<CatatanKhususCubit, CatatanKhususState>(
        builder: (context, state) {
          if (state is CatatanKhususLoading) {
            return const Center(child: LoadingAnimation());
          } else if (state is CatatanKhususLoaded) {
            final catatanKhusus = state.catatanKhusus;
            return Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: tertiaryColor.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 40,
                  offset: const Offset(0, 4),
                ),
              ]),
              child: SfPdfViewer.network(
                catatanKhusus.pdfUrl,
                canShowPaginationDialog: true,
              ),
            );
          } else if (state is CatatanKhususNoData) {
            final message = state.message;
            return Center(
              child: NoConnectionAnimation(message: message),
            );
          } else if (state is CatatanKhususError) {
            final message = state.message;
            return Center(
              child: NoDataAnimation(message: message),
            );
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<CatatanKhususCubit, CatatanKhususState>(
        builder: (context, state) {
          if (state is CatatanKhususLoaded) {
            final catatanKhusus = state.catatanKhusus;
            return Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await launch(
                        catatanKhusus.pdfUrl,
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
                ));
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
    );
  }
}
