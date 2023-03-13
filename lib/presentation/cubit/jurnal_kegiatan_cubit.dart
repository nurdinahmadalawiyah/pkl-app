// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/jurnal_kegiatan_model.dart';

part 'jurnal_kegiatan_state.dart';

class JurnalKegiatanCubit extends Cubit<JurnalKegiatanState> {
  final ApiService apiService;

  JurnalKegiatanCubit({required this.apiService})
      : super(JurnalKegiatanInitial()) {
    getJurnalKegiatan();
  }

  void getJurnalKegiatan() async {
    emit(JurnalKegiatanLoading());
    try {
      final jurnalKegiatan = await apiService.getJurnalKegiatan();
      if (jurnalKegiatan == null ) {
        emit(const JurnalKegiatanNoData(message: "Tidak Ada Jurnal Kegiatan"));
      } else {
        emit(JurnalKegiatanLoaded(jurnalKegiatan: jurnalKegiatan));
      }
    } on SocketException {
      emit(const JurnalKegiatanNoConnection(message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(JurnalKegiatanError(message: e.toString()));
    }
  }
}
