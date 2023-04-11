import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/daftar_hadir_model.dart';
import 'package:magang_app/data/models/list_mahasiswa_model.dart';
import 'package:magang_app/presentation/cubit/daftar_hadir/detail_daftar_hadir_cubit.dart';
import 'package:magang_app/presentation/widgets/error_animation.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_connection_animation.dart';
import 'package:magang_app/presentation/widgets/no_data_animation.dart';

class DetailDaftarHadirPage extends StatefulWidget {
  const DetailDaftarHadirPage({super.key});

  @override
  State<DetailDaftarHadirPage> createState() => _DetailDaftarHadirPageState();
}

class _DetailDaftarHadirPageState extends State<DetailDaftarHadirPage> {
  late Datum list;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    list = ModalRoute.of(context)?.settings.arguments as Datum;
    context
        .read<DetailDaftarHadirCubit>()
        .getDetailDaftarHadir(list.idMahasiswa.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Detail Daftar Hadir",
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<DetailDaftarHadirCubit, DetailDaftarHadirState>(
        builder: (context, state) {
          if (state is DetailDaftarHadirLoading) {
            return const Center(
              child: LoadingAnimation(),
            );
          } else if (state is DetailDaftarHadirLoaded) {
            final daftarHadir = state.daftarHadir;
            return CardDaftarHadir(daftarHadir: daftarHadir);
          } else if (state is DetailDaftarHadirNoData) {
            return Center(child: NoDataAnimation(message: state.message));
          } else if (state is DetailDaftarHadirNoConnection) {
            return Center(child: NoConnectionAnimation(message: state.message));
          } else if (state is DetailDaftarHadirError) {
            return Center(child: ErrorAnimation(message: state.message));
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
    );
  }
}

class CardDaftarHadir extends StatelessWidget {
  const CardDaftarHadir({
    Key? key,
    required this.daftarHadir,
  }) : super(key: key);

  final DaftarHadir daftarHadir;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: daftarHadir.data.length,
      itemBuilder: (context, index) {
        var kehadiran = daftarHadir.data[index];
        var subindex = 0;

        if (kehadiran.dataKehadiran.isNotEmpty) {
          subindex = kehadiran.dataKehadiran.length - 1;
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {},
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: accentColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daftar Hadir",
                      style: kBold.copyWith(color: blackColor, fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    Table(
                      border: TableBorder.all(color: blackColor),
                      children: [
                        TableRow(
                          decoration: const BoxDecoration(
                            color: tertiaryColor,
                          ),
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Minggu Ke ${kehadiran.minggu}",
                                  style: kBold.copyWith(
                                      fontSize: 12, color: backgroundColor),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Tanda Tangan",
                                  style: kBold.copyWith(
                                      fontSize: 12, color: backgroundColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                        for (final kehadiranHarian in kehadiran.dataKehadiran)
                          TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    DateFormat.EEEE().format(
                                      DateTime.parse(kehadiranHarian.hariTanggal
                                          .toString()),
                                    ),
                                    style: kRegular.copyWith(
                                        fontSize: 12, color: tertiaryColor),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  // ignore: unnecessary_null_comparison
                                  child: kehadiranHarian.tandaTangan != null
                                      ? CachedNetworkImage(
                                          height: 40,
                                          imageUrl: kehadiran
                                              .dataKehadiran[subindex]
                                              .tandaTangan,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        )
                                      : Text(
                                          'Tidak ada tanda tangan',
                                          style: kRegular.copyWith(
                                              fontSize: 12,
                                              color: tertiaryColor),
                                        ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
