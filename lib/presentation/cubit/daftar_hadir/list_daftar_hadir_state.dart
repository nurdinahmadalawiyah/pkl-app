part of 'list_daftar_hadir_cubit.dart';

abstract class ListDaftarHadirState extends Equatable {
  const ListDaftarHadirState();

  @override
  List<Object> get props => [];
}

class ListDaftarHadirInitial extends ListDaftarHadirState {}

class ListDaftarHadirLoading extends ListDaftarHadirState {}

class ListDaftarHadirLoaded extends ListDaftarHadirState {
  final ListMahasiswa listMahasiswa;

  const ListDaftarHadirLoaded({required this.listMahasiswa});
}

class ListDaftarHadirNoData extends ListDaftarHadirState {
  final String message;

  const ListDaftarHadirNoData({required this.message});
}

class ListDaftarHadirNoConnection extends ListDaftarHadirState {
  final String message;

  const ListDaftarHadirNoConnection({required this.message});
}

class ListDaftarHadirError extends ListDaftarHadirState {
  final String message;

  const ListDaftarHadirError({required this.message});
}
