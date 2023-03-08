import 'package:flutter/material.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/common/result_state.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/presentation/provider/lowongan_pkl_provider.dart';
import 'package:magang_app/presentation/widgets/card_lowongan_pkl.dart';
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
                        child: CircularProgressIndicator(),
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
                          child: Text(
                            state.message,
                            style: kMedium.copyWith(
                                color: blackColor, fontSize: 23),
                          ),
                        );
                      } else if (state.state == ResultState.noConnection) {
                        return Center(
                          child: Text(
                            state.message,
                            style: kMedium.copyWith(
                                color: blackColor, fontSize: 23),
                          ),
                        );
                      } else if (state.state == ResultState.error) {
                        return Center(
                          child: Text(
                            state.message,
                            style: kMedium.copyWith(
                                color: blackColor, fontSize: 23),
                          ),
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