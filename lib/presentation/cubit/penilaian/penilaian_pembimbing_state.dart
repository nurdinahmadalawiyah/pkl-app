part of 'penilaian_pembimbing_cubit.dart';

abstract class PenilaianPembimbingState extends Equatable {
  const PenilaianPembimbingState();

  @override
  List<Object> get props => [];
}

class PenilaianPembimbingInitial extends PenilaianPembimbingState {}

class PenilaianPembimbingLoading extends PenilaianPembimbingState {}

class PenilaianPembimbingSuccess extends PenilaianPembimbingState {
  final PenilaianPembimbing penilaianPembimbing;

  const PenilaianPembimbingSuccess({required this.penilaianPembimbing});
}

class PenilaianPembimbingError extends PenilaianPembimbingState {
  final String message;

  const PenilaianPembimbingError({required this.message});
}
