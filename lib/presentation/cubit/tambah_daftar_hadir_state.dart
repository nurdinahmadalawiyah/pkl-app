part of 'tambah_daftar_hadir_cubit.dart';

abstract class TambahDaftarHadirState extends Equatable {
  const TambahDaftarHadirState();

  @override
  List<Object> get props => [];
}

class TambahDaftarHadirInitial extends TambahDaftarHadirState {}

class TambahDaftarHadirLoading extends TambahDaftarHadirState {}

class TambahDaftarHadirSuccess extends TambahDaftarHadirState {
  final TambahDaftarHadir tambahDaftarHadir;

  const TambahDaftarHadirSuccess({required this.tambahDaftarHadir});
  
  @override
  List<Object> get props => [tambahDaftarHadir];
}

class TambahDaftarHadirError extends TambahDaftarHadirState {
  final String message;

  const TambahDaftarHadirError({required this.message});

  @override
  List<Object> get props => [message];
}
