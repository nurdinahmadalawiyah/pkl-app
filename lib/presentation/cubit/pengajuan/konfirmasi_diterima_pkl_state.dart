part of 'konfirmasi_diterima_pkl_cubit.dart';

abstract class KonfirmasiDiterimaPklState extends Equatable {
  const KonfirmasiDiterimaPklState();

  @override
  List<Object> get props => [];
}

class KonfirmasiDiterimaPklInitial extends KonfirmasiDiterimaPklState {}

class KonfirmasiDiterimaPklLoading extends KonfirmasiDiterimaPklState {}

class KonfirmasiDiterimaPklSuccess extends KonfirmasiDiterimaPklState {
  final String konfirmasiDiterimaPkl;

  const KonfirmasiDiterimaPklSuccess({required this.konfirmasiDiterimaPkl});
}

class KonfirmasiDiterimaPklError extends KonfirmasiDiterimaPklState {
  final String message;

  const KonfirmasiDiterimaPklError({required this.message});

  @override
  List<Object> get props => [message];
}
