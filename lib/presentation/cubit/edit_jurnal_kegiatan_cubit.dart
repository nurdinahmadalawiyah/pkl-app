import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/tambah_jurnal_kegiatan_model.dart';

part 'edit_jurnal_kegiatan_state.dart';

class EditJurnalKegiatanCubit extends Cubit<EditJurnalKegiatanState> {
  final ApiService apiService = ApiService();

  final mingguController = TextEditingController();
  final hariTanggalController = TextEditingController();
  final bidangPekerjaanController = TextEditingController();
  final keteranganController = TextEditingController();

  EditJurnalKegiatanCubit() : super(EditJurnalKegiatanInitial());

  void resetState() {
    emit(EditJurnalKegiatanInitial());
  }

  Future<void> updateJurnalKegiatan(
    String idJurnalKegiatan,
    String tanggal,
    String minggu,
    String bidangPekerjaan,
    String keterangan,
  ) async {
    try {
      emit(EditJurnalKegiatanLoading());
      final response = await apiService.updateJurnalKegiatan(
        idJurnalKegiatan,
        tanggal,
        minggu,
        bidangPekerjaan,
        keterangan,
      );
      emit(EditJurnalKegiatanSuccess(editJurnalKegiatan: response));
    } catch (e) {
      emit(EditJurnalKegiatanError(message: e.toString()));
    }
  }

  void resetForm() {
    mingguController.clear();
    hariTanggalController.clear();
    bidangPekerjaanController.clear();
    keteranganController.clear();
  }
}
