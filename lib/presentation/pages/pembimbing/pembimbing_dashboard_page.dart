// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/list_mahasiswa_model.dart';
import 'package:magang_app/presentation/cubit/auth/auth_cubit.dart';
import 'package:magang_app/presentation/cubit/dashboard/list_mahasiswa_cubit.dart';
import 'package:magang_app/presentation/widgets/error_animation.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_connection_animation.dart';
import 'package:magang_app/presentation/widgets/no_data_animation.dart';

class PembimbingDashboardPage extends StatefulWidget {
  const PembimbingDashboardPage({super.key});

  @override
  State<PembimbingDashboardPage> createState() =>
      _PembimbingDashboardPageState();
}

class _PembimbingDashboardPageState extends State<PembimbingDashboardPage> {
  @override
  void initState() {
    context.read<ListMahasiswaCubit>().getListMahasiswa();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = AuthCubit();
    const storage = FlutterSecureStorage();

    handleLogout() async {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Konfirmasi Logout',
              style: kMedium.copyWith(color: blackColor)),
          content: Text('Apakah anda yakin ingin logout dari akun anda?',
              style: kRegular.copyWith(color: blackColor)),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              onPressed: () async {
                String? token = await storage.read(key: 'token');
                if (token != null) {
                  await authCubit.logoutPembimbing(token);
                  Navigator.pushReplacementNamed(context, '/login-pembimbing');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 3),
                      content: Text(
                        'Logout Berhasil',
                        textAlign: TextAlign.center,
                        style: kMedium.copyWith(color: backgroundColor),
                      ),
                      backgroundColor: tertiaryColor,
                    ),
                  );
                } else {
                  Navigator.pushReplacementNamed(context, '/login-pembimbing');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 3),
                      content: Text(
                        'Terjadi Kesalahan Saat Proses Logout',
                        textAlign: TextAlign.center,
                        style: kMedium.copyWith(color: backgroundColor),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                await storage.delete(key: 'token');
              },
              child: const Text('Ya'),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batalkan'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              'PKL ',
              style: kSemiBold.copyWith(
                color: primaryColor,
                fontSize: 24,
              ),
            ),
            Text(
              'TEDC',
              style: kSemiBold.copyWith(
                color: blackColor,
                fontSize: 24,
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            color: greyColor,
            icon: const Icon(
              Icons.more_vert_rounded,
              color: blackColor,
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: ListTile(
                  onTap: () async {
                    handleLogout();
                  },
                  trailing: const Icon(
                    IconlyBold.logout,
                    color: primaryColor,
                  ),
                  title: Text(
                    'Logout',
                    style: kMedium.copyWith(
                      color: blackColor,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'Kelola Nilai PKL',
                            style: kSemiBold.copyWith(
                              fontSize: 20,
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, '/kelola-nilai'),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              IconlyBold.editSquare,
                              color: backgroundColor,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<ListMahasiswaCubit, ListMahasiswaState>(
              builder: (context, state) {
                if (state is ListMahasiswaLoading) {
                  return const Center(
                    child: LoadingAnimation(),
                  );
                } else if (state is ListMahasiswaLoaded) {
                  final listMahasiswa = state.listMahasiswa;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(
                          'Daftar Mahasiswa',
                          style: kMedium.copyWith(color: blackColor, fontSize: 16),
                        ),
                      ),
                      CardListMahasiswa(
                        listMahasiswa: listMahasiswa,
                      ),
                    ],
                  );
                } else if (state is ListMahasiswaNoData) {
                  return Center(
                    child: NoDataAnimation(message: state.message),
                  );
                } else if (state is ListMahasiswaNoConnection) {
                  return Center(
                    child: NoConnectionAnimation(message: state.message),
                  );
                } else if (state is ListMahasiswaError) {
                  return Center(child: ErrorAnimation(message: state.message));
                } else {
                  return const Text('Unknown Error');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class CardListMahasiswa extends StatelessWidget {
  const CardListMahasiswa({
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
            onTap: () => Navigator.pushNamed(context, '/menu-mahasiswa', arguments: list),
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
