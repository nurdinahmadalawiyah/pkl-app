// ignore_for_file: prefer_is_empty, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/daftar_hadir_model.dart';
import 'package:magang_app/presentation/cubit/daftar_hadir/daftar_hadir_cubit.dart';
import 'package:magang_app/presentation/widgets/error_animation.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_connection_animation.dart';
import 'package:magang_app/presentation/widgets/no_data_animation.dart';

class DaftarHadirPage extends StatefulWidget {
  const DaftarHadirPage({Key? key}) : super(key: key);

  @override
  State<DaftarHadirPage> createState() => _DaftarHadirPageState();
}

class _DaftarHadirPageState extends State<DaftarHadirPage> {
  @override
  void initState() {
    super.initState();
    context.read<DaftarHadirCubit>().getDaftarHadir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Daftar Hadir',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<DaftarHadirCubit, DaftarHadirState>(
        builder: (context, state) {
          if (state is DaftarHadirLoading) {
            return const Center(
              child: LoadingAnimation(),
            );
          } else if (state is DaftarHadirLoaded) {
            final daftarHadir = state.daftarHadir;
            return CardDaftarHadir(daftarHadir: daftarHadir);
          } else if (state is DaftarHadirNoData) {
            return Center(child: NoDataAnimation(message: state.message));
          } else if (state is DaftarHadirNoConnections) {
            return Center(child: NoConnectionAnimation(message: state.message));
          } else if (state is DaftarHadirError) {
            return Center(child: ErrorAnimation(message: state.message));
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<DaftarHadirCubit, DaftarHadirState>(
        builder: (context, state) {
          if (state is DaftarHadirError) {
            return const ButtonAdd();
          } else if (state is DaftarHadirNoData) {
            return const ButtonAdd();
          } else if (state is DaftarHadirLoaded) {
            final daftarHadir = state.daftarHadir;
            return ButtonAddDataAndPrint(daftarHadir: daftarHadir);
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
    );
  }
}

class ButtonAddDataAndPrint extends StatelessWidget {
  const ButtonAddDataAndPrint({
    super.key,
    required this.daftarHadir,
  });

  final DaftarHadir daftarHadir;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(
                right: 5, bottom: 20, left: 20, top: 20),
            child: ElevatedButton.icon(
              onPressed: () =>
                  Navigator.pushNamed(context, '/tambah-daftar-hadir'),
              style: ElevatedButton.styleFrom(
                backgroundColor: tertiaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.all(15),
              ),
              icon: const Icon(
                IconlyBold.plus,
                color: backgroundColor,
              ),
              label: FittedBox(
                child: Text(
                  'Tambah Data',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: kSemiBold.copyWith(
                    fontSize: 16,
                    color: backgroundColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(
                right: 20, bottom: 20, left: 5, top: 20),
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(
                  context, '/download-daftar-hadir',
                  arguments: daftarHadir),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
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
          ),
        ),
      ],
    );
  }
}

class ButtonAdd extends StatelessWidget {
  const ButtonAdd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, '/tambah-daftar-hadir'),
        style: ElevatedButton.styleFrom(
          backgroundColor: tertiaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(15),
        ),
        icon: const Icon(
          IconlyBold.plus,
          color: backgroundColor,
        ),
        label: FittedBox(
          child: Text(
            'Tambah Data',
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

        if (kehadiran.dataKehadiran.length > 0) {
          subindex = kehadiran.dataKehadiran.length - 1;
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.pushNamed(context, '/daftar-hadir-detail',
                  arguments: kehadiran);
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
                  "Minggu ${kehadiran.minggu}",
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
