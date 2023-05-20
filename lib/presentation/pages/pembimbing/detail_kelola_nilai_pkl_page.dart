import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/detail_nilai_model.dart';
import 'package:magang_app/data/models/list_mahasiswa_model.dart';
import 'package:magang_app/presentation/cubit/penilaian/detail_nilai_cubit.dart';
import 'package:magang_app/presentation/widgets/error_animation.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_data_animation.dart';

class DetailKelolaNilaiPklPage extends StatefulWidget {
  const DetailKelolaNilaiPklPage({super.key});

  @override
  State<DetailKelolaNilaiPklPage> createState() =>
      _DetailKelolaNilaiPklPageState();
}

class _DetailKelolaNilaiPklPageState extends State<DetailKelolaNilaiPklPage> {
  late Datum list;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    list = ModalRoute.of(context)?.settings.arguments as Datum;
    context
        .read<DetailNilaiCubit>()
        .getDetailNilaiPkl(list.idMahasiswa.toString());
  }

  @override
  Widget build(BuildContext context) {
    final list = ModalRoute.of(context)?.settings.arguments as Datum;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          list.namaMahasiswa,
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<DetailNilaiCubit, DetailNilaiState>(
        builder: (context, state) {
          if (state is DetailNilaiLoading) {
            return const Center(child: LoadingAnimation());
          } else if (state is DetailNilaiLoaded) {
            final detailNilai = state.detailNilai;
            return NilaiDariPembimbing(detailNilai: detailNilai);
          } else if (state is DetailNilaiNoData) {
            final message = state.message;
            return Center(
              child: NoDataAnimation(message: message),
            );
          } else if (state is DetailNilaiError) {
            final message = state.message;
            return Center(
              child: ErrorAnimation(message: message),
            );
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
      bottomNavigationBar: ButtonEdit(list: list),
    );
  }
}

class ButtonEdit extends StatelessWidget {
  const ButtonEdit({
    Key? key,
    required this.list,
  }) : super(key: key);

  final Datum list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton.icon(
        onPressed: () =>
            Navigator.pushNamed(context, '/edit-nilai', arguments: list),
        style: ElevatedButton.styleFrom(
            backgroundColor: tertiaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(15)),
        icon: const Icon(
          IconlyBold.plus,
          color: backgroundColor,
        ),
        label: FittedBox(
          child: Text(
            'Edit Nilai',
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

class NilaiDariPembimbing extends StatelessWidget {
  const NilaiDariPembimbing({
    Key? key,
    required this.detailNilai,
  }) : super(key: key);

  final DetailNilai detailNilai;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
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
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        title: Text(
                          'Memiliki integritas yang baik di lingkungan kerja',
                          style: kMedium.copyWith(
                              color: tertiaryColor, fontSize: 12),
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
                          double.parse(detailNilai.data.integritas).toStringAsFixed(
                            double.parse(detailNilai.data.integritas) % 1 == 0 ? 0 : 2,
                          ),
                          textAlign: TextAlign.center,
                          style: kBold.copyWith(
                              color: tertiaryColor, fontSize: 30),
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
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        title: Text(
                          'Mampu bekerja secara profesional sesuai bidangnya',
                          style: kMedium.copyWith(
                              color: tertiaryColor, fontSize: 12),
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
                          double.parse(detailNilai.data.profesionalitas).toStringAsFixed(
                            double.parse(detailNilai.data.profesionalitas) % 1 == 0 ? 0 : 2,
                          ),
                          textAlign: TextAlign.center,
                          style: kBold.copyWith(
                              color: tertiaryColor, fontSize: 30),
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
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        title: Text(
                          'Cakap dalam berkomunikasi bahasa inggris',
                          style: kMedium.copyWith(
                              color: tertiaryColor, fontSize: 12),
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
                          double.parse(detailNilai.data.bahasaInggris).toStringAsFixed(
                            double.parse(detailNilai.data.bahasaInggris) % 1 == 0 ? 0 : 2,
                          ),
                          textAlign: TextAlign.center,
                          style: kBold.copyWith(
                              color: tertiaryColor, fontSize: 30),
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
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        title: Text(
                          'Mampu mengaplikasikan teknologi informasi',
                          style: kMedium.copyWith(
                              color: tertiaryColor, fontSize: 12),
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
                          double.parse(detailNilai.data.teknologiInformasi).toStringAsFixed(
                            double.parse(detailNilai.data.teknologiInformasi) % 1 == 0 ? 0 : 2,
                          ),
                          textAlign: TextAlign.center,
                          style: kBold.copyWith(
                              color: tertiaryColor, fontSize: 30),
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
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        title: Text(
                          'Mampu berkomunikasi dengan teman sejawat atau atasan',
                          style: kMedium.copyWith(
                              color: tertiaryColor, fontSize: 12),
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
                          double.parse(detailNilai.data.komunikasi).toStringAsFixed(
                            double.parse(detailNilai.data.komunikasi) % 1 == 0 ? 0 : 2,
                          ),
                          textAlign: TextAlign.center,
                          style: kBold.copyWith(
                              color: tertiaryColor, fontSize: 30),
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
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        title: Text(
                          'Mampu bekerjasama dengan teman sejawat/tim',
                          style: kMedium.copyWith(
                              color: tertiaryColor, fontSize: 12),
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
                          double.parse(detailNilai.data.kerjaSama).toStringAsFixed(
                            double.parse(detailNilai.data.kerjaSama) % 1 == 0 ? 0 : 2,
                          ),
                          textAlign: TextAlign.center,
                          style: kBold.copyWith(
                              color: tertiaryColor, fontSize: 30),
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
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        title: Text(
                          'Mampu mengorganisasikan pekerjaan berdasarkan visi ke depan ',
                          style: kMedium.copyWith(
                              color: tertiaryColor, fontSize: 12),
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
                          double.parse(detailNilai.data.organisasi).toStringAsFixed(
                            double.parse(detailNilai.data.organisasi) % 1 == 0 ? 0 : 2,
                          ),
                          textAlign: TextAlign.center,
                          style: kBold.copyWith(
                              color: tertiaryColor, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
