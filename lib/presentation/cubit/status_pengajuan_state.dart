part of 'status_pengajuan_cubit.dart';

abstract class StatusPengajuanState extends Equatable {
  const StatusPengajuanState();

  @override
  List<Object> get props => [];

  map(PopupMenuItem<String> Function(dynamic item) param0) {}
}

class StatusPengajuanInitial extends StatusPengajuanState {}

class StatusPengajuanLoading extends StatusPengajuanState {}

class StatusPengajuanLoaded extends StatusPengajuanState {
  final StatusPengajuanPkl statusPengajuanPkl;

  StatusPengajuanLoaded({required this.statusPengajuanPkl});
}
class StatusPengajuanNoData extends StatusPengajuanState {
  final String message;

  StatusPengajuanNoData({required this.message});
}

class StatusPengajuanNoConnection extends StatusPengajuanState {
  final String message;

  StatusPengajuanNoConnection({required this.message});
}

class StatusPengajuanError extends StatusPengajuanState {
  final String message;

  StatusPengajuanError({required this.message});
}
