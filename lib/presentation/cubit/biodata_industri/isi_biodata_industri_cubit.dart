import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';

part 'isi_biodata_industri_state.dart';

class IsiBiodataIndustriCubit extends Cubit<IsiBiodataIndustriState> {
  final ApiService _apiService = ApiService();

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
    String jumlahTenagaKerjaSmea,
    String jumlahTenagaKerjaSmkk,
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
        jumlahTenagaKerjaSmea,
        jumlahTenagaKerjaSmkk,
        jumlahTenagaKerjaSarjanaMuda,
        jumlahTenagaKerjaSarjanaMagister,
        jumlahTenagaKerjaSarjanaDoktor,
      );
      emit(const IsiBiodataIndustriSuccess(isiBiodataIndustri: "success"));
    } catch (e) {
      emit(IsiBiodataIndustriError(message: e.toString()));
    }
  }
}
