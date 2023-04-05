part of 'list_nilai_pkl_cubit.dart';

abstract class ListNilaiPklState extends Equatable {
  const ListNilaiPklState();

  @override
  List<Object> get props => [];
}

class ListNilaiPklInitial extends ListNilaiPklState {}

abstract class NilaiPklState extends Equatable {
  const NilaiPklState();

  @override
  List<Object> get props => [];
}

class ListNilaiPklLoading extends ListNilaiPklState {}

class ListNilaiPklLoaded extends ListNilaiPklState {
  final ListMahasiswa listMahasiswa;

  const ListNilaiPklLoaded({required this.listMahasiswa});
}

class ListNilaiPklNoConnection extends ListNilaiPklState {
  final String message;

  const ListNilaiPklNoConnection({required this.message});
}

class ListNilaiPklNoData extends ListNilaiPklState {
  final String message;

  const ListNilaiPklNoData({required this.message});
}

class ListNilaiPklError extends ListNilaiPklState {
  final String message;

  const ListNilaiPklError({required this.message});
}
