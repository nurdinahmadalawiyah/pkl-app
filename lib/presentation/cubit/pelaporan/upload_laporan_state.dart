part of 'upload_laporan_cubit.dart';

abstract class UploadLaporanState extends Equatable {
  const UploadLaporanState();

  @override
  List<Object> get props => [];
}

class UploadLaporanInitial extends UploadLaporanState {}

class UploadLaporanLoading extends UploadLaporanState {}

class UploadLaporanSuccess extends UploadLaporanState {
  final UploadLaporan uploadLaporan;

  const UploadLaporanSuccess({required this.uploadLaporan});

  @override
  List<Object> get props => [uploadLaporan];
}

class UploadLaporanError extends UploadLaporanState {
  final String message;

  const UploadLaporanError({required this.message});

  @override
  List<Object> get props => [message];
}

