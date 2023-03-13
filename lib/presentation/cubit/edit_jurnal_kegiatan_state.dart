part of 'edit_jurnal_kegiatan_cubit.dart';

abstract class EditJurnalKegiatanState extends Equatable {
  const EditJurnalKegiatanState();

  @override
  List<Object> get props => [];
}

class EditJurnalKegiatanInitial extends EditJurnalKegiatanState {}

class EditJurnalKegiatanLoading extends EditJurnalKegiatanState {}

class EditJurnalKegiatanSuccess extends EditJurnalKegiatanState {
  final TambahJurnalKegiatan editJurnalKegiatan;

  const EditJurnalKegiatanSuccess({required this.editJurnalKegiatan});

  @override
  List<Object> get props => [editJurnalKegiatan];
}

class EditJurnalKegiatanError extends EditJurnalKegiatanState {
  final String message;

  const EditJurnalKegiatanError({required this.message});

  @override
  List<Object> get props => [message];
}

