part of 'hapus_catatan_khusus_cubit.dart';

abstract class HapusCatatanKhususState extends Equatable {
  const HapusCatatanKhususState();

  @override
  List<Object> get props => [];
}

class HapusCatatanKhususInitial extends HapusCatatanKhususState {}

class HapusCatatanKhususLoading extends HapusCatatanKhususState {}

class HapusCatatanKhususSuccess extends HapusCatatanKhususState {
  final String message;

  const HapusCatatanKhususSuccess({required this.message});
}

class HapusCatatanKhususError extends HapusCatatanKhususState {
  final String message;

  const HapusCatatanKhususError({required this.message});
}
