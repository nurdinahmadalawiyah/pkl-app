part of 'save_player_id_cubit.dart';

abstract class SavePlayerIdState extends Equatable {
  const SavePlayerIdState();

  @override
  List<Object> get props => [];
}

class SavePlayerIdInitial extends SavePlayerIdState {}

class SavePlayerIdLoading extends SavePlayerIdState {}

class SavePlayerIdSuccess extends SavePlayerIdState {
  final String message;

  const SavePlayerIdSuccess({required this.message});
}

class SavePlayerIdError extends SavePlayerIdState {
  final String message;

  const SavePlayerIdError({required this.message});
}