part of 'lowongan_pkl_cubit.dart';

abstract class LowonganPklState extends Equatable {
  const LowonganPklState();

  @override
  List<Object> get props => [];
}

class LowonganPklInitial extends LowonganPklState {}

class LowonganPklLoading extends LowonganPklState {}

class LowonganPklLoaded extends LowonganPklState {
  final LowonganPkl lowonganPkl;

  const LowonganPklLoaded({required this.lowonganPkl});
}

class LowonganPklNoData extends LowonganPklState {
  final String message;

  const LowonganPklNoData({required this.message});
}

class LowonganPklNoConnections extends LowonganPklState {
  final String message;

  const LowonganPklNoConnections({required this.message});
}

class LowonganPklError extends LowonganPklState {
  final String message;

  const LowonganPklError({required this.message});
}
