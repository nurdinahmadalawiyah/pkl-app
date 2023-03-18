part of 'hapus_jurnal_kegiatan_cubit.dart';

abstract class HapusJurnalKegiatanState extends Equatable {
  const HapusJurnalKegiatanState();

  @override
  List<Object> get props => [];
}

class HapusJurnalKegiatanInitial extends HapusJurnalKegiatanState {}

class HapusJurnalKegiatanLoading extends HapusJurnalKegiatanState {}

class HapusJurnalKegiatanSuccess extends HapusJurnalKegiatanState {
  final HapusJurnalKegiatan hapusJurnalKegiatan;

  const HapusJurnalKegiatanSuccess({required this.hapusJurnalKegiatan});

  @override
  List<Object> get props => [hapusJurnalKegiatan];
}

class HapusJurnalKegiatanError extends HapusJurnalKegiatanState {
  final String message;

  const HapusJurnalKegiatanError({required this.message});

  @override
  List<Object> get props => [message];
}


