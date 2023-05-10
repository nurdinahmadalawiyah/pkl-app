part of 'list_mahasiswa_cubit.dart';

abstract class ListMahasiswaState extends Equatable {
  const ListMahasiswaState();

  @override
  List<Object> get props => [];
}

class ListMahasiswaInitial extends ListMahasiswaState {}

class ListMahasiswaLoading extends ListMahasiswaState {}

class ListMahasiswaLoaded extends ListMahasiswaState {
  final ListMahasiswa listMahasiswa;

  const ListMahasiswaLoaded({required this.listMahasiswa});
}

class ListMahasiswaNoConnection extends ListMahasiswaState {
  final String message;

  const ListMahasiswaNoConnection({required this.message});
}

class ListMahasiswaNoData extends ListMahasiswaState {
  final String message;

  const ListMahasiswaNoData({required this.message});
}

class ListMahasiswaError extends ListMahasiswaState {
  final String message;

  const ListMahasiswaError({required this.message});
}

