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

  JurnalKegiatanLoaded({required this.jurnalKegiatan});
}

class JurnalKegiatanNoData extends JurnalKegiatanState {
  final String message;

  JurnalKegiatanNoData({required this.message});
}

class JurnalKegiatanNoConnection extends JurnalKegiatanState {
  final String message;

  JurnalKegiatanNoConnection({required this.message});
}

class JurnalKegiatanError extends JurnalKegiatanState {
  final String message;

  JurnalKegiatanError({required this.message});
}
