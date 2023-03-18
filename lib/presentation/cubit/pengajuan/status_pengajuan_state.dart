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

  const StatusPengajuanLoaded({required this.statusPengajuanPkl});
}

class StatusPengajuanNoData extends StatusPengajuanState {
  final String message;

  const StatusPengajuanNoData({required this.message});
}

class StatusPengajuanNoConnection extends StatusPengajuanState {
  final String message;

  const StatusPengajuanNoConnection({required this.message});
}

class StatusPengajuanError extends StatusPengajuanState {
  final String message;

  const StatusPengajuanError({required this.message});
}
