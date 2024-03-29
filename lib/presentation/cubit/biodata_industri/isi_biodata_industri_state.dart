part of 'isi_biodata_industri_cubit.dart';

abstract class IsiBiodataIndustriState extends Equatable {
  const IsiBiodataIndustriState();

  @override
  List<Object> get props => [];
}

class IsiBiodataIndustriInitial extends IsiBiodataIndustriState {}

class IsiBiodataIndustriLoading extends IsiBiodataIndustriState {}

class IsiBiodataIndustriSuccess extends IsiBiodataIndustriState {
  final String isiBiodataIndustri;

  const IsiBiodataIndustriSuccess({required this.isiBiodataIndustri});
}

class IsiBiodataIndustriError extends IsiBiodataIndustriState {
  final String message;

  const IsiBiodataIndustriError({required this.message});

    @override
  List<Object> get props => [message];
}

