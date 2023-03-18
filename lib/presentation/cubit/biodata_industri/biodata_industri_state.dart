part of 'biodata_industri_cubit.dart';

abstract class BiodataIndustriState extends Equatable {
  const BiodataIndustriState();

  @override
  List<Object> get props => [];
}

class BiodataIndustriInitial extends BiodataIndustriState {}

class BiodataIndustriLoading extends BiodataIndustriState {}

class BiodataIndustriLoaded extends BiodataIndustriState {
  final BiodataIndustri biodataIndustri;

  const BiodataIndustriLoaded({required this.biodataIndustri});
}

class BiodataIndustriNoConnection extends BiodataIndustriState {
  final String message;

  const BiodataIndustriNoConnection({required this.message});
}

class BiodataIndustriNoData extends BiodataIndustriState {
  final String message;

  const BiodataIndustriNoData({required this.message});
}

class BiodataIndustriError extends BiodataIndustriState {
  final String message;

  const BiodataIndustriError({required this.message});
}