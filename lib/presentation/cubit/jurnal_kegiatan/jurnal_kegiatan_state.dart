part of 'jurnal_kegiatan_cubit.dart';

abstract class JurnalKegiatanState extends Equatable {
  const JurnalKegiatanState();

  @override
  List<Object> get props => [];
}

class JurnalKegiatanInitial extends JurnalKegiatanState {}

class JurnalKegiatanLoading extends JurnalKegiatanState {}

class JurnalKegiatanLoaded extends JurnalKegiatanState {
  final JurnalKegiatan jurnalKegiatan;

  const JurnalKegiatanLoaded({required this.jurnalKegiatan});
}

class JurnalKegiatanNoData extends JurnalKegiatanState {
  final String message;

  const JurnalKegiatanNoData({required this.message});
}

class JurnalKegiatanNoConnection extends JurnalKegiatanState {
  final String message;

  const JurnalKegiatanNoConnection({required this.message});
}

class JurnalKegiatanError extends JurnalKegiatanState {
  final String message;

  const JurnalKegiatanError({required this.message});
}
