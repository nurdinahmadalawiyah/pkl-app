import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/list_mahasiswa_model.dart';

part 'list_nilai_pkl_state.dart';

class ListNilaiPklCubit extends Cubit<ListNilaiPklState> {
  final ApiService apiService;

  ListNilaiPklCubit({required this.apiService}) : super(ListNilaiPklInitial()) {
    getListNilaiPkl();
  }

  void getListNilaiPkl() async {
    emit(ListNilaiPklLoading());
    try {
      final listMahasiswa = await apiService.getListNilaiPkl();
      if (listMahasiswa.data.isEmpty) {
        emit(const ListNilaiPklNoData(message: "Data Kosong"));
      } else {
        emit(ListNilaiPklLoaded(listMahasiswa: listMahasiswa));
      }
    } on SocketException {
      emit(const ListNilaiPklNoConnection(message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(ListNilaiPklError(message: e.toString()));
    }
  }
}
