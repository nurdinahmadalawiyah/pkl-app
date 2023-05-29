import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/jurnal_kegiatan_model.dart';
import 'package:magang_app/presentation/cubit/jurnal_kegiatan/edit_jurnal_kegiatan_cubit.dart';
import 'package:magang_app/presentation/cubit/jurnal_kegiatan/jurnal_kegiatan_cubit.dart';
import 'package:magang_app/presentation/widgets/date_picker_form_field.dart';
import 'package:magang_app/presentation/widgets/loading_button.dart';

class EditJurnalKegiatanPage extends StatefulWidget {
  const EditJurnalKegiatanPage({super.key});

  @override
  State<EditJurnalKegiatanPage> createState() => _EditJurnalKegiatanPageState();
}

class _EditJurnalKegiatanPageState extends State<EditJurnalKegiatanPage> {
  final _formKey = GlobalKey<FormState>();
  late final JurnalKegiatanCubit jurnalKegiatanCubit;

  @override
  void initState() {
    super.initState();
    jurnalKegiatanCubit = JurnalKegiatanCubit(apiService: ApiService());
  }

  @override
  void dispose() {
    jurnalKegiatanCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditJurnalKegiatanCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Edit Jurnal Kegiatan',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<EditJurnalKegiatanCubit, EditJurnalKegiatanState>(
        builder: (context, state) {
          if (state is EditJurnalKegiatanSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<EditJurnalKegiatanCubit>().resetState();
              showSuccessDialog(context);
            });
          } else {
            return ListView(
              children: [
                FormUpdateJurnalKegiatan(
                  cubit: cubit,
                  formKey: _formKey,
                ),
              ],
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar:
          BlocBuilder<EditJurnalKegiatanCubit, EditJurnalKegiatanState>(
        builder: (context, state) {
          if (state is EditJurnalKegiatanLoading) {
            return const LoadingButton();
          } else if (state is EditJurnalKegiatanError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 3),
                  content: Text(
                    'Gagal Menghapus Daftar Hadir',
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

class FormUpdateJurnalKegiatan extends StatefulWidget {
  const FormUpdateJurnalKegiatan({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final EditJurnalKegiatanCubit cubit;

  @override
  State<FormUpdateJurnalKegiatan> createState() =>
      _FormUpdateJurnalKegiatanState();
}

class _FormUpdateJurnalKegiatanState extends State<FormUpdateJurnalKegiatan> {
  @override
  Widget build(BuildContext context) {
    final jurnal = ModalRoute.of(context)?.settings.arguments as DataKegiatan;

    widget.cubit.mingguController.text = jurnal.minggu.toString();
    widget.cubit.bidangPekerjaanController.text = jurnal.bidangPekerjaan;
    widget.cubit.keteranganController.text = jurnal.keterangan;

    DateTime dateValue = jurnal.tanggal;
    widget.cubit.hariTanggalController.text =
        DateFormat('yyyy-MM-dd').format(dateValue);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: widget._formKey,
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
              height: 10,
            ),
            DatePickerFormField(
              controller: widget.cubit.hariTanggalController,
              labelText: "Hari/Tanggal",
              initialDate: dateValue,
              onDateSelected: (DateTime date) {
                // setState(() {});
                jurnal.tanggal = date;
                widget.cubit.hariTanggalController.text =
                    DateFormat('yyyy-MM-dd').format(date);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: widget.cubit.bidangPekerjaanController,
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
              controller: widget.cubit.keteranganController,
              maxLines: 6,
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

class ButtonUpdate extends StatelessWidget {
  const ButtonUpdate({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final EditJurnalKegiatanCubit cubit;

  @override
  Widget build(BuildContext context) {
    final jurnal = ModalRoute.of(context)?.settings.arguments as DataKegiatan;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final minggu = cubit.mingguController.text;
            final tanggal = cubit.hariTanggalController.text;
            final bidangPekerjaan = cubit.bidangPekerjaanController.text;
            final keterangan = cubit.keteranganController.text;
            final idJurnalKegiatan = jurnal.idJurnalKegiatan.toString();

            cubit.updateJurnalKegiatan(
                idJurnalKegiatan, tanggal, minggu, bidangPekerjaan, keterangan);
            cubit.resetForm();
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
          'Berhasil Mengubah Data Jurnal Kegiatan',
          style: kRegular.copyWith(color: tertiaryColor),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: primaryColor,
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
