import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';

part 'hapus_catatan_khusus_state.dart';

class HapusCatatanKhususCubit extends Cubit<HapusCatatanKhususState> {
  final ApiService apiService = ApiService();

  HapusCatatanKhususCubit() : super(HapusCatatanKhususInitial());

  void resetState() {
    emit(HapusCatatanKhususInitial());
  }

  Future<void> deleteCatatanKhusus() async {
    try {
      emit(HapusCatatanKhususInitial());
      final response = await apiService.deleteCatatanKhusus();
      emit(const HapusCatatanKhususSuccess(message: "success"));
    } catch (e) {
      emit(HapusCatatanKhususError(message: e.toString()));
    }
  }
}
