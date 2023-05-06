import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';

part 'check_status_state.dart';

class CheckStatusCubit extends Cubit<CheckStatusState> {
  final ApiService apiService;

  CheckStatusCubit({required this.apiService}) : super(CheckStatusInitial()) {
    getCheckStatus();
  }

  void getCheckStatus() async {
    emit(CheckStatusLoading());
    try {
      final checkStatus = await apiService.getCheckStatus();
      if (checkStatus.data.status == 'disetujui' && checkStatus.data.telahKonfirmasi == 'true') {
        emit(CheckStatusApproveWithConfirmed());
      } else if (checkStatus.data.status == 'disetujui') {
        emit(CheckStatusApprove());
      } else if (checkStatus.data.status == 'menunggu') {
        emit(CheckStatusWaiting());
      } else if (checkStatus.data.status == 'ditolak') {
        emit(CheckStatusReject());
      }
    } catch (e) {
      emit(CheckStatusError(message: e.toString()));
    }
  }
}
