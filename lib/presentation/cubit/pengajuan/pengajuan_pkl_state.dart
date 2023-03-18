part of 'pengajuan_pkl_cubit.dart';

abstract class PengajuanPklState extends Equatable {
  const PengajuanPklState();

  @override
  List<Object> get props => [];
}

class PengajuanPklInitial extends PengajuanPklState {}

class PengajuanPklLoadingState extends PengajuanPklState {}

class PengajuanPklSuccessState extends PengajuanPklState {
  final PengajuanPkl pengajuanPkl;

  const PengajuanPklSuccessState({required this.pengajuanPkl});

  @override
  List<Object> get props => [pengajuanPkl];
}

class PengajuanPklErrorState extends PengajuanPklState {
  final String message;

  const PengajuanPklErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
