import 'package:flutter/material.dart';
import 'package:magang_app/common/constant.dart';

class JurnalKegiatanPage extends StatelessWidget {
  const JurnalKegiatanPage({Key? key}) : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Card(
          color: accentColor,
          margin: EdgeInsets.zero,
          elevation: 0,
          child: ListTile(
            onTap: () {},
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            title: Text(
              "Minggu ke 1",
              style: kBold.copyWith(color: blackColor, fontSize: 16),
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
        ),
      ),
    );
  }
}
