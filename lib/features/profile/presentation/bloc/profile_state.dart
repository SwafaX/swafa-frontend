import 'package:swafa_app_frontend/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final ProfileEntity profile;

  ProfileLoadedState({required this.profile});
}

class ProfileErrorState extends ProfileState {
  final String message;
  
  ProfileErrorState({required this.message});
}