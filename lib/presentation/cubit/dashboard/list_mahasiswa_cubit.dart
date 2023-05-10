import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/list_mahasiswa_model.dart';

part 'list_mahasiswa_state.dart';

class ListMahasiswaCubit extends Cubit<ListMahasiswaState> {
  final ApiService apiService;

  ListMahasiswaCubit({required this.apiService})
      : super(ListMahasiswaInitial()) {
    getListMahasiswa();
  }

  void getListMahasiswa() async {
    emit(ListMahasiswaLoading());
    try {
      final listMahasiswa = await apiService.getListMahasiswa();
      if (listMahasiswa.data.isEmpty) {
        emit(const ListMahasiswaNoData(message: "Tidak ada Mahasiswa yang di bimbing"));
      } else {
        emit(ListMahasiswaLoaded(listMahasiswa: listMahasiswa));
      }
    } on SocketException {
      emit(const ListMahasiswaNoConnection(message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(ListMahasiswaError(message: e.toString()));
    }
  }
}
