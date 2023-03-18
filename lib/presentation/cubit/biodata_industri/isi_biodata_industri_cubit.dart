import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/isi_biodata_industri_model.dart';

part 'isi_biodata_industri_state.dart';

class IsiBiodataIndustriCubit extends Cubit<IsiBiodataIndustriState> {
  final ApiService _apiService = ApiService();

  final namaIndustriController = TextEditingController();
  final namaPimpinanController = TextEditingController();
  final alamatKantorController = TextEditingController();
  final noTelpFaxController = TextEditingController();
  final contactPersonController = TextEditingController();
  final bidangUsahaJasaController = TextEditingController();
  final spesialisasiProduksiJasaController = TextEditingController();
  final kapasitasProduksiController = TextEditingController();
  final jangkauanPemasaranController = TextEditingController();
  final jumlahTenagaKerjaSdController = TextEditingController();
  final jumlahTenagaKerjaSltpController = TextEditingController();
  final jumlahTenagaKerjaSltaController = TextEditingController();
  final jumlahTenagaKerjaSmkController = TextEditingController();
  final jumlahTenagaKerjaSarjanaMudaController = TextEditingController();
  final jumlahTenagaKerjaSarjanaMagisterController = TextEditingController();
  final jumlahTenagaKerjaSarjanaDoktorController = TextEditingController();

  IsiBiodataIndustriCubit() : super(IsiBiodataIndustriInitial());

  void resetState() {
    emit(IsiBiodataIndustriInitial());
  }

  Future<void> addBiodataIndustri(
    String namaIndustri,
    String namaPimpinan,
    String alamatKantor,
    String noTelpFax,
    String contactPerson,
    String bidangUsahaJasa,
    String spesialisasiProduksiJasa,
    String kapasitasProduksi,
    String jangkauanPemasaran,
    String jumlahTenagaKerjaSd,
    String jumlahTenagaKerjaSltp,
    String jumlahTenagaKerjaSlta,
    String jumlahTenagaKerjaSmk,
    String jumlahTenagaKerjaSarjanaMuda,
    String jumlahTenagaKerjaSarjanaMagister,
    String jumlahTenagaKerjaSarjanaDoktor,
  ) async {
    try {
      emit(IsiBiodataIndustriLoading());
      final response = await _apiService.addBiodataIndustri(
        namaIndustri,
        namaPimpinan,
        alamatKantor,
        noTelpFax,
        contactPerson,
        bidangUsahaJasa,
        spesialisasiProduksiJasa,
        kapasitasProduksi,
        jangkauanPemasaran,
        jumlahTenagaKerjaSd,
        jumlahTenagaKerjaSltp,
        jumlahTenagaKerjaSlta,
        jumlahTenagaKerjaSmk,
        jumlahTenagaKerjaSarjanaMuda,
        jumlahTenagaKerjaSarjanaMagister,
        jumlahTenagaKerjaSarjanaDoktor,
      );
      emit(IsiBiodataIndustriSuccess(isiBiodataIndustri: response));
    } catch (e) {
      emit(IsiBiodataIndustriError(message: e.toString()));
    }
  }

  void resetForm() {
    namaIndustriController.clear();
    namaPimpinanController.clear();
    alamatKantorController.clear();
    noTelpFaxController.clear();
    contactPersonController.clear();
    bidangUsahaJasaController.clear();
    spesialisasiProduksiJasaController.clear();
    kapasitasProduksiController.clear();
    jangkauanPemasaranController.clear();
    jumlahTenagaKerjaSdController.clear();
    jumlahTenagaKerjaSltpController.clear();
    jumlahTenagaKerjaSltaController.clear();
    jumlahTenagaKerjaSmkController.clear();
    jumlahTenagaKerjaSarjanaMudaController.clear();
    jumlahTenagaKerjaSarjanaMagisterController.clear();
    jumlahTenagaKerjaSarjanaDoktorController.clear();
  }
}
