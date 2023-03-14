// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/presentation/cubit/tambah_daftar_hadir_cubit.dart';
import 'package:magang_app/presentation/widgets/date_picker_form_field.dart';
import 'package:magang_app/presentation/widgets/loading_button.dart';
import 'package:signature/signature.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class TambahDaftarHadirPage extends StatefulWidget {
  const TambahDaftarHadirPage({super.key});

  @override
  State<TambahDaftarHadirPage> createState() => _TambahDaftarHadirPageState();
}

class _TambahDaftarHadirPageState extends State<TambahDaftarHadirPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TambahDaftarHadirCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Tambah Daftar Hadir',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<TambahDaftarHadirCubit, TambahDaftarHadirState>(
        builder: (context, state) {
          if (state is TambahDaftarHadirSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<TambahDaftarHadirCubit>().resetState();
              showSuccessDialog(context);
            });
          } else {
            return ListView(
              children: [
                formAddDaftarHadir(cubit),
              ],
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar:
          BlocBuilder<TambahDaftarHadirCubit, TambahDaftarHadirState>(
        builder: (context, state) {
          if (state is TambahDaftarHadirSuccess) {
            return const LoadingButton();
          } else if (state is TambahDaftarHadirError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<TambahDaftarHadirCubit>().resetState();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Terjadi kesalahan: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            });
            return Container();
          } else {
            return ButtonAdd(formKey: _formKey, cubit: cubit);
          }
        },
      ),
    );
  }

  Container formAddDaftarHadir(TambahDaftarHadirCubit cubit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DatePickerFormField(
              controller: cubit.hariTanggalController,
              labelText: "Hari/Tanggal",
              onDateSelected: (DateTime date) {
                setState(() {});
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: cubit.mingguController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: accentColor,
                labelText: 'Minggu',
                labelStyle: const TextStyle(color: Color(0xFF585656)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    width: 2,
                    style: BorderStyle.solid,
                    color: primaryColor,
                  ),
                ),
                prefixIcon: const Icon(
                  IconlyBold.calendar,
                  color: primaryColor,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Data Minggu tidak boleh kosong';
                }
                return null;
              },
              style: const TextStyle(color: tertiaryColor),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Tanda Tangan',
              style: kRegular.copyWith(fontSize: 12, color: tertiaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Signature(
                controller: cubit.tandaTanganController,
                backgroundColor: accentColor,
                height: 250,
                width: double.infinity,
                dynamicPressureSupported: true,
              ),
            ),
            GestureDetector(
              onTap: () => cubit.tandaTanganController.clear(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0XFFDCF4ED),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Text(
                  'Clear',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: kSemiBold.copyWith(
                    fontSize: 14,
                    color: tertiaryColor,
                  ),
                ),
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
          'Daftar Hadir',
          style: kSemiBold.copyWith(color: tertiaryColor),
        ),
        content: Text(
          'Berhasil Menambah Data Daftar Hadir',
          style: kRegular.copyWith(color: tertiaryColor),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/daftar-hadir', ModalRoute.withName('/dashboard'));
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

class ButtonAdd extends StatelessWidget {
  const ButtonAdd({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TambahDaftarHadirCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final minggu = cubit.mingguController.text;
            final hariTanggal = cubit.hariTanggalController.text;
            final signatureBytes =
                await cubit.tandaTanganController.toPngBytes();
            final decodedImage = img.decodeImage(signatureBytes!);

            final tempDir = await getTemporaryDirectory();
            final tempPath = tempDir.path;
            final tandaTangan = File('$tempPath/signature.png')
              ..writeAsBytesSync(img.encodePng(decodedImage!));

            cubit.addDaftarHadir(hariTanggal, minggu, tandaTangan);
            cubit.resetForm();
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
            'Simpan',
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
