import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/tambah_jurnal_kegiatan_model.dart';

part 'tambah_jurnal_kegiatan_state.dart';

class TambahJurnalKegiatanCubit extends Cubit<TambahJurnalKegiatanState> {
  final ApiService apiService = ApiService();

  // final mingguController = TextEditingController();
  // final hariTanggalController = TextEditingController();
  // final bidangPekerjaanController = TextEditingController();
  // final keteranganController = TextEditingController();

  TambahJurnalKegiatanCubit() : super(TambahJurnalKegiatanInitial());

  void resetState() {
    emit(TambahJurnalKegiatanInitial());
  }

  Future<void> addJurnalKegiatan(String tanggal, String minggu,
      String bidangPekerjaan, String keterangan) async {
    try {
      emit(TambahJurnalKegiatanLoading());
      final response = await apiService.addJurnalKegiatan(
          tanggal, minggu, bidangPekerjaan, keterangan);
      emit(TambahJurnalKegiatanSuccess(tambahJurnalKegiatan: response));
    } catch (e) {
      emit(TambahJurnalKegiatanError(message: e.toString()));
    }
  }
}
