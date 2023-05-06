// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/daftar_hadir_model.dart';
import 'package:magang_app/presentation/cubit/daftar_hadir/hapus_daftar_hadir_cubit.dart';
import 'package:magang_app/presentation/pages/mahasiswa/daftar_hadir_page.dart';

class DaftarHadirDetailPage extends StatelessWidget {
  const DaftarHadirDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final kehadiran =
        ModalRoute.of(context)?.settings.arguments as ListDaftarHadir;
    final HapusDaftarHadirCubit hapusCubit = HapusDaftarHadirCubit();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Minggu ${kehadiran.minggu}",
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: kehadiran.dataKehadiran.length,
        itemBuilder: (context, index) {
          var hadir = kehadiran.dataKehadiran[index];
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
                      context, '/edit-daftar-hadir',
                      arguments: hadir),
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
                              "Apakah Anda yakin ingin menghapus data pada tangal ${DateFormat('d MMMM y').format(hadir.hariTanggal)} ini?",
                              style: kMedium.copyWith(color: tertiaryColor)),
                          actions: [
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              onPressed: () async {
                                await hapusCubit.deleteDaftarHadir(
                                    hadir.idDaftarHadir.toString());
                                Navigator.of(context).pop();
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/daftar-hadir',
                                    ModalRoute.withName('/dashboard'));
                              },
                              child: const Text("Hapus"),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: primaryColor,
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
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 2.5),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Text(
                          DateFormat('EEEE, d MMMM y')
                              .format(hadir.hariTanggal),
                          style: kBold.copyWith(
                              color: backgroundColor, fontSize: 18),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: accentColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            height: 200,
                            imageUrl: hadir.tandaTangan,
                            // fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const ButtonAdd(),
    );
  }
}
