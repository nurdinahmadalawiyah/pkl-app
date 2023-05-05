part of 'hapus_biodata_industri_cubit.dart';

abstract class HapusBiodataIndustriState extends Equatable {
  const HapusBiodataIndustriState();

  @override
  List<Object> get props => [];
}

class HapusBiodataIndustriInitial extends HapusBiodataIndustriState {}

class HapusBiodataIndustriLoading extends HapusBiodataIndustriState {}

class HapusBiodataIndustriSuccess extends HapusBiodataIndustriState {
  final HapusBiodataIndustri hapusBiodataIndustri;

  const HapusBiodataIndustriSuccess({required this.hapusBiodataIndustri});
}

class HapusBiodataIndustriError extends HapusBiodataIndustriState {
  final String message;

  const HapusBiodataIndustriError({required this.message});
}


