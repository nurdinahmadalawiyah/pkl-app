import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/nilai_pkl_model.dart';
import 'package:magang_app/presentation/cubit/nilai_pkl_cubit.dart';
import 'package:magang_app/presentation/widgets/error_animation.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_connection_animation.dart';
import 'package:magang_app/presentation/widgets/no_data_animation.dart';

class NilaiPklPage extends StatefulWidget {
  const NilaiPklPage({super.key});

  @override
  State<NilaiPklPage> createState() => _NilaiPklPageState();
}

class _NilaiPklPageState extends State<NilaiPklPage> {
  @override
  void initState() {
    super.initState();
    context.read<NilaiPklCubit>().getNilaiPkl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Nilai PKL',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<NilaiPklCubit, NilaiPklState>(
        builder: (context, state) {
          if (state is NilaiPklLoading) {
            return const Center(child: LoadingAnimation());
          } else if (state is NilaiPklLoaded) {
            final nilaiPkl = state.nilaiPKL;
            return ListView(
              children: [
                NilaiPembimbing(nilaiPkl: nilaiPkl),
                const SizedBox(height: 20),
                NilaiProdi(nilaiPkl: nilaiPkl),
                const SizedBox(height: 20),
                NilaiAkhirPKL(nilaiPkl: nilaiPkl),
              ],
            );
          } else if (state is NilaiPklNoData) {
            final message = state.message;
            return Center(
              child: NoDataAnimation(message: message),
            );
          } else if (state is NilaiPklNoConnection) {
            final message = state.message;
            return Center(
              child: NoConnectionAnimation(message: message),
            );
          } else if (state is NilaiPklError) {
            final message = state.message;
            return Center(
              child: NoDataAnimation(message: message),
            );
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<NilaiPklCubit, NilaiPklState>(
        builder: (context, state) {
          if (state is NilaiPklLoaded) {
            return const ButtonPrint();
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
    );
  }
}

class ButtonPrint extends StatelessWidget {
  const ButtonPrint({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(15),
        ),
        icon: const Icon(
          Icons.picture_as_pdf_rounded,
          color: backgroundColor,
        ),
        label: FittedBox(
          child: Text(
            'Cetak PDF',
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

class NilaiAkhirPKL extends StatelessWidget {
  const NilaiAkhirPKL({
    Key? key,
    required this.nilaiPkl,
  }) : super(key: key);

  final NilaiPkl nilaiPkl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nilai PKL',
            style: kRegular.copyWith(
              fontSize: 12,
              color: tertiaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      'NILAI AKHIR',
                      textAlign: TextAlign.center,
                      style:
                          kMedium.copyWith(color: tertiaryColor, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      nilaiPkl.data.nilaiAkhir.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: kBold.copyWith(color: tertiaryColor, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      'NILAI HURUF',
                      textAlign: TextAlign.center,
                      style:
                          kMedium.copyWith(color: tertiaryColor, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      nilaiPkl.data.nilaiHuruf,
                      textAlign: TextAlign.center,
                      style: kBold.copyWith(color: tertiaryColor, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NilaiProdi extends StatelessWidget {
  const NilaiProdi({
    Key? key,
    required this.nilaiPkl,
  }) : super(key: key);

  final NilaiPkl nilaiPkl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nilai dari Prodi',
            style: kRegular.copyWith(
              fontSize: 12,
              color: tertiaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      'Presentasi',
                      style:
                          kMedium.copyWith(color: tertiaryColor, fontSize: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      nilaiPkl.data.presentasi.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: kBold.copyWith(color: tertiaryColor, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      'Dokumen',
                      style:
                          kMedium.copyWith(color: tertiaryColor, fontSize: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      nilaiPkl.data.dokumen.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: kBold.copyWith(color: tertiaryColor, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NilaiPembimbing extends StatelessWidget {
  const NilaiPembimbing({
    Key? key,
    required this.nilaiPkl,
  }) : super(key: key);

  final NilaiPkl nilaiPkl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nilai dari Pembimbing',
            style: kRegular.copyWith(
              fontSize: 12,
              color: tertiaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      'Memiliki integritas yang baik di lingkungan kerja',
                      style:
                          kMedium.copyWith(color: tertiaryColor, fontSize: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      nilaiPkl.data.integritas.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: kBold.copyWith(color: tertiaryColor, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      'Mampu bekerja secara profesional sesuai bidangnya',
                      style:
                          kMedium.copyWith(color: tertiaryColor, fontSize: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      nilaiPkl.data.kerjaSama.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: kBold.copyWith(color: tertiaryColor, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      'Cakap dalam berkomunikasi bahasa inggris',
                      style:
                          kMedium.copyWith(color: tertiaryColor, fontSize: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      nilaiPkl.data.bahasaInggris.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: kBold.copyWith(color: tertiaryColor, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      'Mampu mengaplikasikan teknologi informasi',
                      style:
                          kMedium.copyWith(color: tertiaryColor, fontSize: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      nilaiPkl.data.teknologiInformasi.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: kBold.copyWith(color: tertiaryColor, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      'Mampu berkomunikasi dengan teman sejawat atau atasan',
                      style:
                          kMedium.copyWith(color: tertiaryColor, fontSize: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      nilaiPkl.data.komunikasi.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: kBold.copyWith(color: tertiaryColor, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      'Mampu bekerjasama dengan teman sejawat/tim',
                      style:
                          kMedium.copyWith(color: tertiaryColor, fontSize: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      nilaiPkl.data.kerjaSama.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: kBold.copyWith(color: tertiaryColor, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    title: Text(
                      'Mampu mengorganisasikan pekerjaan berdasarkan visi ke depan ',
                      style:
                          kMedium.copyWith(color: tertiaryColor, fontSize: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Card(
                  color: accentColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: ListTile(
                    title: Text(
                      nilaiPkl.data.organisasi.toStringAsFixed(2),
                      textAlign: TextAlign.center,
                      style: kBold.copyWith(color: tertiaryColor, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
