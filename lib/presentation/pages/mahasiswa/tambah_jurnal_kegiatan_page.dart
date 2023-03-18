import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/presentation/cubit/jurnal_kegiatan/tambah_jurnal_kegiatan_cubit.dart';
import 'package:magang_app/presentation/widgets/date_picker_form_field.dart';
import 'package:magang_app/presentation/widgets/loading_button.dart';

class TambahJurnalKegiatanPage extends StatefulWidget {
  const TambahJurnalKegiatanPage({super.key});

  @override
  State<TambahJurnalKegiatanPage> createState() =>
      _TambahJurnalKegiatanPageState();
}

class _TambahJurnalKegiatanPageState extends State<TambahJurnalKegiatanPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TambahJurnalKegiatanCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Tambah Jurnal Kegiatan',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<TambahJurnalKegiatanCubit, TambahJurnalKegiatanState>(
        builder: (context, state) {
          if (state is TambahJurnalKegiatanSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<TambahJurnalKegiatanCubit>().resetState();
              showSuccessDialog(context);
            });
          } else {
            return ListView(
              children: [
                formAddJurnalKegiatan(cubit),
              ],
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar:
          BlocBuilder<TambahJurnalKegiatanCubit, TambahJurnalKegiatanState>(
        builder: (context, state) {
          if (state is TambahJurnalKegiatanLoading) {
            return const LoadingButton();
          } else if (state is TambahJurnalKegiatanError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<TambahJurnalKegiatanCubit>().resetState();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Terjadi kesalahan: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            });
            return Container();
          } else {
            return ButtonAdd(cubit: cubit, formKey: _formKey);
          }
        },
      ),
    );
  }

  Container formAddJurnalKegiatan(TambahJurnalKegiatanCubit cubit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Jurnal Kegiatan",
              style: kRegular.copyWith(
                color: blackColor,
                fontSize: 12,
              ),
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
              height: 10,
            ),
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
              controller: cubit.bidangPekerjaanController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: accentColor,
                labelText: 'Bidang Pekerjaan',
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
                  IconlyBold.work,
                  color: primaryColor,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Bidang Pekerjaan tidak boleh kosong';
                }
                return null;
              },
              style: const TextStyle(color: tertiaryColor),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: cubit.keteranganController,
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                filled: true,
                fillColor: accentColor,
                labelText: 'Keterangan',
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
                  IconlyBold.document,
                  color: primaryColor,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Keterangan tidak boleh kosong';
                }
                return null;
              },
              style: const TextStyle(color: tertiaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonAdd extends StatelessWidget {
  const ButtonAdd({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TambahJurnalKegiatanCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final minggu = cubit.mingguController.text;
            final tanggal = cubit.hariTanggalController.text;
            final bidangPekerjaan = cubit.bidangPekerjaanController.text;
            final keterangan = cubit.keteranganController.text;

            cubit.addJurnalKegiatan(
                tanggal, minggu, bidangPekerjaan, keterangan);
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

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: accentColor,
        title: Text(
          'Jurnal Kegiatan',
          style: kSemiBold.copyWith(color: tertiaryColor),
        ),
        content: Text(
          'Berhasil Menambah Data Jurnal Kegiatan',
          style: kRegular.copyWith(color: tertiaryColor),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(context, '/jurnal-kegiatan',
                  ModalRoute.withName('/dashboard'));
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
