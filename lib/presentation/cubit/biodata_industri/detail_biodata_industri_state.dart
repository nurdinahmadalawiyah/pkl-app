part of 'detail_biodata_industri_cubit.dart';

abstract class DetailBiodataIndustriState extends Equatable {
  const DetailBiodataIndustriState();

  @override
  List<Object> get props => [];
}

class DetailBiodataIndustriInitial extends DetailBiodataIndustriState {}

class DetailBiodataIndustriLoading extends DetailBiodataIndustriState {}

class DetailBiodataIndustriLoaded extends DetailBiodataIndustriState {
  final DetailBiodataIndustri biodataIndustri;

  const DetailBiodataIndustriLoaded({required this.biodataIndustri});
}

class DetailBiodataIndustriNoConnection extends DetailBiodataIndustriState {
  final String message;

  const DetailBiodataIndustriNoConnection({required this.message});
}

class DetailBiodataIndustriNoData extends DetailBiodataIndustriState {
  final String message;

  const DetailBiodataIndustriNoData({required this.message});
}

class DetailBiodataIndustriError extends DetailBiodataIndustriState {
  final String message;

  const DetailBiodataIndustriError({required this.message});
}