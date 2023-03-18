import 'package:flutter/material.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/common/result_state.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/presentation/cubit/pengajuan/lowongan_pkl_cubit.dart';
import 'package:magang_app/presentation/provider/lowongan_pkl_provider.dart';
import 'package:magang_app/presentation/widgets/card_lowongan_pkl.dart';
import 'package:magang_app/presentation/widgets/error_animation.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_connection_animation.dart';
import 'package:magang_app/presentation/widgets/no_data_animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LowonganPklPage extends StatefulWidget {
  const LowonganPklPage({Key? key}) : super(key: key);

  @override
  State<LowonganPklPage> createState() => _LowonganPklPageState();
}

class _LowonganPklPageState extends State<LowonganPklPage> {
  @override
  void initState() {
    context.read<LowonganPklCubit>().getLowonganPkl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: Text(
          'Lowongan PKL ',
          style: kMedium.copyWith(color: blackColor),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<LowonganPklCubit, LowonganPklState>(
                builder: (context, state) {
                  if (state is LowonganPklLoading) {
                    return const Center(
                      child: LoadingAnimation(),
                    );
                  } else {
                    if (state is LowonganPklLoaded) {
                      final lowongan = state.lowonganPkl;
                      return ListView(
                        children: [
                          CardLowonganPkl(lowonganPkl: lowongan),
                        ],
                      );
                    } else if (state is LowonganPklNoData) {
                      return Center(
                          child: NoDataAnimation(message: state.message));
                    } else if (state is LowonganPklNoConnections) {
                      return Center(
                          child: NoConnectionAnimation(message: state.message));
                    } else if (state is LowonganPklError) {
                      return Center(
                        child: ErrorAnimation(message: state.message),
                      );
                    } else {
                      return const Text('Unknown Error');
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
