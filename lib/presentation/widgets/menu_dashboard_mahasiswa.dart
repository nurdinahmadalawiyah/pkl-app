import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';

class MenuDashboardMahasiswa extends StatelessWidget {
  const MenuDashboardMahasiswa({
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
          onTap: () {},
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
          onTap: () {},
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
