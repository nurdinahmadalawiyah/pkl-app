part of 'detail_jurnal_kegiatan_cubit.dart';

abstract class DetailJurnalKegiatanState extends Equatable {
  const DetailJurnalKegiatanState();

  @override
  List<Object> get props => [];
}

class DetailJurnalKegiatanInitial extends DetailJurnalKegiatanState {}

class DetailJurnalKegiatanLoading extends DetailJurnalKegiatanState {}

class DetailJurnalKegiatanLoaded extends DetailJurnalKegiatanState {
  final JurnalKegiatan jurnalKegiatan;

  const DetailJurnalKegiatanLoaded({required this.jurnalKegiatan});
}

class DetailJurnalKegiatanNoData extends DetailJurnalKegiatanState {
  final String message;

  const DetailJurnalKegiatanNoData({required this.message});
}

class DetailJurnalKegiatanNoConnection extends DetailJurnalKegiatanState {
  final String message;

  const DetailJurnalKegiatanNoConnection({required this.message});
}

class DetailJurnalKegiatanError extends DetailJurnalKegiatanState {
  final String message;

  const DetailJurnalKegiatanError({required this.message});
}