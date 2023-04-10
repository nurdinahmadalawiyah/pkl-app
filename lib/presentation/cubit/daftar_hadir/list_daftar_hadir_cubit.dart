import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/list_mahasiswa_model.dart';

part 'list_daftar_hadir_state.dart';

class ListDaftarHadirCubit extends Cubit<ListDaftarHadirState> {
  final ApiService apiService;
  
  ListDaftarHadirCubit({required this.apiService}) : super(ListDaftarHadirInitial()) {
    getListDaftarHadir();
  }

    void getListDaftarHadir() async {
    emit(ListDaftarHadirLoading());
    try {
      final listMahasiswa = await apiService.getListDaftarHadir();
      if (listMahasiswa.data.isEmpty) {
        emit(const ListDaftarHadirNoData(message: "Data Kosong"));
      } else {
        emit(ListDaftarHadirLoaded(listMahasiswa: listMahasiswa));
      }
    } on SocketException {
      emit(const ListDaftarHadirNoConnection(message: "Tidak Ada Koneksi Interner"));
    } catch (e) {
      emit(ListDaftarHadirError(message: e.toString()));
    }
  }
}
