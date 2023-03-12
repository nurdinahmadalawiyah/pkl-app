import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      itemBuilder: (context, index,) {
        var jurnal = jurnalKegiatan.data[index];
        var subindex = 0; // set subindex ke 0

        if (jurnal.dataKegiatan.length > 0) {
          subindex = jurnal.dataKegiatan.length - 1;
        }

        var detailJurnal = jurnal.dataKegiatan[subindex];

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Card(
            color: accentColor,
            margin: EdgeInsets.zero,
            elevation: 0,
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/jurnal-kegiatan-detail',
                    arguments: jurnal);
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              title: Text(
                "Minggu ${jurnal.minggu}",
                style: kBold.copyWith(color: blackColor, fontSize: 16),
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
        );
      },
    );
  }
}
