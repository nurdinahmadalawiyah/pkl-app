import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/detail_biodata_industri_model.dart';
import 'package:magang_app/data/models/list_mahasiswa_model.dart';
import 'package:magang_app/presentation/cubit/biodata_industri/detail_biodata_industri_cubit.dart';
import 'package:magang_app/presentation/cubit/biodata_industri/hapus_biodata_industri_cubit.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_data_animation.dart';

class DetailBiodataIndustriPage extends StatefulWidget {
  const DetailBiodataIndustriPage({super.key});

  @override
  State<DetailBiodataIndustriPage> createState() =>
      _DetailBiodataIndustriPageState();
}

class _DetailBiodataIndustriPageState extends State<DetailBiodataIndustriPage> {
  late Datum list;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    list = ModalRoute.of(context)?.settings.arguments as Datum;
    context.read<DetailBiodataIndustriCubit>().getDetailBiodataIndustri();
  }

  @override
  Widget build(BuildContext context) {
    final HapusBiodataIndustriCubit hapusCubit = HapusBiodataIndustriCubit();
    
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          "Detail Biodata Industri",
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: BlocBuilder<DetailBiodataIndustriCubit, DetailBiodataIndustriState>(
        builder: (context, state) {
          if (state is DetailBiodataIndustriLoading) {
            return const Center(child: LoadingAnimation());
          } else if (state is DetailBiodataIndustriLoaded) {
            final biodataIndustri = state.biodataIndustri;
            int jumlahTenagaKerja = (biodataIndustri.data.jumlahTenagaKerjaSd ??
                    0) +
                (biodataIndustri.data.jumlahTenagaKerjaSltp ?? 0) +
                (biodataIndustri.data.jumlahTenagaKerjaSmk ?? 0) +
                (biodataIndustri.data.jumlahTenagaKerjaSmkk ?? 0) +
                (biodataIndustri.data.jumlahTenagaKerjaSmea ?? 0) +
                (biodataIndustri.data.jumlahTenagaKerjaSlta ?? 0) +
                (biodataIndustri.data.jumlahTenagaKerjaSarjanaMuda ?? 0) +
                (biodataIndustri.data.jumlahTenagaKerjaSarjanaMagister ?? 0) +
                (biodataIndustri.data.jumlahTenagaKerjaSarjanaDoktor ?? 0);

            return GestureDetector(
                            onLongPress: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Konfirmasi Hapus Biodata Industri",
                          style: kMedium.copyWith(color: tertiaryColor)),
                      content: Text(
                          "Apakah Anda yakin ingin menghapus biodata industri?",
                          style: kRegular.copyWith(color: tertiaryColor)),
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                          onPressed: () async {
                            await hapusCubit.deleteBiodataIndustri();
                            Navigator.of(context).pop();
                            Navigator.pushNamedAndRemoveUntil(context, '/detail-biodata-industri', ModalRoute.withName('/dashboard-pembimbing'));
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
              child: ListView(
                children: [
                  DataBiodataIndustriAktivitas(biodataIndustri: biodataIndustri),
                  DataTenagaKerja(
                    biodataIndustri: biodataIndustri,
                    jumlahTenagaKerja: jumlahTenagaKerja,
                  ),
                ],
              ),
            );
          } else if (state is DetailBiodataIndustriNoData) {
            final message = state.message;
            return Center(
              child: NoDataAnimation(message: message),
            );
          } else if (state is DetailBiodataIndustriError) {
            final message = state.message;
            return Center(
              child: NoDataAnimation(message: message),
            );
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
      bottomNavigationBar:
          BlocBuilder<DetailBiodataIndustriCubit, DetailBiodataIndustriState>(
        builder: (context, state) {
          if (state is DetailBiodataIndustriError) {
            return const ButtonAdd();
          } else if (state is DetailBiodataIndustriNoData) {
            return const ButtonAdd();
          } else if (state is DetailBiodataIndustriLoaded) {
            return const ButtonEdit();
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
    );
  }
}

class ButtonAdd extends StatelessWidget {
  const ButtonAdd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, "/isi-biodata-industri"),
        style: ElevatedButton.styleFrom(
          backgroundColor: tertiaryColor,
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
            'Isi Data',
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: kSemiBold.copyWith(
              fontSize: 16,
              color: backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonEdit extends StatelessWidget {
  const ButtonEdit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, "/isi-biodata-industri"),
        style: ElevatedButton.styleFrom(
          backgroundColor: tertiaryColor,
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
            'Edit Data',
            textAlign: TextAlign.start,
            overflow: TextOverflow.clip,
            style: kSemiBold.copyWith(
              fontSize: 16,
              color: backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}

class DataTenagaKerja extends StatelessWidget {
  const DataTenagaKerja({
    Key? key,
    required this.biodataIndustri,
    required this.jumlahTenagaKerja,
  }) : super(key: key);

  final DetailBiodataIndustri biodataIndustri;
  final int jumlahTenagaKerja;

  @override
  Widget build(BuildContext context) {
    var jumlahSmk = (biodataIndustri.data.jumlahTenagaKerjaSmk ?? 0) +
        (biodataIndustri.data.jumlahTenagaKerjaSmea ?? 0) +
        (biodataIndustri.data.jumlahTenagaKerjaSmkk ?? 0);

    return Container(
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
            style: kBold.copyWith(fontSize: 12, color: tertiaryColor),
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
                              fontSize: 12, color: tertiaryColor),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          biodataIndustri.data.jumlahTenagaKerjaSd == null
                              ? "0"
                              : biodataIndustri.data.jumlahTenagaKerjaSd
                                  .toString(),
                          style: kRegular.copyWith(
                              fontSize: 12, color: tertiaryColor),
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
                              fontSize: 12, color: tertiaryColor),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          biodataIndustri.data.jumlahTenagaKerjaSltp == null
                              ? "0"
                              : biodataIndustri.data.jumlahTenagaKerjaSltp
                                  .toString(),
                          style: kRegular.copyWith(
                              fontSize: 12, color: tertiaryColor),
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
                              fontSize: 12, color: tertiaryColor),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          jumlahSmk == null ? "0" : jumlahSmk.toString(),
                          style: kRegular.copyWith(
                              fontSize: 12, color: tertiaryColor),
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
                              fontSize: 12, color: tertiaryColor),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          biodataIndustri.data.jumlahTenagaKerjaSlta == null
                              ? "0"
                              : biodataIndustri.data.jumlahTenagaKerjaSlta
                                  .toString(),
                          style: kRegular.copyWith(
                              fontSize: 12, color: tertiaryColor),
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
                              fontSize: 12, color: tertiaryColor),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          biodataIndustri.data.jumlahTenagaKerjaSarjanaMuda ==
                                  null
                              ? "0"
                              : biodataIndustri
                                  .data.jumlahTenagaKerjaSarjanaMuda
                                  .toString(),
                          style: kRegular.copyWith(
                              fontSize: 12, color: tertiaryColor),
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
                              fontSize: 12, color: tertiaryColor),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          biodataIndustri
                                      .data.jumlahTenagaKerjaSarjanaMagister ==
                                  null
                              ? "0"
                              : biodataIndustri
                                  .data.jumlahTenagaKerjaSarjanaMagister
                                  .toString(),
                          style: kRegular.copyWith(
                              fontSize: 12, color: tertiaryColor),
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
                              fontSize: 12, color: tertiaryColor),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          biodataIndustri.data.jumlahTenagaKerjaSarjanaDoktor ==
                                  null
                              ? "0"
                              : biodataIndustri
                                  .data.jumlahTenagaKerjaSarjanaDoktor
                                  .toString(),
                          style: kRegular.copyWith(
                              fontSize: 12, color: tertiaryColor),
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
            'Jumlah Tenaga Kerja : $jumlahTenagaKerja Orang',
            style: kRegular.copyWith(fontSize: 12, color: tertiaryColor),
          ),
        ],
      ),
    );
  }
}

