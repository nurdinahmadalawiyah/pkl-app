import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/daftar_hadir_model.dart';
import 'package:magang_app/presentation/cubit/daftar_hadir/daftar_hadir_cubit.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as img;
import 'package:magang_app/presentation/cubit/daftar_hadir/edit_daftar_hadir_cubit.dart';
import 'package:magang_app/presentation/widgets/loading_button.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:magang_app/presentation/widgets/date_picker_form_field.dart';
import 'package:signature/signature.dart';

class EditDaftarHadirPage extends StatefulWidget {
  const EditDaftarHadirPage({super.key});

  @override
  State<EditDaftarHadirPage> createState() => _EditDaftarHadirPageState();
}

class _EditDaftarHadirPageState extends State<EditDaftarHadirPage> {
  final _formKey = GlobalKey<FormState>();
  late final DaftarHadirCubit daftarHadirCubit;

  @override
  void initState() {
    daftarHadirCubit = DaftarHadirCubit(apiService: ApiService());
    super.initState();
  }

  @override
  void dispose() {
    daftarHadirCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditDaftarHadirCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Edit Daftar Hadir',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<EditDaftarHadirCubit, EditDaftarHadirState>(
        builder: (context, state) {
          if (state is EditDaftarHadirSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<EditDaftarHadirCubit>().resetState();
              showSuccessDialog(context);
            });
          }
          return ListView(
            children: [FormUpdateDaftarHadir(formKey: _formKey, cubit: cubit)],
          );
        },
      ),
      bottomNavigationBar:
          BlocBuilder<EditDaftarHadirCubit, EditDaftarHadirState>(
        builder: (context, state) {
          if (state is EditDaftarHadirLoading) {
            return const LoadingButton();
          } else if (state is EditDaftarHadirError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 3),
                  content: Text(
                    'Gagal Memperbarui Daftar Hadir',
                    textAlign: TextAlign.center,
                    style: kMedium.copyWith(color: backgroundColor),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
              cubit.resetState();
            });
            return Container();
          }
          return ButtonUpdate(
            cubit: cubit,
            formKey: _formKey,
          );
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
          'Daftar Hadir',
          style: kSemiBold.copyWith(color: tertiaryColor),
        ),
        content: Text(
          'Berhasil Mengubah Data Daftar Hadir',
          style: kRegular.copyWith(color: tertiaryColor),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: primaryColor,
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

class FormUpdateDaftarHadir extends StatefulWidget {
  const FormUpdateDaftarHadir({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final EditDaftarHadirCubit cubit;

  @override
  State<FormUpdateDaftarHadir> createState() => _FormUpdateDaftarHadirState();
}

class _FormUpdateDaftarHadirState extends State<FormUpdateDaftarHadir> {
  @override
  Widget build(BuildContext context) {
    final kehadiran =
        ModalRoute.of(context)?.settings.arguments as DataKehadiran;

    DateTime dateValue = kehadiran.hariTanggal;
    widget.cubit.hariTanggalController.text =
        DateFormat('yyyy-MM-dd').format(dateValue);
    widget.cubit.mingguController.text = kehadiran.minggu.toString();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: widget._formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DatePickerFormField(
              controller: widget.cubit.hariTanggalController,
              labelText: "Hari/Tanggal",
              onDateSelected: (DateTime date) {
                //setState(() {});
                kehadiran.hariTanggal = date;
                widget.cubit.hariTanggalController.text =
                    DateFormat('yyyy-MM-dd').format(date);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: widget.cubit.mingguController,
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
              'Silahkan Tanda Tangan Ulang',
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
                controller: widget.cubit.tandaTanganController,
                backgroundColor: accentColor,
                height: 250,
                width: double.infinity,
                dynamicPressureSupported: true,
              ),
            ),
            GestureDetector(
              onTap: () => widget.cubit.tandaTanganController.clear(),
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

class ButtonUpdate extends StatelessWidget {
  const ButtonUpdate({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final EditDaftarHadirCubit cubit;

  @override
  Widget build(BuildContext context) {
    final kehadiran =
        ModalRoute.of(context)?.settings.arguments as DataKehadiran;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final idDaftarHadir = kehadiran.idDaftarHadir.toString();
            final hariTanggal = cubit.hariTanggalController.text;
            final minggu = cubit.mingguController.text;
            final signatureBytes =
                await cubit.tandaTanganController.toPngBytes();
            if (signatureBytes == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<EditDaftarHadirCubit>().resetState();
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

              cubit.updateDaftarHadir(
                  idDaftarHadir, hariTanggal, minggu, tandaTangan);
              cubit.resetForm();
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
            'Perbarui',
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
