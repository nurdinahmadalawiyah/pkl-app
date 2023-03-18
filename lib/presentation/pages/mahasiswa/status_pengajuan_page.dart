import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/status_pengajuan_pkl_model.dart';
import 'package:magang_app/presentation/cubit/pengajuan/status_pengajuan_cubit.dart';
import 'package:magang_app/presentation/widgets/error_animation.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_connection_animation.dart';

class StatusPengajuanPage extends StatefulWidget {
  const StatusPengajuanPage({Key? key}) : super(key: key);

  @override
  State<StatusPengajuanPage> createState() => _StatusPengajuanPageState();
}

class _StatusPengajuanPageState extends State<StatusPengajuanPage> {
@override
  void initState() {
    super.initState();
    context.read<StatusPengajuanCubit>().getStatusPengajuan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: blackColor),
        title: Text(
          'Status Pengajuan Magang',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<StatusPengajuanCubit, StatusPengajuanState>(
        builder: (context, state) {
          if (state is StatusPengajuanLoading) {
            return const Center(
              child: LoadingAnimation(),
            );
          } else if (state is StatusPengajuanLoaded) {
            final statusPengajuan = state.statusPengajuanPkl;
            final profilePengajuan = state.statusPengajuanPkl;
            return ListView(
              children: [
                CardStatusPengajuan(
                    statusPengajuan: statusPengajuan,
                    profilePengajuan: profilePengajuan),
              ],
            );
          } else if (state is StatusPengajuanNoData) {
            return Center(
              child: Text(
                state.message,
                style: kMedium.copyWith(color: blackColor, fontSize: 23),
              ),
            );
          } else if (state is StatusPengajuanNoConnection) {
            return Center(
              child: NoConnectionAnimation(message: state.message)
            );
          } else if (state is StatusPengajuanError) {
            return Center(
              child: ErrorAnimation(message: state.message)
            );
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
    );
  }
}

class CardStatusPengajuan extends StatelessWidget {
  const CardStatusPengajuan({
    Key? key,
    required this.statusPengajuan,
    required this.profilePengajuan,
  }) : super(key: key);

  final StatusPengajuanPkl statusPengajuan;
  final StatusPengajuanPkl profilePengajuan;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: statusPengajuan.data.length,
        itemBuilder: (context, index) {
          var status = statusPengajuan.data[index];
          var profile = profilePengajuan.user;
          return Container(
            margin: const EdgeInsets.only(
                bottom: 7.5, top: 7.5, left: 20, right: 20),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.nama,
                          overflow: TextOverflow.ellipsis,
                          style: kSemiBold.copyWith(
                            color: backgroundColor,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              profile.nim,
                              style: kRegular.copyWith(
                                color: backgroundColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              " - ",
                              style: kMedium.copyWith(
                                color: backgroundColor,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                profile.namaProdi,
                                overflow: TextOverflow.ellipsis,
                                style: kMedium.copyWith(
                                  color: backgroundColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.picture_as_pdf_rounded,
                          color: backgroundColor),
                      onPressed: () {},
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              status.namaPerusahaan,
                              overflow: TextOverflow.clip,
                              style: kBold.copyWith(
                                color: backgroundColor,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              status.alamatPerusahaan,
                              overflow: TextOverflow.clip,
                              style: kMedium.copyWith(
                                color: backgroundColor,
                                fontSize: 14,
                              ),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    DateFormat('dd MMMM y')
                                        .format(status.tanggalMulai),
                                    style: kMedium.copyWith(
                                      color: backgroundColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Text(
                                  ' - ',
                                  style: kMedium.copyWith(
                                    color: backgroundColor,
                                    fontSize: 14,
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    DateFormat('dd MMMM y')
                                        .format(status.tanggalSelesai),
                                    overflow: TextOverflow.clip,
                                    style: kMedium.copyWith(
                                      color: backgroundColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    onTap: () {},
                    title: Text(
                      'STATUS',
                      style: kBold.copyWith(fontSize: 18, color: tertiaryColor),
                    ),
                    trailing: Text(
                      status.status.toUpperCase(),
                      style: kBold.copyWith(
                          fontSize: 18,
                          color: status.status == 'menunggu'
                              ? Colors.orange
                              : status.status == 'disetujui'
                                  ? const Color(0xFF008224)
                                  : status.status == 'ditolak'
                                      ? Colors.red
                                      : tertiaryColor),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