class DataBiodataIndustriAktivitas extends StatelessWidget {
  const DataBiodataIndustriAktivitas({
    Key? key,
    required this.biodataIndustri,
  }) : super(key: key);

  final DetailBiodataIndustri biodataIndustri;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                color: secondaryColor, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'IDENTITAS INDUSTRI',
                  style: kBold.copyWith(fontSize: 12, color: backgroundColor),
                ),
                const SizedBox(height: 5),
                Text(
                  'Nama Industri : ${biodataIndustri.data.namaIndustri}',
                  style:
                      kRegular.copyWith(fontSize: 12, color: backgroundColor),
                ),
                Text(
                  'Nama Direktur/Pimpinan : ${biodataIndustri.data.namaPimpinan}',
                  style:
                      kRegular.copyWith(fontSize: 12, color: backgroundColor),
                ),
                Text(
                  'Alamat Kantor : ${biodataIndustri.data.alamatKantor}',
                  style:
                      kRegular.copyWith(fontSize: 12, color: backgroundColor),
                ),
                Text(
                  'No. Telepon/FAX : ${biodataIndustri.data.noTelpFax}',
                  style:
                      kRegular.copyWith(fontSize: 12, color: backgroundColor),
                ),
                Text(
                  'Contact Person : ${biodataIndustri.data.contactPerson}',
                  style:
                      kRegular.copyWith(fontSize: 12, color: backgroundColor),
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
                  style: kBold.copyWith(fontSize: 12, color: backgroundColor),
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bidang Usaha / Jasa : ',
                      style: kRegular.copyWith(
                          fontSize: 12, color: backgroundColor),
                    ),
                    Expanded(
                      child: Text(
                        '● ${biodataIndustri.data.bidangUsahaJasa.replaceAll('\n', '\n● ')}',
                        overflow: TextOverflow.clip,
                        style: kRegular.copyWith(
                            fontSize: 12, color: backgroundColor),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Spesialisasi Produksi / Jasa : ${biodataIndustri.data.spesialisasiProduksiJasa}',
                  style:
                      kRegular.copyWith(fontSize: 12, color: backgroundColor),
                ),
                Text(
                  'Kapasitas Produksi : ${biodataIndustri.data.kapasitasProduksi}',
                  style:
                      kRegular.copyWith(fontSize: 12, color: backgroundColor),
                ),
                Text(
                  'Jangkauan Pemasaran : ${biodataIndustri.data.jangkauanPemasaran}',
                  style:
                      kRegular.copyWith(fontSize: 12, color: backgroundColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
