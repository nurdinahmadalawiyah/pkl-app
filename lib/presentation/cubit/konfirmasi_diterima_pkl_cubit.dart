import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/konfirmasi_diterima_pkl_model.dart';

part 'konfirmasi_diterima_pkl_state.dart';

class KonfirmasiDiterimaPklCubit extends Cubit<KonfirmasiDiterimaPklState> {
  final ApiService _apiService = ApiService();

  final pengajuanController = TextEditingController();
  final namaPembimbingController = TextEditingController();
  final nikPembimbingController = TextEditingController();

  KonfirmasiDiterimaPklCubit() : super(KonfirmasiDiterimaPklInitial());

  void resetState() {
    emit(KonfirmasiDiterimaPklInitial());
  }

  Future<void> konfirmasiDiterimaPkl(
    String idPengajuan,
    String konfirmasiNamaPembimbing,
    String konfirmasiNikPembimbing,
  ) async {
    try {
      emit(KonfirmasiDiterimaPklLoading());
      final response = await _apiService.konfirmasiDiterimaPkl(idPengajuan, konfirmasiNamaPembimbing, konfirmasiNikPembimbing);
      emit(KonfirmasiDiterimaPklSuccess(konfirmasiDiterimaPkl: response));
    } catch (e) {
      emit(KonfirmasiDiterimaPklError(message: e.toString()));
    }
  }

  void resetForm() {
    pengajuanController.clear();
    namaPembimbingController.clear();
    nikPembimbingController.clear();
  }
}
