part of 'detail_daftar_hadir_cubit.dart';

abstract class DetailDaftarHadirState extends Equatable {
  const DetailDaftarHadirState();

  @override
  List<Object> get props => [];
}

class DetailDaftarHadirInitial extends DetailDaftarHadirState {}

class DetailDaftarHadirLoading extends DetailDaftarHadirState {}

class DetailDaftarHadirLoaded extends DetailDaftarHadirState {
  final DetailDaftarHadir daftarHadir;

  const DetailDaftarHadirLoaded({required this.daftarHadir});
}

class DetailDaftarHadirNoData extends DetailDaftarHadirState {
  final String message;

  const DetailDaftarHadirNoData({required this.message});
}

class DetailDaftarHadirNoConnection extends DetailDaftarHadirState {
  final String message;

  const DetailDaftarHadirNoConnection({required this.message});
}

class DetailDaftarHadirError extends DetailDaftarHadirState {
  final String message;

  const DetailDaftarHadirError({required this.message});
}