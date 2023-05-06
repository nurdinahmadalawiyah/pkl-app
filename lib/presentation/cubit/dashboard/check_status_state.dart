part of 'check_status_cubit.dart';

abstract class CheckStatusState extends Equatable {
  const CheckStatusState();

  @override
  List<Object> get props => [];
}

class CheckStatusInitial extends CheckStatusState {}

class CheckStatusLoading extends CheckStatusState {}

class CheckStatusApprove extends CheckStatusState {}

class CheckStatusApproveWithConfirmed extends CheckStatusState {}

class CheckStatusWaiting extends CheckStatusState {}

class CheckStatusReject extends CheckStatusState {}

class CheckStatusError extends CheckStatusState {
  final String message;

  const CheckStatusError({required this.message});
}
