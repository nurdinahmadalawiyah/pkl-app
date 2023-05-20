import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/detail_jurnal_kegiatan_model.dart';

class DetailJurnalKegiatan2Page extends StatefulWidget {
  const DetailJurnalKegiatan2Page({super.key});

  @override
  State<DetailJurnalKegiatan2Page> createState() =>
      _DetailJurnalKegiatan2PageState();
}

class _DetailJurnalKegiatan2PageState extends State<DetailJurnalKegiatan2Page> {
  @override
  Widget build(BuildContext context) {
    final jurnalKegiatan =
        ModalRoute.of(context)?.settings.arguments as ListJurnalKegiatan;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Jurnal Kegiatan',
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
          );
        },
      ),
    );
  }
}
