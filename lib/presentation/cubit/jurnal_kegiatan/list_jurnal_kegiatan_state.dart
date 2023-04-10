part of 'list_jurnal_kegiatan_cubit.dart';

abstract class ListJurnalKegiatanState extends Equatable {
  const ListJurnalKegiatanState();

  @override
  List<Object> get props => [];
}

class ListJurnalKegiatanInitial extends ListJurnalKegiatanState {}

class ListJurnalKegiatanLoading extends ListJurnalKegiatanState {}

class ListJurnalKegiatanLoaded extends ListJurnalKegiatanState {
  final ListMahasiswa listMahasiswa;

  const ListJurnalKegiatanLoaded({required this.listMahasiswa});
}

class ListJurnalKegiatanNoConnection extends ListJurnalKegiatanState {
  final String message;

  const ListJurnalKegiatanNoConnection({required this.message});
}

class ListJurnalKegiatanNoData extends ListJurnalKegiatanState {
  final String message;

  const ListJurnalKegiatanNoData({required this.message});
}

class ListJurnalKegiatanError extends ListJurnalKegiatanState {
  final String message;

  const ListJurnalKegiatanError({required this.message});
}
