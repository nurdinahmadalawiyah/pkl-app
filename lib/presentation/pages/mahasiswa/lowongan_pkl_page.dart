import 'package:flutter/material.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/common/result_state.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/presentation/provider/lowongan_pkl_provider.dart';
import 'package:magang_app/presentation/widgets/card_lowongan_pkl.dart';
import 'package:magang_app/presentation/widgets/error_animation.dart';
import 'package:magang_app/presentation/widgets/loading_animation.dart';
import 'package:magang_app/presentation/widgets/no_connection_animation.dart';
import 'package:magang_app/presentation/widgets/no_data_animation.dart';
import 'package:provider/provider.dart';

class LowonganPklPage extends StatelessWidget {
  const LowonganPklPage({Key? key}) : super(key: key);

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
              child: ChangeNotifierProvider(
                create: (_) => LowonganPklProvider(apiService: ApiService()),
                child: Consumer<LowonganPklProvider>(
                  builder: (context, state, _) {
                    if (state.state == ResultState.loading) {
                      return const Center(
                        child: LoadingAnimation(),
                      );
                    } else {
                      if (state.state == ResultState.hasData) {
                        return ListView.builder(
                          itemCount: state.list.data.length,
                          itemBuilder: (context, index) {
                            var lowongan = state.list.data[index];
                            return CardLowonganPkl(lowongan: lowongan,
                            );
                          },
                        );
                      } else if (state.state == ResultState.noData) {
                        return Center(
                          child: NoDataAnimation(message: state.message,)
                        );
                      } else if (state.state == ResultState.noConnection) {
                        return Center(
                          child: NoConnectionAnimation(message: state.message)
                        );
                      } else if (state.state == ResultState.error) {
                        return Center(
                          child: ErrorAnimation(message: state.message),
                        );
                      } else {
                        return const Text('Unknown Error');
                      }
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}