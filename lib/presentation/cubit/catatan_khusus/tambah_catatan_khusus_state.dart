part of 'tambah_catatan_khusus_cubit.dart';

abstract class TambahCatatanKhususState extends Equatable {
  const TambahCatatanKhususState();

  @override
  List<Object> get props => [];
}

class TambahCatatanKhususInitial extends TambahCatatanKhususState {}

class TambahCatatanKhususLoading extends TambahCatatanKhususState {}

class TambahCatatanKhususSuccess extends TambahCatatanKhususState {
  final String tambahCatatanKhusus;

  const TambahCatatanKhususSuccess({required this.tambahCatatanKhusus});
}

class TambahCatatanKhususError extends TambahCatatanKhususState {
  final String message;

  const TambahCatatanKhususError({required this.message});

    @override
  List<Object> get props => [message];
}

