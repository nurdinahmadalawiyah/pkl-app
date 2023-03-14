part of 'daftar_hadir_cubit.dart';

abstract class DaftarHadirState extends Equatable {
  const DaftarHadirState();

  @override
  List<Object> get props => [];
}

class DaftarHadirInitial extends DaftarHadirState {}

class DaftarHadirLoading extends DaftarHadirState {}

class DaftarHadirLoaded extends DaftarHadirState {
  final DaftarHadir daftarHadir;

  const DaftarHadirLoaded({required this.daftarHadir});
}

class DaftarHadirNoData extends DaftarHadirState {
  final String message;

  const DaftarHadirNoData({required this.message});
}

class DaftarHadirNoConnections extends DaftarHadirState {
  final String message;

  const DaftarHadirNoConnections({required this.message});
}

class DaftarHadirError extends DaftarHadirState {
  final String message;

  const DaftarHadirError({required this.message});
}
