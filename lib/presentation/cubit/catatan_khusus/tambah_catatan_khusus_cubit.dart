import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';

part 'tambah_catatan_khusus_state.dart';

class TambahCatatanKhususCubit extends Cubit<TambahCatatanKhususState> {
  final ApiService _apiService = ApiService();

  TambahCatatanKhususCubit() : super(TambahCatatanKhususInitial());

  void resetState() {
    emit(TambahCatatanKhususInitial());
  }

  Future<void> addCatatanKhusus(String catatan) async {
    try {
      emit(TambahCatatanKhususLoading());
      final response = await _apiService.addCatatanKhusus(catatan);
      emit(const TambahCatatanKhususSuccess(tambahCatatanKhusus: "success"));
    } catch (e) {
      emit(TambahCatatanKhususError(message: e.toString()));
    }
  }
}
