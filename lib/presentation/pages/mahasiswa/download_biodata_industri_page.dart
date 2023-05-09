import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/biodata_industri_model.dart';
import 'package:magang_app/presentation/cubit/biodata_industri/biodata_industri_cubit.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_connection_animation.dart';
import 'package:magang_app/presentation/widgets/no_data_animation.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DownloadBiodataIndustriPage extends StatefulWidget {
  const DownloadBiodataIndustriPage({super.key});

  @override
  State<DownloadBiodataIndustriPage> createState() =>
      _DownloadBiodataIndustriPageState();
}

class _DownloadBiodataIndustriPageState
    extends State<DownloadBiodataIndustriPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: blackColor),
        title: Text(
          'Cetak PDF Biodata Industri',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<BiodataIndustriCubit, BiodataIndustriState>(
        builder: (context, state) {
          if (state is BiodataIndustriLoading) {
            return const Center(child: LoadingAnimation());
          } else if (state is BiodataIndustriLoaded) {
            final biodataIndustri = state.biodataIndustri;
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
                biodataIndustri.pdfUrl,
                canShowPaginationDialog: true,
              ),
            );
          } else if (state is BiodataIndustriNoData) {
            final message = state.message;
            return Center(
              child: NoDataAnimation(message: message),
            );
          } else if (state is BiodataIndustriNoConnection) {
            final message = state.message;
            return Center(
              child: NoConnectionAnimation(message: message),
            );
          } else if (state is BiodataIndustriError) {
            final message = state.message;
            return Center(
              child: NoDataAnimation(message: message),
            );
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
      bottomNavigationBar:
          BlocBuilder<BiodataIndustriCubit, BiodataIndustriState>(
        builder: (context, state) {
          if (state is BiodataIndustriLoaded) {
            final biodataIndustri = state.biodataIndustri;
            return ButtonDownload(
              biodataIndustri: biodataIndustri,
            );
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
    );
  }
}

class ButtonDownload extends StatelessWidget {
  const ButtonDownload({
    super.key,
    required this.biodataIndustri,
  });

  final BiodataIndustri biodataIndustri;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () async {
          try {
            await launch(
              biodataIndustri.pdfUrl,
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
    );
  }
}
