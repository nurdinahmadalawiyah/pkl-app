import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/presentation/cubit/pengajuan_pkl_cubit.dart';
import 'package:magang_app/presentation/widgets/date_picker_form_field.dart';
import 'package:magang_app/presentation/widgets/loading_button.dart';

class AjukanTempatPklPage extends StatefulWidget {
  const AjukanTempatPklPage({Key? key}) : super(key: key);

  @override
  State<AjukanTempatPklPage> createState() => _AjukanTempatPklPageState();
}

class _AjukanTempatPklPageState extends State<AjukanTempatPklPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PengajuanPklCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Ajukan Tempat PKL',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<PengajuanPklCubit, PengajuanPklState>(
        builder: (context, state) {
          if (state is PengajuanPklSuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<PengajuanPklCubit>().resetState();
              showSuccessDialog(context);
            });
          } else {
            return ListView(
              children: [
                formPengajuan(cubit), 
              ],
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<PengajuanPklCubit, PengajuanPklState>(
        builder: (context, state) {
          if (state is PengajuanPklLoadingState) {
            return const LoadingButton();
          } else if (state is PengajuanPklErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<PengajuanPklCubit>().resetState();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Terjadi kesalahan: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            });
            return Container();
          } else {
            return ButtonAjukan(formKey: _formKey, cubit: cubit);
          }
        },
      ),
    );
  }

  Container formPengajuan(PengajuanPklCubit cubit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: cubit.namaPerusahaanController,
              cursorColor: primaryColor,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: accentColor,
                labelText: 'Nama Perusahaan',
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
                  Icons.business_rounded,
                  color: primaryColor,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Nama perusahaan tidak boleh kosong';
                }
                return null;
              },
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: cubit.alamatPerusahaanController,
              cursorColor: primaryColor,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: accentColor,
                labelText: 'Alamat Perusahaan',
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
                  IconlyBold.location,
                  color: primaryColor,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Alamat perusahaan tidak boleh kosong';
                }
                return null;
              },
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            DatePickerFormField(
              controller: cubit.tanggalMulaiController,
              labelText: "Tanggal Mulai",
              onDateSelected: (DateTime date) {
                setState(() {
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            DatePickerFormField(
              controller: cubit.tanggalSelesaiController,
              labelText: "Tanggal Selesai",
              onDateSelected: (DateTime date) {
                setState(() {
                });
              },
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
          'Pengajuan PKL',
          style: kSemiBold.copyWith(color: tertiaryColor),
        ),
        content: Text(
          'Pengajuan PKL Berhasil Dikirim',
          style: kRegular.copyWith(color: tertiaryColor),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

class ButtonAjukan extends StatelessWidget {
  const ButtonAjukan({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final PengajuanPklCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final namaPerusahaan = cubit.namaPerusahaanController.text;
            final alamatPerusahaan = cubit.alamatPerusahaanController.text;
            final tanggalMulai = cubit.tanggalMulaiController.text;
            final tanggalSelesai = cubit.tanggalSelesaiController.text;

            cubit.ajukanTempatPKL(
              namaPerusahaan,
              alamatPerusahaan,
              tanggalMulai,
              tanggalSelesai,
            );

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
            'Ajukan',
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
