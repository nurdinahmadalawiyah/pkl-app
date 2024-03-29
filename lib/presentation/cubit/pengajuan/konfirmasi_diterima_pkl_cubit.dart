import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:magang_app/data/api/api_service.dart';

part 'konfirmasi_diterima_pkl_state.dart';

class KonfirmasiDiterimaPklCubit extends Cubit<KonfirmasiDiterimaPklState> {
  final ApiService _apiService = ApiService();

  final pengajuanController = TextEditingController();
  final pembimbingController = TextEditingController();

  KonfirmasiDiterimaPklCubit() : super(KonfirmasiDiterimaPklInitial());

  void resetState() {
    emit(KonfirmasiDiterimaPklInitial());
  }

  Future<void> konfirmasiDiterimaPkl(
    String idPengajuan,
    String idPembimbing,
  ) async {
    try {
      emit(KonfirmasiDiterimaPklLoading());
      final response = await _apiService.konfirmasiDiterimaPkl(idPengajuan, idPembimbing);
      emit(const KonfirmasiDiterimaPklSuccess(konfirmasiDiterimaPkl: "Success"));
    } catch (e) {
      emit(KonfirmasiDiterimaPklError(message: e.toString()));
    }
  }

  void resetForm() {
    pengajuanController.clear();
    pembimbingController.clear();
  }
}
