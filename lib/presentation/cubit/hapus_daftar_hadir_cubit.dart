import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/hapus_daftar_hadir_model.dart';

part 'hapus_daftar_hadir_state.dart';

class HapusDaftarHadirCubit extends Cubit<HapusDaftarHadirState> {
  final ApiService apiService = ApiService();

  HapusDaftarHadirCubit() : super(HapusDaftarHadirInitial());

  void resetState() {
    emit(HapusDaftarHadirInitial());
  }

  Future<void> deleteDaftarHadir(String idDaftarHadir) async {
    try {
      emit(HapusDaftarHadirInitial());
      final response = await apiService.deleteDaftarHadir(idDaftarHadir);
      emit(HapusDaftarHadirSuccess(hapusDaftarHadir: response));
    } catch (e) {
      emit(HapusDaftarHadirError(message: e.toString()));
    }
  }
}
