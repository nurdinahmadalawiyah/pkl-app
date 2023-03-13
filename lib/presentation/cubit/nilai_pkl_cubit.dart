// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/nilai_pkl_model.dart';

part 'nilai_pkl_state.dart';

class NilaiPklCubit extends Cubit<NilaiPklState> {
  final ApiService apiService;

  NilaiPklCubit({required this.apiService}) : super(NilaiPklInitial()) {
    getNilaiPkl();
  }

  void getNilaiPkl() async {
    emit(NilaiPklLoading());
    try {
      final nilaiPkl = await this.apiService.getNilaiPkl();
      if (nilaiPkl == null) {
        emit(const NilaiPklNoData(
            message: "Pembimbing dan Prodi Belum Memberikan Penilaian"));
      } else {
        emit(NilaiPklLoaded(nilaiPKL: nilaiPkl));
      }
    } on SocketException {
      emit(const NilaiPklNoConnection(message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(NilaiPklError(message: e.toString()));
    }
  }
}
