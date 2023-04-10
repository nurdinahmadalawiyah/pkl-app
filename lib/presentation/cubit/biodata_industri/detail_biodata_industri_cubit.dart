import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/biodata_industri_model.dart';

part 'detail_biodata_industri_state.dart';

class DetailBiodataIndustriCubit extends Cubit<DetailBiodataIndustriState> {
  final ApiService apiService;

  DetailBiodataIndustriCubit({required this.apiService})
      : super(DetailBiodataIndustriInitial());

  void getDetailBiodataIndustri(String idMahasiswa) async {
    emit(DetailBiodataIndustriLoading());
    try {
      final biodataIndustri =
          await apiService.getDetailBiodataIndustri(idMahasiswa);
      if (biodataIndustri.data == null) {
        emit(const DetailBiodataIndustriNoData(message: "Biodata Industri Kosong"));
      } else {
        emit(DetailBiodataIndustriLoaded(biodataIndustri: biodataIndustri));
      }
    } on SocketException {
      emit(const DetailBiodataIndustriNoConnection(message: "Tidak Ada Koneksi Interner"));
    } catch (e) {
      emit(const DetailBiodataIndustriError(message: "Biodata Industri Kosong"));
    }
  }

  void resetState() {
    emit(DetailBiodataIndustriInitial());
  }
}