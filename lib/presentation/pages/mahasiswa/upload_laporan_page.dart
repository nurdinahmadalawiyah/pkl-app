import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/presentation/cubit/pelaporan/upload_laporan_cubit.dart';
import 'package:magang_app/presentation/widgets/loading_button.dart';

class UploadLaporanPage extends StatefulWidget {
  const UploadLaporanPage({super.key});

  @override
  State<UploadLaporanPage> createState() => _UploadLaporanPageState();
}

class _UploadLaporanPageState extends State<UploadLaporanPage> {
  final _formKey = GlobalKey<FormState>();
  final cubit = UploadLaporanCubit();

  @override
  void initState() {
    super.initState();
    cubit.resetState();
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
          if (state is UploadLaporanSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<UploadLaporanCubit>().resetState();
              showSuccessDialog(context);
            });
          } else {
            return FormUpload(formKey: _formKey, cubit: cubit);
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<UploadLaporanCubit, UploadLaporanState>(
        builder: (context, state) {
          if (state is UploadLaporanSuccess) {
            return const LoadingButton();
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
            return ButtonUpload(formKey: _formKey, cubit: cubit);
          }
        },
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
              primary: primaryColor,
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
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
            child: ListTile(
              onTap: () {},
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              leading: const Icon(
                IconlyBold.document,
                color: primaryColor,
              ),
              title: Text(
                "file.pdf",
                style: kMedium.copyWith(color: blackColor, fontSize: 16),
              ),
              trailing: const Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
              ),
            ),
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
          if (_formKey.currentState!.validate()) {
            final path = cubit.fileController.text;
            File laporan = File(path);
            if (laporan != null) {
              cubit.uploadLaporan(laporan);
              cubit.resetForm();
            } else {
              cubit.resetState();
              cubit.fileController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Form Laporan tidak boleh kosong'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          primary: tertiaryColor,
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
