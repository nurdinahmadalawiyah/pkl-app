import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/biodata_industri_model.dart';

part 'biodata_industri_state.dart';

class BiodataIndustriCubit extends Cubit<BiodataIndustriState> {
  final ApiService apiService;

  BiodataIndustriCubit({required this.apiService}) : super(BiodataIndustriInitial()) {
    getBiodataIndustri();
  }

  void getBiodataIndustri() async {
    emit(BiodataIndustriLoading());
    try {
      final biodataIndustri = await apiService.getBiodataIndustri();
      if (biodataIndustri == null) {
        emit(BiodataIndustriNoData(message: "Biodata Industri Kosong"));
      } else {
        emit(BiodataIndustriLoaded(biodataIndustri: biodataIndustri));
      }
    } on SocketException {
      emit(BiodataIndustriNoConnection(message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(BiodataIndustriError(message: "Biodata Industri Kosong"));
    }
  }
}