part of 'hapus_daftar_hadir_cubit.dart';

abstract class HapusDaftarHadirState extends Equatable {
  const HapusDaftarHadirState();

  @override
  List<Object> get props => [];
}

class HapusDaftarHadirInitial extends HapusDaftarHadirState {}

class HapusDaftarHadirLoading extends HapusDaftarHadirState {}

class HapusDaftarHadirSuccess extends HapusDaftarHadirState {
  final HapusDaftarHadir hapusDaftarHadir;

  const HapusDaftarHadirSuccess({required this.hapusDaftarHadir});

  @override
  List<Object> get props => [hapusDaftarHadir];
}

class HapusDaftarHadirError extends HapusDaftarHadirState {
  final String message;

  const HapusDaftarHadirError({required this.message});

  @override
  List<Object> get props => [message];
}
