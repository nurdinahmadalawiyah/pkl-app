part of 'data_pembimbing_pkl_cubit.dart';

abstract class DataPembimbingPklState extends Equatable {
  const DataPembimbingPklState();

  @override
  List<Object> get props => [];
}

class DataPembimbingPklInitial extends DataPembimbingPklState {}

class DataPembimbingPklLoading extends DataPembimbingPklState {}

class DataPembimbingPklLoaded extends DataPembimbingPklState {
  final DataPembimbingPkl dataPembimbingPkl;

  const DataPembimbingPklLoaded({required this.dataPembimbingPkl});
}

class DataPembimbingPklNoData extends DataPembimbingPklState {
  final String message;

  const DataPembimbingPklNoData({required this.message});
}

class DataPembimbingPklNoConnection extends DataPembimbingPklState {
  final String message;

  const DataPembimbingPklNoConnection({required this.message});
}

class DataPembimbingPklError extends DataPembimbingPklState {
  final String message;

  const DataPembimbingPklError({required this.message});
}
