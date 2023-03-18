part of 'tambah_jurnal_kegiatan_cubit.dart';

abstract class TambahJurnalKegiatanState extends Equatable {
  const TambahJurnalKegiatanState();

  @override
  List<Object> get props => [];
}

class TambahJurnalKegiatanInitial extends TambahJurnalKegiatanState {}

class TambahJurnalKegiatanLoading extends TambahJurnalKegiatanState {}

class TambahJurnalKegiatanSuccess extends TambahJurnalKegiatanState {
  final TambahJurnalKegiatan tambahJurnalKegiatan;

  const TambahJurnalKegiatanSuccess({required this.tambahJurnalKegiatan});

  @override
  List<Object> get props => [tambahJurnalKegiatan];
}

class TambahJurnalKegiatanError extends TambahJurnalKegiatanState {
  final String message;

  const TambahJurnalKegiatanError({required this.message});

  @override
  List<Object> get props => [message];
}
