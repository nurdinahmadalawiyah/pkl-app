// ignore_for_file: depend_on_referenced_packages, prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/presentation/cubit/daftar_hadir/tambah_daftar_hadir_cubit.dart';
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
  final hariTanggalController = TextEditingController();
  final mingguController = TextEditingController();
  final tandaTanganController =
      SignatureController(penStrokeWidth: 5, penColor: blackColor);

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
        if (state is TambahDaftarHadirLoading) {
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
        }
        return ButtonAdd(
          formKey: _formKey,
          cubit: cubit,
          hariTanggalController: hariTanggalController,
          mingguController: mingguController,
          tandaTanganController: tandaTanganController,
        );
      }),
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
              controller: hariTanggalController,
              labelText: "Hari/Tanggal",
              onDateSelected: (DateTime date) {
                setState(() {});
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: mingguController,
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
                controller: tandaTanganController,
                backgroundColor: accentColor,
                height: 250,
                width: double.infinity,
                dynamicPressureSupported: true,
              ),
            ),
            GestureDetector(
              onTap: () => tandaTanganController.clear(),
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
    required this.hariTanggalController,
    required this.mingguController,
    required this.tandaTanganController,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TambahDaftarHadirCubit cubit;
  final hariTanggalController;
  final mingguController;
  final tandaTanganController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final minggu = mingguController.text;
            final hariTanggal = hariTanggalController.text;
            final signatureBytes = await tandaTanganController.toPngBytes();
            if (signatureBytes == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<TambahDaftarHadirCubit>().resetState();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tanda tangan tidak boleh kosong'),
                    backgroundColor: Colors.red,
                  ),
                );
              });
            } else {
              final decodedImage = img.decodeImage(signatureBytes);
              final tempDir = await getTemporaryDirectory();
              final tempPath = tempDir.path;
              final tandaTangan = File('$tempPath/signature.png')
                ..writeAsBytesSync(img.encodePng(decodedImage!));

              cubit.addDaftarHadir(hariTanggal, minggu, tandaTangan);
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
