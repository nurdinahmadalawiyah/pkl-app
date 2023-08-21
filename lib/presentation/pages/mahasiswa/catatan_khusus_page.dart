import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/catatan_khusus_model.dart';
import 'package:magang_app/presentation/cubit/catatan_khusus/catatan_khusus_cubit.dart';
import 'package:magang_app/presentation/cubit/catatan_khusus/hapus_catatan_khusus_cubit.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_connection_animation.dart';
import 'package:magang_app/presentation/widgets/no_data_animation.dart';

class CatatanKhususPage extends StatefulWidget {
  const CatatanKhususPage({super.key});

  @override
  State<CatatanKhususPage> createState() => _CatatanKhususPageState();
}

class _CatatanKhususPageState extends State<CatatanKhususPage> {
  @override
  void initState() {
    super.initState();
    context.read<CatatanKhususCubit>().getCatatanKhusus();
  }

  @override
  Widget build(BuildContext context) {
    final HapusCatatanKhususCubit hapusCubit = HapusCatatanKhususCubit();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Catatan Khusus PKL',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<CatatanKhususCubit, CatatanKhususState>(
        builder: (context, state) {
          if (state is CatatanKhususLoading) {
            return const Center(child: LoadingAnimation());
          } else if (state is CatatanKhususLoaded) {
            final catatanKhusus = state.catatanKhusus;
            return GestureDetector(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Konfirmasi Hapus Catatan Khusus PKL",
                          style: kMedium.copyWith(color: tertiaryColor)),
                      content: Text(
                          "Apakah Anda yakin ingin menghapus catatan khusus?",
                          style: kRegular.copyWith(color: tertiaryColor)),
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                          onPressed: () async {
                            await hapusCubit.deleteCatatanKhusus();
                            Navigator.of(context).pop();
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/catatan-khusus',
                                ModalRoute.withName('/dashboard'));
                          },
                          child: const Text("Hapus"),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: primaryColor,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Batal"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: DataCatatanKhusus(catatanKhusus: catatanKhusus),
            );
          } else if (state is CatatanKhususNoData) {
            final message = state.message;
            return Center(
              child: NoDataAnimation(message: message),
            );
          } else if (state is CatatanKhususNoConnection) {
            final message = state.message;
            return Center(
              child: NoConnectionAnimation(message: message),
            );
          } else if (state is CatatanKhususError) {
            final message = state.message;
            return Center(
              child: NoDataAnimation(message: message),
            );
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<CatatanKhususCubit, CatatanKhususState>(
        builder: (context, state) {
          if (state is CatatanKhususError) {
            return const ButtonAdd();
          } else if (state is CatatanKhususNoData) {
            return const ButtonAdd();
          } else if (state is CatatanKhususLoaded) {
            return const ButtonAddDataAndPrint();
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
    );
  }
}

class DataCatatanKhusus extends StatelessWidget {
  const DataCatatanKhusus({
    super.key,
    required this.catatanKhusus,
  });

  final CatatanKhusus catatanKhusus;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 10,
            bottom: 20,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Presentasi, Permasalahan, Keunikan, dll',
                      style: kBold.copyWith(
                          fontSize: 12, color: blackColor),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      catatanKhusus.data.catatan,
                      style: kRegular.copyWith(
                          fontSize: 12, color: blackColor),
                    ),],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ButtonAddDataAndPrint extends StatelessWidget {
  const ButtonAddDataAndPrint({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding:
                const EdgeInsets.only(right: 5, bottom: 20, left: 20, top: 20),
            child: ElevatedButton.icon(
              onPressed: () =>
                  Navigator.pushNamed(context, "/tambah-catatan-khusus"),
              style: ElevatedButton.styleFrom(
                backgroundColor: tertiaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.all(15),
              ),
              icon: const Icon(
                IconlyBold.editSquare,
                color: backgroundColor,
              ),
              label: FittedBox(
                child: Text(
                  'Edit Data',
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
            padding:
                const EdgeInsets.only(right: 20, bottom: 20, left: 5, top: 20),
            child: ElevatedButton.icon(
              onPressed: () =>
                  Navigator.pushNamed(context, '/download-catatan-khusus'),
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
        onPressed: () =>
            Navigator.pushNamed(context, "/tambah-catatan-khusus"),
        style: ElevatedButton.styleFrom(
          backgroundColor: tertiaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(15),
        ),
        icon: const Icon(
          IconlyBold.editSquare,
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
