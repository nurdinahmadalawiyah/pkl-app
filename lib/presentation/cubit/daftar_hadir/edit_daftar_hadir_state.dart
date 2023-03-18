part of 'edit_daftar_hadir_cubit.dart';

abstract class EditDaftarHadirState extends Equatable {
  const EditDaftarHadirState();

  @override
  List<Object> get props => [];
}

class EditDaftarHadirInitial extends EditDaftarHadirState {}

class EditDaftarHadirLoading extends EditDaftarHadirState {}

class EditDaftarHadirSuccess extends EditDaftarHadirState {
  final TambahDaftarHadir editDaftarHadir;

  const EditDaftarHadirSuccess({required this.editDaftarHadir});

  @override
  List<Object> get props => [editDaftarHadir];
}

class EditDaftarHadirError extends EditDaftarHadirState {
  final String message;

  const EditDaftarHadirError({required this.message});

  @override
  List<Object> get props => [message];
}
