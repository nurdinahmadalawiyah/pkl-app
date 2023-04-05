import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/list_mahasiswa_model.dart';
import 'package:magang_app/presentation/cubit/penilaian/list_nilai_pkl_cubit.dart';
import 'package:magang_app/presentation/widgets/error_animation.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_connection_animation.dart';
import 'package:magang_app/presentation/widgets/no_data_animation.dart';

class KelolaNilaiPage extends StatefulWidget {
  const KelolaNilaiPage({super.key});

  @override
  State<KelolaNilaiPage> createState() => _KelolaNilaiPageState();
}

class _KelolaNilaiPageState extends State<KelolaNilaiPage> {
  @override
  void initState() {
    context.read<ListNilaiPklCubit>().getListNilaiPkl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Kelola Nilai',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<ListNilaiPklCubit, ListNilaiPklState>(
        builder: (context, state) {
          if (state is ListNilaiPklLoading) {
            return const Center(
              child: LoadingAnimation(),
            );
          } else if (state is ListNilaiPklLoaded) {
            final listMahasiswa = state.listMahasiswa;
            return CardListNilaiMahasiswa(listMahasiswa: listMahasiswa);
          } else if (state is ListNilaiPklNoData) {
            return Center(
              child: NoDataAnimation(message: state.message),
            );
          } else if (state is ListNilaiPklNoConnection) {
            return Center(
              child: NoConnectionAnimation(message: state.message),
            );
          } else if (state is ListNilaiPklError) {
            return Center(child: ErrorAnimation(message: state.message));
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
    );
  }
}

class CardListNilaiMahasiswa extends StatelessWidget {
  const CardListNilaiMahasiswa({
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
          margin: const EdgeInsets.only(
            bottom: 20,
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: accentColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: primaryColor,
                          width: 5,
                        ),
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        size: 50,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list.namaMahasiswa,
                            style: kSemiBold.copyWith(
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            list.namaProdi,
                            style: kMedium.copyWith(
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            list.nim,
                            style: kMedium.copyWith(
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  onTap: () {
                    // Navigator.pushNamed(context, '/edit-nilai');
                    Navigator.pushNamed(context, '/detail-kelola-nilai', arguments: list);
                  },
                  title: Text(
                    'Nilai PKL',
                    style: kMedium.copyWith(fontSize: 16),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                    color: backgroundColor,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
