import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/lowongan_pkl_model.dart';

class CardLowonganPkl extends StatelessWidget {
  const CardLowonganPkl({
    Key? key,
    required this.lowongan,
  }) : super(key: key);

  final Lowongan lowongan;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        color: accentColor,
        margin: EdgeInsets.zero,
        elevation: 0,
        child: ListTile(
          onTap: () {},
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: lowongan.gambar,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          title: Text(
            lowongan.posisi,
            style: kBold.copyWith(color: blackColor, fontSize: 16),
          ),
          subtitle: Text(
            lowongan.namaPerusahaan,
            style: kRegular.copyWith(color: blackColor, fontSize: 12),
          ),
          trailing: const Icon(Icons.chevron_right_rounded),
        ),
      ),
    );
  }
}
