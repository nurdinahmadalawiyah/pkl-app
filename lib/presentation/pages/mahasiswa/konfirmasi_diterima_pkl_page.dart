import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/presentation/cubit/konfirmasi_diterima_pkl_cubit.dart';
import 'package:magang_app/presentation/cubit/status_pengajuan_cubit.dart';
import 'package:magang_app/presentation/widgets/loading_button.dart';

class KonfirmasiDiterimaPklPage extends StatefulWidget {
  const KonfirmasiDiterimaPklPage({Key? key}) : super(key: key);

  @override
  State<KonfirmasiDiterimaPklPage> createState() =>
      _KonfirmasiDiterimaPklPageState();
}

class _KonfirmasiDiterimaPklPageState extends State<KonfirmasiDiterimaPklPage> {
  final _formKey = GlobalKey<FormState>();
  late final StatusPengajuanCubit statusPengajuanCubit;

  @override
  void initState() {
    super.initState();
    statusPengajuanCubit = StatusPengajuanCubit(apiService: ApiService());
  }

  @override
  void dispose() {
    statusPengajuanCubit.close();
    super.dispose();
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
                  statusPengajuanCubit: statusPengajuanCubit,
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
          'Pengiriman Data Konfirmasi diterima PKL berhasil terkirim, sekarang anda terdata sedang melaksanakan PKL di Perusahaan yang anda input',
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
            final konfirmasiNamaPembimbing =
                cubit.namaPembimbingController.text;
            final konfirmasiNikPembimbing = cubit.nikPembimbingController.text;

            cubit.konfirmasiDiterimaPkl(
                idPengajuan, konfirmasiNamaPembimbing, konfirmasiNikPembimbing);
            cubit.resetForm();
          }
        },
        style: ElevatedButton.styleFrom(
            primary: tertiaryColor,
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
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final KonfirmasiDiterimaPklCubit cubit;
  final StatusPengajuanCubit statusPengajuanCubit;

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
                    value: pengajuan.data.isNotEmpty
                        ? pengajuan.data[0].idPengajuan.toString()
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
            Text(
              'Isi data pembimbing untuk dibuatkan akun pembimbing oleh prodi',
              style: kRegular.copyWith(color: tertiaryColor, fontSize: 11),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: cubit.namaPembimbingController,
              cursorColor: primaryColor,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: accentColor,
                labelText: 'Nama Pembimbing',
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
                  IconlyBold.profile,
                  color: primaryColor,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: cubit.nikPembimbingController,
              cursorColor: primaryColor,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: accentColor,
                labelText: 'NIK Pembimbing',
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
                  IconlyBold.more_square,
                  color: primaryColor,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
