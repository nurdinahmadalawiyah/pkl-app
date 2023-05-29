import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';

part 'penilaian_pembimbing_state.dart';

class PenilaianPembimbingCubit extends Cubit<PenilaianPembimbingState> {
  final ApiService _apiService = ApiService();

  PenilaianPembimbingCubit() : super(PenilaianPembimbingInitial());

  void resetState() {
    emit(PenilaianPembimbingInitial());
  }

  Future<void> penilaianPembimbing(
    int idMahasiswa,
    int idTempatPkl,
    String integritas,
    String profesionalitas,
    String bahasaInggris,
    String teknologiInformasi,
    String komunikasi,
    String kerjaSama,
    String organisasi,
  ) async {
    emit(PenilaianPembimbingLoading());
    try {
      final response = await _apiService.penilaianPembimbing(
        idMahasiswa,
        idTempatPkl,
        integritas,
        profesionalitas,
        bahasaInggris,
        teknologiInformasi,
        komunikasi,
        kerjaSama,
        organisasi,
      );
      emit(const PenilaianPembimbingSuccess(penilaianPembimbing: "Success"));
    } catch (e) {
      emit(PenilaianPembimbingError(message: e.toString()));
    }
  }
}
