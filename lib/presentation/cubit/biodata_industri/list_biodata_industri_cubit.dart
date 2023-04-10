import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/list_mahasiswa_model.dart';

part 'list_biodata_industri_state.dart';

class ListBiodataIndustriCubit extends Cubit<ListBiodataIndustriState> {
  final ApiService apiService;

  ListBiodataIndustriCubit({required this.apiService}) : super(ListBiodataIndustriInitial()) {
    getListBiodataIndustri();
  }

  void getListBiodataIndustri() async {
    emit(ListBiodataIndustriLoading());
    try {
      final listMahasiswa = await apiService.getListBiodataIndustri();
      if (listMahasiswa.data.isEmpty) {
        emit(const ListBiodataIndustriNoData(message: "Data Kosong"));
      } else {
        emit(ListBiodataIndustriLoaded(listMahasiswa: listMahasiswa));
      }
    } on SocketException {
      emit(const ListBiodataIndustriNoConnection(message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(ListBiodataIndustriError(message: e.toString()));
    }
  }
}
