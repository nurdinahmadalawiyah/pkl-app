import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/list_mahasiswa_model.dart';
import 'package:magang_app/presentation/cubit/jurnal_kegiatan/list_jurnal_kegiatan_cubit.dart';
import 'package:magang_app/presentation/widgets/error_animation.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_connection_animation.dart';
import 'package:magang_app/presentation/widgets/no_data_animation.dart';

class ListJurnalKegiatanPage extends StatelessWidget {
  const ListJurnalKegiatanPage({super.key});

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
      body: BlocBuilder<ListJurnalKegiatanCubit, ListJurnalKegiatanState>(
        builder: (context, state) {
          if (state is ListJurnalKegiatanLoading) {
            return const Center(
              child: LoadingAnimation(),
            );
          } else if (state is ListJurnalKegiatanLoaded) {
            final listMahasiswa = state.listMahasiswa;
            return CardListJurnalKegiatan(listMahasiswa: listMahasiswa);
          } else if (state is ListJurnalKegiatanNoData) {
            return Center(
              child: NoDataAnimation(message: state.message),
            );
          } else if (state is ListJurnalKegiatanNoConnection) {
            return Center(
              child: NoConnectionAnimation(message: state.message),
            );
          } else if (state is ListJurnalKegiatanError) {
            return Center(child: ErrorAnimation(message: state.message));
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
    );
  }
}

class CardListJurnalKegiatan extends StatelessWidget {
  const CardListJurnalKegiatan({
    Key? key,
    required this.listMahasiswa,
  }) : super(key: key);

  final ListMahasiswa listMahasiswa;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: listMahasiswa.data.length,
      itemBuilder: (context, index) {
        var list = listMahasiswa.data[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => Navigator.pushNamed(context, '/detail-jurnal-kegiatan', arguments: list),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: accentColor,
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                title: Text(
                  list.namaMahasiswa,
                  style: kBold.copyWith(color: blackColor, fontSize: 16),
                ),
                subtitle: Text(
                  list.nim,
                  style: kRegular.copyWith(color: blackColor, fontSize: 16),
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
