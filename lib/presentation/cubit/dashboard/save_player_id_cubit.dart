import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';

part 'save_player_id_state.dart';

class SavePlayerIdCubit extends Cubit<SavePlayerIdState> {
  final ApiService apiService = ApiService();

  SavePlayerIdCubit() : super(SavePlayerIdInitial());

  void resetState() {
    emit(SavePlayerIdInitial());
  }

  Future<void> savePlayerId(String notificationId) async {
    try {
      emit(SavePlayerIdLoading());
      await apiService.savePlayerId(notificationId);
      emit(const SavePlayerIdSuccess(message: "Player ID berhasil disimpan"));
    } catch (e) {
      emit(SavePlayerIdError(message: e.toString()));
    }
  }
}
