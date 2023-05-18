part of 'upload_laporan_cubit.dart';

class UploadLaporanState extends Equatable {
  final File? selectedFile;

  const UploadLaporanState({this.selectedFile});

   UploadLaporanState copyWith({
    File? selectedFile,
  }) {
    return UploadLaporanState(
      selectedFile: selectedFile ?? this.selectedFile,
    );
  }


  @override
  List<Object?> get props => [selectedFile];
}

class UploadLaporanInitial extends UploadLaporanState {}

class UploadLaporanLoading extends UploadLaporanState {}

class UploadLaporanSuccess extends UploadLaporanState {
  final UploadLaporan laporan;

  const UploadLaporanSuccess({required this.laporan});
}

class LaporanLoaded extends UploadLaporanState {
  final UploadLaporan laporan;

  const LaporanLoaded({required this.laporan});
}

class LaporanNoConnection extends UploadLaporanState {
  final String message;

  const LaporanNoConnection({required this.message});
}

class UploadLaporanError extends UploadLaporanState {
  final String message;

  const UploadLaporanError({required this.message});
}


class LaporanError extends UploadLaporanState {
  final String message;

  const LaporanError({required this.message});
}


class HapusLaporanSuccess extends UploadLaporanState {
  final CancelLaporan hapusLaporan;

  const HapusLaporanSuccess({required this.hapusLaporan});

  @override
  List<Object> get props => [hapusLaporan];
}

class HapusLaporanError extends UploadLaporanState {
  final String message;

  const HapusLaporanError({required this.message});

  @override
  List<Object> get props => [message];
}
