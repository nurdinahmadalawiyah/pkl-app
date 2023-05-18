import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/presentation/cubit/dashboard/check_status_cubit.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';

class MenuDashboardMahasiswa extends StatefulWidget {
  const MenuDashboardMahasiswa({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuDashboardMahasiswa> createState() => _MenuDashboardMahasiswaState();
}

class _MenuDashboardMahasiswaState extends State<MenuDashboardMahasiswa> {
  @override
  void initState() {
    super.initState();
    context.read<CheckStatusCubit>().getCheckStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<CheckStatusCubit>().getCheckStatus();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: BlocBuilder<CheckStatusCubit, CheckStatusState>(
              builder: (context, state) {
                if (state is CheckStatusLoading) {
                  return const Center(
                    child: LoadingAnimation(),
                  ); 
                } else if (state is CheckStatusApproveWithConfirmed) {
                  return const GridMenuApproveComfirmed();
                } else if (state is CheckStatusApprove) {
                  return const GridMenuApprove();
                } else if (state is CheckStatusWaiting) {
                  return const GridMenu();
                } else if (state is CheckStatusReject) {
                  return const GridMenu();
                } else {
                  return const GridMenu();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class GridMenuApproveComfirmed extends StatelessWidget {
  const GridMenuApproveComfirmed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: 5 / 8,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/lowongan-pkl'),
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
                    IconlyBold.work,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    'Lowongan PKL',
                    textAlign: TextAlign.center,
                    style: kMedium.copyWith(fontSize: 10, color: tertiaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Lottie.asset(
                    'assets/pkl-icon.json',
                    fit: BoxFit.fill,
                  ),
                  content: Text(
                      "Maaf, Kamu tidak bisa melakukan konfirmasi diterima PKL lagi karena saat ini kamu terdata sedang menjalani PKL di perusahaan yang telah kamu ajukan sebelumnya",
                      textAlign: TextAlign.center,
                      style: kMedium.copyWith(color: tertiaryColor)),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: primaryColor,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          },
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
                    Icons.business_rounded,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    'Konfirmasi Diterima PKL',
                    textAlign: TextAlign.center,
                    style: kMedium.copyWith(fontSize: 10, color: tertiaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/biodata-industri'),
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
          onTap: () => Navigator.pushNamed(context, "/jurnal-kegiatan"),
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
          onTap: () => Navigator.pushNamed(context, "/nilai-pkl"),
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
                    IconlyBold.ticket_star,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    'Nilai PKL',
                    textAlign: TextAlign.center,
                    style: kMedium.copyWith(fontSize: 10, color: tertiaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/daftar-hadir'),
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
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/upload-laporan'),
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
                    IconlyBold.upload,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    'Upload Laporan PKL',
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

class GridMenuApprove extends StatelessWidget {
  const GridMenuApprove({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: 5 / 8,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/lowongan-pkl'),
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
                    IconlyBold.work,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    'Lowongan PKL',
                    textAlign: TextAlign.center,
                    style: kMedium.copyWith(fontSize: 10, color: tertiaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/konfirmasi-pkl'),
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
                    Icons.business_rounded,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    'Konfirmasi Diterima PKL',
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
      childAspectRatio: 5 / 8,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/lowongan-pkl'),
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
                    IconlyBold.work,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    'Lowongan PKL',
                    textAlign: TextAlign.center,
                    style: kMedium.copyWith(fontSize: 10, color: tertiaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Peringatan!",
                      style: kMedium.copyWith(color: tertiaryColor)),
                  content: Text(
                      "Kamu saat ini tidak bisa melakukan konfirmasi diterima PKL",
                      style: kRegular.copyWith(color: tertiaryColor)),
                  actions: [
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: primaryColor,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("OK"),
                    ),
                  ],
                );
              },
            );
          },
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
                    Icons.business_rounded,
                    size: 50,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Text(
                    'Konfirmasi Diterima PKL',
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
