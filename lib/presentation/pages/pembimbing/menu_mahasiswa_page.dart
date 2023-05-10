import 'package:flutter/material.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/list_mahasiswa_model.dart';

class MenuMahasiswaPage extends StatelessWidget {
  const MenuMahasiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final list = ModalRoute.of(context)?.settings.arguments as Datum;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          list.namaMahasiswa,
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: ListView(
        children: [
          CardMenu(
            title: 'Biodata Industri',
            image: 'assets/biodata-industri.jpg',
            onTap: () {
              Navigator.pushNamed(context, '/detail-biodata-industri', arguments: list);
            },
          ),
          CardMenu(
            title: 'Jurnal Kegiatan',
            image: 'assets/jurnal-kegiatan.jpg',
            onTap: () {
              Navigator.pushNamed(context, '/detail-jurnal-kegiatan', arguments: list);
            },
          ),
          CardMenu(
            title: 'Biodata Industri',
            image: 'assets/daftar-hadir.jpg',
            onTap: () {
              Navigator.pushNamed(context, '/detail-daftar-hadir', arguments: list);
            },
          ),
        ],
      ),
    );
  }
}

class CardMenu extends StatelessWidget {
  const CardMenu({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  final String title;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  title,
                  overflow: TextOverflow.clip,
                  style: kSemiBold.copyWith(
                    fontSize: 20,
                    color: tertiaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.asset(
                  image,
                  width: 120,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
