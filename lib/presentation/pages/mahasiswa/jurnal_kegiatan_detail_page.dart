// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/jurnal_kegiatan_model.dart';
import 'package:magang_app/presentation/cubit/jurnal_kegiatan/hapus_jurnal_kegiatan_cubit.dart';

class JurnalKegiatanDetailPage extends StatelessWidget {
  const JurnalKegiatanDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final jurnalKegiatan = ModalRoute.of(context)?.settings.arguments as ListJurnalKegiatan;
    final HapusJurnalKegiatanCubit hapusCubit = HapusJurnalKegiatanCubit();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Minggu ${jurnalKegiatan.minggu}",
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: jurnalKegiatan.dataKegiatan.length,
        itemBuilder: (context, index) {
          var jurnal = jurnalKegiatan.dataKegiatan[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Slidable(
              actionPane: const SlidableDrawerActionPane(),
              actionExtentRatio: 0.3,
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Edit Data',
                  color: accentColor,
                  icon: IconlyBold.editSquare,
                  onTap: () => Navigator.pushNamed(
                      context, '/edit-jurnal-kegiatan',
                      arguments: jurnal),
                ),
                IconSlideAction(
                  caption: 'Hapus Data',
                  color: Colors.red,
                  icon: IconlyBold.delete,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Konfirmasi Hapus Data",
                              style: kMedium.copyWith(color: tertiaryColor)),
                          content: Text(
                              "Apakah Anda yakin ingin menghapus data pada tangal ${DateFormat('d MMMM y').format(jurnal.tanggal)} ini?",
                              style: kMedium.copyWith(color: tertiaryColor)),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.red,
                              ),
                              onPressed: () async {
                                await hapusCubit.deleteJurnalKegiatan(jurnal.idJurnalKegiatan.toString());
                                Navigator.of(context).pop();
                                Navigator.pushNamedAndRemoveUntil(context, '/jurnal-kegiatan', ModalRoute.withName('/dashboard'));
                              },
                              child: const Text("Hapus"),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: primaryColor,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Batal"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  color: primaryColor,
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('EEEE, d MMMM y').format(jurnal.tanggal),
                          style: kBold.copyWith(
                              color: backgroundColor, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Bidang Pekerjaan : ${jurnal.bidangPekerjaan}',
                          style: kMedium.copyWith(
                              color: backgroundColor, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Keterangan',
                          style: kMedium.copyWith(
                              color: backgroundColor, fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '● ${jurnal.keterangan.replaceAll('\n', '\n● ')}',
                          style: kMedium.copyWith(
                              color: backgroundColor, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomAddDataAndPrint(),
    );
  }
}

class BottomAddDataAndPrint extends StatelessWidget {
  const BottomAddDataAndPrint({
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
                  Navigator.pushNamed(context, '/tambah-jurnal-kegiatan'),
              style: ElevatedButton.styleFrom(
                primary: tertiaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.all(15),
              ),
              icon: const Icon(
                IconlyBold.plus,
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
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding:
                const EdgeInsets.only(right: 20, bottom: 20, left: 5, top: 20),
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
    );
  }
}
