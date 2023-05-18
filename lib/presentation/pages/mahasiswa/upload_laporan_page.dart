import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/upload_laporan_model.dart';
import 'package:magang_app/presentation/cubit/pelaporan/upload_laporan_cubit.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/loading_button.dart';
import 'package:path/path.dart' as path;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class UploadLaporanPage extends StatefulWidget {
  const UploadLaporanPage({Key? key}) : super(key: key);

  @override
  State<UploadLaporanPage> createState() => _UploadLaporanPageState();
}

class _UploadLaporanPageState extends State<UploadLaporanPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<UploadLaporanCubit>().resetForm();
    context.read<UploadLaporanCubit>().getLaporan();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UploadLaporanCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Upload Laporan PKL',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<UploadLaporanCubit, UploadLaporanState>(
        builder: (context, state) {
          if (state is UploadLaporanLoading) {
            return const Center(
              child: LoadingAnimation(),
            );
          } else if (state is LaporanLoaded) {
            final laporan = state.laporan;
            return ListView(
              children: [
                Laporan(laporan: laporan),
              ],
            );
          } else if (state is UploadLaporanSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<UploadLaporanCubit>().resetState();
              showSuccessDialog(context);
            });
            return Container();
          } else if (state is UploadLaporanError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<UploadLaporanCubit>().resetState();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Terjadi kesalahan: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            });
            return Container();
          } else {
            return FormUpload(
              cubit: cubit,
              formKey: _formKey,
            );
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<UploadLaporanCubit, UploadLaporanState>(
        builder: (context, state) {
          if (state is UploadLaporanSuccess) {
            return const LoadingButton();
          } else if (state is LaporanLoaded) {
            return const SizedBox();
          } else {
            return ButtonUpload(formKey: _formKey, cubit: cubit);
          }
        },
      ),
    );
  }
}

class Laporan extends StatelessWidget {
  const Laporan({
    super.key,
    required this.laporan,
  });

  final UploadLaporan laporan;

  @override
  Widget build(BuildContext context) {
    final UploadLaporanCubit hapusCubit = UploadLaporanCubit();

    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.3,
      secondaryActions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: IconSlideAction(
            caption: 'Hapus Data',
            color: Colors.red,
            icon: IconlyBold.delete,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Batalkan Kirim Laporan?",
                        style: kMedium.copyWith(color: tertiaryColor)),
                    content: Text(
                        "Apakah Anda yakin ingin membatalkan? membatalkan akan menghapus file laporan dari server",
                        style: kRegular.copyWith(color: tertiaryColor)),
                    actions: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        onPressed: () async {
                          await hapusCubit
                              .cancelLaporan(laporan.data.idLaporan.toString());
                          Navigator.of(context).pop();
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/upload-laporan',
                              ModalRoute.withName('/dashboard'));
                        },
                        child: const Text("Hapus"),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: primaryColor,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Batal"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              width: double.infinity,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(
                    IconlyBold.paper,
                    size: 100,
                    color: Colors.black45,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    path.basename(laporan.data.file),
                    style: kRegular.copyWith(
                      fontSize: 14,
                      color: tertiaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    laporan.data.nama,
                    style: kMedium.copyWith(
                      fontSize: 15,
                      color: tertiaryColor,
                    ),
                  ),
                  Text(
                    laporan.data.nim,
                    style: kMedium.copyWith(
                      fontSize: 14,
                      color: tertiaryColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: accentColor,
                            title: Text(
                              path.basename(laporan.data.file),
                              style: kRegular.copyWith(color: tertiaryColor),
                            ),
                            contentPadding: EdgeInsets.zero,
                            insetPadding: const EdgeInsets.only(
                                right: 10, bottom: 10, left: 10),
                            content: SfPdfViewer.network(
                              laporan.data.file,
                              canShowPaginationDialog: true,
                            ),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: primaryColor,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Tutup'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(15),
                    ),
                    child: FittedBox(
                      child: Text(
                        'Lihat Laporan >',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: kMedium.copyWith(
                          fontSize: 15,
                          color: backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: accentColor,
        title: Text(
          'Upload Laporan',
          style: kSemiBold.copyWith(color: tertiaryColor),
        ),
        content: Text(
          'Berhasil Upload Laporan PKL',
          style: kRegular.copyWith(color: tertiaryColor),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(context, '/upload-laporan',
                  ModalRoute.withName('/dashboard'));
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

class FormUpload extends StatelessWidget {
  const FormUpload({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final UploadLaporanCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        IconlyBold.paper,
                        size: 150,
                        color: Colors.black45,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'Pilih File Untuk di Upload',
                        style: kMedium.copyWith(
                          fontSize: 15,
                          color: tertiaryColor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();

                          if (result != null) {
                            File file = File(result.files.single.path!);
                            cubit.selectFile(file);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(15),
                        ),
                        child: FittedBox(
                          child: Text(
                            'Browse',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: kMedium.copyWith(
                              fontSize: 15,
                              color: backgroundColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Card(
            color: accentColor,
            margin: EdgeInsets.zero,
            elevation: 0,
            child: cubit.state.selectedFile != null
                ? ListTile(
                    onTap: null,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    leading: const Icon(
                      IconlyBold.document,
                      color: primaryColor,
                    ),
                    title: Text(
                      path.basename(cubit.state.selectedFile!.path),
                      style: kRegular.copyWith(color: blackColor, fontSize: 14),
                    ),
                    trailing: const Icon(
                      Icons.check_circle_rounded,
                      color: Colors.green,
                    ),
                  )
                : Container(),
          ),
        ),
      ],
    );
  }
}

class ButtonUpload extends StatelessWidget {
  const ButtonUpload({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final UploadLaporanCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () async {
          if (cubit.state.selectedFile != null) {
            final path = cubit.state.selectedFile?.path;
            File laporan = File(path!);
            cubit.uploadLaporan(laporan);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Form Laporan tidak boleh kosong'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: tertiaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(15),
        ),
        child: FittedBox(
          child: Text(
            'Upload',
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
