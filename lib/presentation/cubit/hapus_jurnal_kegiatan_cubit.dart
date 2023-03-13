import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/hapus_jurnal_kegiatan_model.dart';

part 'hapus_jurnal_kegiatan_state.dart';

class HapusJurnalKegiatanCubit extends Cubit<HapusJurnalKegiatanState> {
  final ApiService apiService = ApiService();
  
  HapusJurnalKegiatanCubit() : super(HapusJurnalKegiatanInitial());

    void resetState() {
    emit(HapusJurnalKegiatanInitial());
  }

  Future<void> deleteJurnalKegiatan(
    String idJurnalKegiatan,
  ) async {
    try {
      emit(HapusJurnalKegiatanInitial());
      final response = await apiService.deleteJurnalKegiatan(idJurnalKegiatan);
      emit(HapusJurnalKegiatanSuccess(hapusJurnalKegiatan: response));
    } catch (e) {
      emit(HapusJurnalKegiatanError(message: e.toString()));
    }
  }
}
