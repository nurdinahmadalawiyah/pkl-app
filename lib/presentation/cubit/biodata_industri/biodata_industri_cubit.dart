// ignore_for_file: unnecessary_null_comparison

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
        emit(const BiodataIndustriNoData(message: "Biodata Industri Kosong\nPembimbing Anda Belum Mengisi Biodata Industri"));
      } else {
        emit(BiodataIndustriLoaded(biodataIndustri: biodataIndustri));
      }
    } on SocketException {
      emit(const BiodataIndustriNoConnection(message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(const BiodataIndustriError(message: "Biodata Industri Kosong\nPembimbing Anda Belum Mengisi Biodata Industri"));
    }
  }

  void resetCubit() {
    emit(BiodataIndustriInitial());
  }
}
