part of 'list_biodata_industri_cubit.dart';

abstract class ListBiodataIndustriState extends Equatable {
  const ListBiodataIndustriState();

  @override
  List<Object> get props => [];
}

class ListBiodataIndustriInitial extends ListBiodataIndustriState {}

class ListBiodataIndustriLoading extends ListBiodataIndustriState {}

class ListBiodataIndustriLoaded extends ListBiodataIndustriState {
  final ListMahasiswa listMahasiswa;

  const ListBiodataIndustriLoaded({required this.listMahasiswa});
}

class ListBiodataIndustriNoConnection extends ListBiodataIndustriState {
  final String message;

  const ListBiodataIndustriNoConnection({required this.message});
}

class ListBiodataIndustriNoData extends ListBiodataIndustriState {
  final String message;

  const ListBiodataIndustriNoData({required this.message});
}

class ListBiodataIndustriError extends ListBiodataIndustriState {
  final String message;

  const ListBiodataIndustriError({required this.message});
}
