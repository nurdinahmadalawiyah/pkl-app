part of 'catatan_khusus_cubit.dart';

abstract class CatatanKhususState extends Equatable {
  const CatatanKhususState();

  @override
  List<Object> get props => [];
}

class CatatanKhususInitial extends CatatanKhususState {}

class CatatanKhususLoading extends CatatanKhususState {}

class CatatanKhususLoaded extends CatatanKhususState {
  final CatatanKhusus catatanKhusus;

  const CatatanKhususLoaded({required this.catatanKhusus});
}

class CatatanKhususNoConnection extends CatatanKhususState {
  final String message;

  const CatatanKhususNoConnection({required this.message});
}

class CatatanKhususNoData extends CatatanKhususState {
  final String message;

  const CatatanKhususNoData({required this.message});
}

class CatatanKhususError extends CatatanKhususState {
  final String message;

  const CatatanKhususError({required this.message});
}
