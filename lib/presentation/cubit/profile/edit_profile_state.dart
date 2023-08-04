part of 'edit_profile_cubit.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoadingState extends EditProfileState {}

class EditProfileSuccessState extends EditProfileState {
  final String editProfile;

  const EditProfileSuccessState({required this.editProfile});

}

class EditProfileErrorState extends EditProfileState {
  final String message;

  const EditProfileErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
