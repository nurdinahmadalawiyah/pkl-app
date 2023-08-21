import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/detail_catatan_khusus.dart';
import 'package:magang_app/data/models/list_mahasiswa_model.dart';
import 'package:magang_app/presentation/cubit/catatan_khusus/detail_catatan_khusus_cubit.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_data_animation.dart';

class DetailCatatanKhususPage extends StatefulWidget {
  const DetailCatatanKhususPage({super.key});

  @override
  State<DetailCatatanKhususPage> createState() =>
      _DetailCatatanKhususPageState();
}

class _DetailCatatanKhususPageState extends State<DetailCatatanKhususPage> {
  late Datum list;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    list = ModalRoute.of(context)?.settings.arguments as Datum;
    context
        .read<DetailCatatanKhususCubit>()
        .getDetailCatatanKhusus(list.idMahasiswa.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Catatan Khusus PKL",
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<DetailCatatanKhususCubit, DetailCatatanKhususState>(
        builder: (context, state) {
          if (state is DetailCatatanKhususLoading) {
            return const Center(child: LoadingAnimation());
          } else if (state is DetailCatatanKhususLoaded) {
            final catatanKhusus = state.catatanKhusus;
            return DataCatatanKhusus(catatanKhusus: catatanKhusus);
          } else if (state is DetailCatatanKhususNoData) {
            final message = state.message;
            return Center(
              child: NoDataAnimation(message: message),
            );
          } else if (state is DetailCatatanKhususError) {
            final message = state.message;
            return Center(
              child: NoDataAnimation(message: message),
            );
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

  final DetailCatatanKhusus catatanKhusus;

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
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
