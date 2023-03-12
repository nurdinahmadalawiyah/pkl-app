import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/models/jurnal_kegiatan_model.dart';
import 'package:magang_app/presentation/cubit/jurnal_kegiatan_cubit.dart';
import 'package:magang_app/presentation/widgets/error_animation.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_connection_animation.dart';

class JurnalKegiatanPage extends StatefulWidget {
  const JurnalKegiatanPage({Key? key}) : super(key: key);

  @override
  State<JurnalKegiatanPage> createState() => _JurnalKegiatanPageState();
}

class _JurnalKegiatanPageState extends State<JurnalKegiatanPage> {
  @override
  void initState() {
    super.initState();
    context.read<JurnalKegiatanCubit>().getJurnalKegiatan();
  }

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
      body: BlocBuilder<JurnalKegiatanCubit, JurnalKegiatanState>(
        builder: (context, state) {
          if (state is JurnalKegiatanLoading) {
            return const Center(
              child: LoadingAnimation(),
            );
          } else if (state is JurnalKegiatanLoaded) {
            final jurnalKegiatan = state.jurnalKegiatan;
            return CardJurnalKegiatan(jurnalKegiatan: jurnalKegiatan);
          } else if (state is JurnalKegiatanNoData) {
            return Center(
              child: Text(
                state.message,
                style: kMedium.copyWith(color: blackColor, fontSize: 23),
              ),
            );
          } else if (state is JurnalKegiatanNoConnection) {
            return Center(child: NoConnectionAnimation(message: state.message));
          } else if (state is JurnalKegiatanError) {
            return Center(child: ErrorAnimation(message: state.message));
          } else {
            return const Text('Unknown Error');
          }
        },
      ),
      bottomNavigationBar: const ButtonAddData(),
    );
  }
}

class ButtonAddData extends StatelessWidget {
  const ButtonAddData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton.icon(
        onPressed: () =>
            Navigator.pushNamed(context, '/tambah-jurnal-kegiatan'),
        style: ElevatedButton.styleFrom(
            primary: tertiaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.all(15)),
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
    );
  }
}

class CardJurnalKegiatan extends StatelessWidget {
  const CardJurnalKegiatan({
    Key? key,
    required this.jurnalKegiatan,
  }) : super(key: key);

  final JurnalKegiatan jurnalKegiatan;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: jurnalKegiatan.data.length,
      itemBuilder: (
        context,
        index,
      ) {
        var jurnal = jurnalKegiatan.data[index];
        var subindex = 0; // set subindex ke 0

        if (jurnal.dataKegiatan.length > 0) {
          subindex = jurnal.dataKegiatan.length - 1;
        }

        var detailJurnal = jurnal.dataKegiatan[subindex];

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              Navigator.pushNamed(context, '/jurnal-kegiatan-detail',
                  arguments: jurnal);
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: accentColor,
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                title: Text(
                  "Minggu ${jurnal.minggu}",
                  style: kBold.copyWith(color: blackColor, fontSize: 16),
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            ),
          ),
        );
      },
    );
  }
}
