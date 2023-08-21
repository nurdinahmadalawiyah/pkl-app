part of 'detail_catatan_khusus_cubit.dart';

abstract class DetailCatatanKhususState extends Equatable {
  const DetailCatatanKhususState();

  @override
  List<Object> get props => [];
}

class DetailCatatanKhususInitial extends DetailCatatanKhususState {}

class DetailCatatanKhususLoading extends DetailCatatanKhususState {}

class DetailCatatanKhususLoaded extends DetailCatatanKhususState {
  final DetailCatatanKhusus catatanKhusus;

  const DetailCatatanKhususLoaded({required this.catatanKhusus});
}

class DetailCatatanKhususNoConnection extends DetailCatatanKhususState {
  final String message;

  const DetailCatatanKhususNoConnection({required this.message});
}

class DetailCatatanKhususNoData extends DetailCatatanKhususState {
  final String message;

  const DetailCatatanKhususNoData({required this.message});
}

class DetailCatatanKhususError extends DetailCatatanKhususState {
  final String message;

  const DetailCatatanKhususError({required this.message});
}