import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/lowongan_pkl_model.dart';

class CardLowonganPkl extends StatelessWidget {
  const CardLowonganPkl({
    Key? key,
    required this.lowonganPkl,
  }) : super(key: key);

  final LowonganPkl lowonganPkl;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: lowonganPkl.data.length,
      itemBuilder: (context, index) {
        var lowongan = lowonganPkl.data[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Card(
            color: accentColor,
            margin: EdgeInsets.zero,
            elevation: 0,
            child: ListTile(
              onTap: () async {
                if (lowongan.url == null) {
                  Navigator.pushNamed(context, '/pengajuan-pkl');
                } else {
                  try {
                    await launch(
                      lowongan.url,
                      customTabsOption: CustomTabsOption(
                        enableDefaultShare: true,
                        enableUrlBarHiding: true,
                        showPageTitle: true,
                        animation: CustomTabsSystemAnimation.slideIn(),
                        extraCustomTabs: const <String>[
                          'org.mozilla.firefox',
                          'com.microsoft.emmx',
                        ],
                      ),
                    );
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                }
              },
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
                overflow: TextOverflow.ellipsis,
                style: kBold.copyWith(color: tertiaryColor, fontSize: 14),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lowongan.namaPerusahaan,
                    overflow: TextOverflow.ellipsis,
                    style: kRegular.copyWith(color: tertiaryColor, fontSize: 12),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Lamar di ${lowongan.sumber}",
                      overflow: TextOverflow.ellipsis,
                      style: kRegular.copyWith(
                          color: backgroundColor, fontSize: 10),
                    ),
                  ),
                ],
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
        );
      },
    );
  }
}
