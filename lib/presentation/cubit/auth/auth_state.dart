part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthRegisterLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  final Login login;

  const AuthLoginSuccess({required this.login});
}

class AuthRegisterSuccess extends AuthState {
  final Register register;

  const AuthRegisterSuccess({required this.register});
}

class AuthLogoutSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
  
  @override
  List<Object> get props => [];
}

class AuthRegisterFailure extends AuthState {
  final String message;

  const AuthRegisterFailure({required this.message});
  
  @override
  List<Object> get props => [];
}

