part of 'detail_nilai_cubit.dart';

abstract class DetailNilaiState extends Equatable {
  const DetailNilaiState();

  @override
  List<Object> get props => [];
}

class DetailNilaiInitial extends DetailNilaiState {}

class DetailNilaiLoading extends DetailNilaiState {}

class DetailNilaiLoaded extends DetailNilaiState {
  final DetailNilai detailNilai;

  const DetailNilaiLoaded({required this.detailNilai});
}

class DetailNilaiNoConnection extends DetailNilaiState {
  final String message;

  const DetailNilaiNoConnection({required this.message});
}

class DetailNilaiNoData extends DetailNilaiState {
  final String message;

  const DetailNilaiNoData({required this.message});
}

class DetailNilaiError extends DetailNilaiState {
  final String message;

  const DetailNilaiError({required this.message});
}
