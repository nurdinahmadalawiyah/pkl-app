import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';

class BiodataIndustriPage extends StatelessWidget {
  const BiodataIndustriPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Biodata Industri',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: ListView(
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
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'IDENTITAS INDUSTRI',
                        style: kBold.copyWith(
                            fontSize: 12, color: backgroundColor),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Nama Industri',
                        style: kRegular.copyWith(
                            fontSize: 12, color: backgroundColor),
                      ),
                      Text(
                        'Nama Direktur/Pimpinan',
                        style: kRegular.copyWith(
                            fontSize: 12, color: backgroundColor),
                      ),
                      Text(
                        'Alamat Kantor',
                        style: kRegular.copyWith(
                            fontSize: 12, color: backgroundColor),
                      ),
                      Text(
                        'No. Telepon/FAX',
                        style: kRegular.copyWith(
                            fontSize: 12, color: backgroundColor),
                      ),
                      Text(
                        'Contact Person',
                        style: kRegular.copyWith(
                            fontSize: 12, color: backgroundColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AKTIVITAS',
                        style: kBold.copyWith(
                            fontSize: 12, color: backgroundColor),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Bidang Usaha / Jasa',
                        style: kRegular.copyWith(
                            fontSize: 12, color: backgroundColor),
                      ),
                      Text(
                        'Spesialisasi Produksi / Jasa',
                        style: kRegular.copyWith(
                            fontSize: 12, color: backgroundColor),
                      ),
                      Text(
                        'Kapasitas Produksi',
                        style: kRegular.copyWith(
                            fontSize: 12, color: backgroundColor),
                      ),
                      Text(
                        'Jangkauan Pemasaran',
                        style: kRegular.copyWith(
                            fontSize: 12, color: backgroundColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 20,
              left: 20,
              right: 20,
            ),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TENAGA KERJA',
                  style: kBold.copyWith(fontSize: 12, color: blackColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Table(
                    columnWidths: const {
                      0: FractionColumnWidth(0.75),
                      1: FractionColumnWidth(0.25),
                    },
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        decoration: const BoxDecoration(
                          color: tertiaryColor,
                        ),
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Pendidikan',
                                textAlign: TextAlign.center,
                                style: kBold.copyWith(
                                    fontSize: 12, color: backgroundColor),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Jumlah',
                                textAlign: TextAlign.center,
                                style: kBold.copyWith(
                                    fontSize: 12, color: backgroundColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'SD',
                                style: kRegular.copyWith(
                                    fontSize: 12, color: blackColor),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '50',
                                style: kRegular.copyWith(
                                    fontSize: 12, color: blackColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'SLTP',
                                style: kRegular.copyWith(
                                    fontSize: 12, color: blackColor),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '75',
                                style: kRegular.copyWith(
                                    fontSize: 12, color: blackColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'SMK/STM/SMEA/SMKK/SMTK',
                                style: kRegular.copyWith(
                                    fontSize: 12, color: blackColor),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '100',
                                style: kRegular.copyWith(
                                    fontSize: 12, color: blackColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'SLTA Non SMK',
                                style: kRegular.copyWith(
                                    fontSize: 12, color: blackColor),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '30',
                                style: kRegular.copyWith(
                                    fontSize: 12, color: blackColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Sarjana Muda',
                                style: kRegular.copyWith(
                                    fontSize: 12, color: blackColor),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '20',
                                style: kRegular.copyWith(
                                    fontSize: 12, color: blackColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Sarjana Magister',
                                style: kRegular.copyWith(
                                    fontSize: 12, color: blackColor),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '20',
                                style: kRegular.copyWith(
                                    fontSize: 12, color: blackColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Doktor',
                                style: kRegular.copyWith(
                                    fontSize: 12, color: blackColor),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '20',
                                style: kRegular.copyWith(
                                    fontSize: 12, color: blackColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Jumlah Tenaga Kerja',
                  style: kRegular.copyWith(fontSize: 12, color: blackColor),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 5, bottom: 20, left: 20, top: 20),
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, "/isi-biodata-industri"),
                style: ElevatedButton.styleFrom(
                  primary: tertiaryColor,
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
                    'Isi/Edit Data',
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
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
      ),
    );
  }
}
