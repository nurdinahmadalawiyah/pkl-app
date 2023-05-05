import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/hapus_biodata_industri.dart';

part 'hapus_biodata_industri_state.dart';

class HapusBiodataIndustriCubit extends Cubit<HapusBiodataIndustriState> {
  final ApiService apiService = ApiService();
  
  HapusBiodataIndustriCubit() : super(HapusBiodataIndustriInitial());

  void resetState() {
    emit(HapusBiodataIndustriInitial());
  }

  Future<void> deleteBiodataIndustri() async {
    try {
      emit(HapusBiodataIndustriInitial());
      final response = await apiService.deleteBiodataIndustri();
      emit(HapusBiodataIndustriSuccess(hapusBiodataIndustri: response));
    } catch (e) {
      emit(HapusBiodataIndustriError(message: e.toString()));
    }
  }
}
