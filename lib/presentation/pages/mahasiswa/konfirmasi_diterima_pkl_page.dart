import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/presentation/cubit/pengajuan/data_pembimbing_pkl_cubit.dart';
import 'package:magang_app/presentation/cubit/pengajuan/konfirmasi_diterima_pkl_cubit.dart';
import 'package:magang_app/presentation/cubit/pengajuan/status_pengajuan_cubit.dart';
import 'package:magang_app/presentation/widgets/loading_button.dart';

class KonfirmasiDiterimaPklPage extends StatefulWidget {
  const KonfirmasiDiterimaPklPage({Key? key}) : super(key: key);

  @override
  State<KonfirmasiDiterimaPklPage> createState() =>
      _KonfirmasiDiterimaPklPageState();
}

class _KonfirmasiDiterimaPklPageState extends State<KonfirmasiDiterimaPklPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<StatusPengajuanCubit>().getStatusPengajuan();
    context.read<DataPembimbingPklCubit>().getDataPembimbingPkl();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<KonfirmasiDiterimaPklCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Konfirmasi Diterima PKL',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<KonfirmasiDiterimaPklCubit, KonfirmasiDiterimaPklState>(
        builder: (context, state) {
          if (state is KonfirmasiDiterimaPklSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<KonfirmasiDiterimaPklCubit>().resetState();
              showSuccessDialog(context);
            });
          } else {
            return ListView(
              children: [
                FormConfirm(
                  formKey: _formKey,
                  cubit: cubit,
                  statusPengajuanCubit: StatusPengajuanCubit(
                    apiService: ApiService(),
                  ),
                  dataPembimbingPklCubit: DataPembimbingPklCubit(
                    apiService: ApiService(),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar:
          BlocBuilder<KonfirmasiDiterimaPklCubit, KonfirmasiDiterimaPklState>(
        builder: (context, state) {
          if (state is KonfirmasiDiterimaPklLoading) {
            return const LoadingButton();
          } else if (state is KonfirmasiDiterimaPklError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<KonfirmasiDiterimaPklCubit>().resetState();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Terjadi kesalahan: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            });
            return Container();
          } else {
            return ConfirmButton(formKey: _formKey, cubit: cubit);
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
          'Konfirmasi PKL',
          style: kSemiBold.copyWith(color: tertiaryColor),
        ),
        content: Text(
          'Pengiriman Data Konfirmasi diterima PKL berhasil terkirim, sekarang kamu terdata sedang melaksanakan PKL di Perusahaan yang di input',
          style: kRegular.copyWith(color: tertiaryColor),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: primaryColor,
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

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final KonfirmasiDiterimaPklCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton.icon(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final idPengajuan = cubit.pengajuanController.text;
            final idPembimbing = cubit.pembimbingController.text;

            cubit.konfirmasiDiterimaPkl(idPengajuan, idPembimbing);
            cubit.resetForm();
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: tertiaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(15)),
        icon: const Icon(
          IconlyBold.tick_square,
          color: backgroundColor,
        ),
        label: FittedBox(
          child: Text(
            'Konfirmasi',
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

class FormConfirm extends StatelessWidget {
  const FormConfirm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
    required this.statusPengajuanCubit,
    required this.dataPembimbingPklCubit,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final KonfirmasiDiterimaPklCubit cubit;
  final StatusPengajuanCubit statusPengajuanCubit;
  final DataPembimbingPklCubit dataPembimbingPklCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            StreamBuilder<StatusPengajuanState>(
              stream: statusPengajuanCubit.stream,
              initialData: StatusPengajuanInitial(),
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state is StatusPengajuanLoaded) {
                  final pengajuan = state.statusPengajuanPkl;
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: accentColor,
                      labelText: 'Pilih Pengajuan',
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
                      suffixIcon: Transform.rotate(
                        angle: 90 * 3.14 / 180,
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    iconSize: 0.0,
                    value: cubit.pengajuanController.text.isNotEmpty
                        ? cubit.pengajuanController.text
                        : null,
                    onChanged: (newValue) {
                      cubit.pengajuanController.text = newValue!;
                    },
                    items: pengajuan.data
                        .where((item) => item.status == "disetujui")
                        .map((item) {
                      return DropdownMenuItem<String>(
                        key: Key(item.idPengajuan.toString()),
                        value: item.idPengajuan.toString(),
                        child: Text(
                          item.namaPerusahaan,
                          style: kMedium.copyWith(color: tertiaryColor),
                        ),
                      );
                    }).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'No Data',
                    style: kMedium.copyWith(color: tertiaryColor),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            StreamBuilder<DataPembimbingPklState>(
              stream: dataPembimbingPklCubit.stream,
              initialData: DataPembimbingPklInitial(),
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state is DataPembimbingPklLoaded) {
                  final pembimbing = state.dataPembimbingPkl;
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: accentColor,
                      labelText: 'Pilih Pembimbing Sesuai Tempat PKL',
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
                      suffixIcon: Transform.rotate(
                        angle: 90 * 3.14 / 180,
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    iconSize: 0.0,
                    value: cubit.pembimbingController.text.isNotEmpty
                        ? cubit.pembimbingController.text
                        : null,
                    onChanged: (newValue) {
                      cubit.pembimbingController.text = newValue!;
                    },
                    items: pembimbing.data.map((item) {
                      return DropdownMenuItem<String>(
                        key: Key(item.idPembimbing.toString()),
                        value: item.idPembimbing.toString(),
                        child: Text(
                          item.nama,
                          semanticsLabel: item.nik,
                          style: kMedium.copyWith(color: tertiaryColor),
                        ),
                      );
                    }).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'No Data',
                    style: kMedium.copyWith(color: tertiaryColor),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Jika Pembimbing kamu belum memiliki akun, beritahukan kepada pembimbing PKL kamu untuk membuat akun di aplikasi PKL TEDC.',
                style: kRegular.copyWith(
                  fontSize: 11,
                  color: blackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
