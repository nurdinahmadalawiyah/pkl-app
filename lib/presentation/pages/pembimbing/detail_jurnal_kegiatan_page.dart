// ignore_for_file: unused_local_variable, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/detail_jurnal_kegiatan_model.dart';
import 'package:magang_app/data/models/list_mahasiswa_model.dart';
import 'package:magang_app/presentation/cubit/jurnal_kegiatan/detail_jurnal_kegiatan_cubit.dart';
import 'package:magang_app/presentation/widgets/error_animation.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_connection_animation.dart';
import 'package:magang_app/presentation/widgets/no_data_animation.dart';

class DetailJurnalKegiatanPage extends StatefulWidget {
  const DetailJurnalKegiatanPage({super.key});

  @override
  State<DetailJurnalKegiatanPage> createState() =>
      _DetailJurnalKegiatanPageState();
}

class _DetailJurnalKegiatanPageState extends State<DetailJurnalKegiatanPage> {
  late Datum list;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    list = ModalRoute.of(context)?.settings.arguments as Datum;
    context
        .read<DetailJurnalKegiatanCubit>()
        .getDetailJurnalKegiatan(list.idMahasiswa.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Jurnal Kegiatan',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<DetailJurnalKegiatanCubit, DetailJurnalKegiatanState>(
        builder: (context, state) {
          if (state is DetailJurnalKegiatanLoading) {
            return const Center(
              child: LoadingAnimation(),
            );
          } else if (state is DetailJurnalKegiatanLoaded) {
            final jurnalKegiatan = state.jurnalKegiatan;
            return CardMingguJurnalKegiatan(jurnalKegiatan: jurnalKegiatan);
          } else if (state is DetailJurnalKegiatanNoData) {
            return Center(child: NoDataAnimation(message: state.message));
          } else if (state is DetailJurnalKegiatanNoConnection) {
            return Center(child: NoConnectionAnimation(message: state.message));
          } else if (state is DetailJurnalKegiatanError) {
            return Center(child: ErrorAnimation(message: state.message));
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
    );
  }
}

class CardMingguJurnalKegiatan extends StatelessWidget {
  const CardMingguJurnalKegiatan({
    Key? key,
    required this.jurnalKegiatan,
  }) : super(key: key);

  final DetailJurnalKegiatan jurnalKegiatan;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: jurnalKegiatan.data.length,
      itemBuilder: (context, index) {
        var jurnal = jurnalKegiatan.data[index];
        var subindex = 0;

        if (jurnal.dataKegiatan.length > 0) {
          subindex = jurnal.dataKegiatan.length - 1;
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.pushNamed(context, '/detail-jurnal-kegiatan-2',
                  arguments: jurnal);
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: accentColor,
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                title: Text(
                  "Minggu ${jurnal.minggu}",
                  style: kBold.copyWith(color: blackColor, fontSize: 16),
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            ),
          ),
        );
      },
    );
  }
}
