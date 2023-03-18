part of 'nilai_pkl_cubit.dart';

abstract class NilaiPklState extends Equatable {
  const NilaiPklState();

  @override
  List<Object> get props => [];
}

class NilaiPklInitial extends NilaiPklState {}

class NilaiPklLoading extends NilaiPklState {}

class NilaiPklLoaded extends NilaiPklState {
  final NilaiPkl nilaiPKL;

  const NilaiPklLoaded({required this.nilaiPKL});
}

class NilaiPklNoConnection extends NilaiPklState {
  final String message;

  const NilaiPklNoConnection({required this.message});
}

class NilaiPklNoData extends NilaiPklState {
  final String message;

  const NilaiPklNoData({required this.message});
}

class NilaiPklError extends NilaiPklState {
  final String message;

  const NilaiPklError({required this.message});
}
