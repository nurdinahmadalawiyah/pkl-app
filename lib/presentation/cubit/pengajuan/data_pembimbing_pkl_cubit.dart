import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/data_pembimbing_pkl_model.dart';

part 'data_pembimbing_pkl_state.dart';

class DataPembimbingPklCubit extends Cubit<DataPembimbingPklState> {
  final ApiService apiService;

  DataPembimbingPklCubit({required this.apiService}) : super(DataPembimbingPklInitial()) {
    getDataPembimbingPkl();
  }

  void getDataPembimbingPkl() async {
    emit(DataPembimbingPklLoading());
    try {
      final dataPembimbingPkl = await apiService.getDataPembimbingPkl();
      if (dataPembimbingPkl.data.isEmpty) {
        emit(const DataPembimbingPklNoData(message: "Tidak Ada Data Pembimbing"));
      } else {
        emit(DataPembimbingPklLoaded(dataPembimbingPkl: dataPembimbingPkl));
      }
       } on SocketException {
      emit(const DataPembimbingPklNoConnection(message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(DataPembimbingPklError(message: e.toString()));
    }
  }
}
