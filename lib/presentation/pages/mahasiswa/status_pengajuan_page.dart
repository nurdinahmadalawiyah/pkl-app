import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/common/result_state.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/presentation/provider/status_pengajuan_provider.dart';
import 'package:provider/provider.dart';

class StatusPengajuanPage extends StatelessWidget {
  const StatusPengajuanPage({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: ChangeNotifierProvider<StatusPengajuanProvider>(
          create: (_) => StatusPengajuanProvider(apiService: ApiService()),
          child:
              Consumer<StatusPengajuanProvider>(builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              return Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: state.list.data.length,
                      itemBuilder: (context, index) {
                        var status = state.list.data[index];
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                decoration: const BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.list.user.nama,
                                        overflow: TextOverflow.ellipsis,
                                        style: kSemiBold.copyWith(
                                          color: backgroundColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            state.list.user.nim,
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
                                              state.list.user.namaProdi,
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
                                    icon: const Icon(
                                        Icons.picture_as_pdf_rounded,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                      .format(
                                                          status.tanggalMulai),
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
                                                      .format(status
                                                          .tanggalSelesai),
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
                                    style: kBold.copyWith(
                                        fontSize: 18, color: tertiaryColor),
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
                      }),
                ],
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Text(
                  state.message,
                  style: kMedium.copyWith(color: blackColor, fontSize: 23),
                ),
              );
            } else if (state.state == ResultState.noConnection) {
              return Center(
                child: Text(
                  state.message,
                  style: kMedium.copyWith(color: blackColor, fontSize: 23),
                ),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Text(
                  state.message,
                  style: kMedium.copyWith(color: blackColor, fontSize: 23),
                ),
              );
            } else {
              return const Text('Unknown Error');
            }
          }),
        ),
      ),
    );
  }
}
