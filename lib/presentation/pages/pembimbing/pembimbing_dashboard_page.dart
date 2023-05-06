// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/presentation/cubit/auth/auth_cubit.dart';

class PembimbingDashboardPage extends StatelessWidget {
  const PembimbingDashboardPage({super.key});

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
                primary: primaryColor,
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
                          onTap: () => Navigator.pushNamed(context, '/kelola-nilai'),
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
            const MenuDashboardPembimbing()
          ],
        ),
      ),
    );
  }
}

class MenuDashboardPembimbing extends StatelessWidget {
  const MenuDashboardPembimbing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: const Expanded(
        child: GridMenu(),
      ),
    );
  }
}

class GridMenu extends StatelessWidget {
  const GridMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: 6 / 8,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/list-biodata-industri'),
          child: GridTile(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    IconlyBold.document,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    'Biodata Industri',
                    textAlign: TextAlign.center,
                    style: kMedium.copyWith(fontSize: 10, color: tertiaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/list-jurnal-kegiatan'),
          child: GridTile(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    IconlyBold.activity,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    'Jurnal Kegiatan',
                    textAlign: TextAlign.center,
                    style: kMedium.copyWith(fontSize: 10, color: tertiaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/list-daftar-hadir'),
          child: GridTile(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    IconlyBold.paper,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    'Daftar Hadir',
                    textAlign: TextAlign.center,
                    style: kMedium.copyWith(fontSize: 10, color: tertiaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
