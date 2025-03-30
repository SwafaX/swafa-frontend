import 'package:swafa_app_frontend/features/profile/domain/entities/item_profile_entity.dart';
import 'package:swafa_app_frontend/features/profile/domain/entities/user_profile_entity.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final UserProfileEntity profile;
  final List<ItemProfileEntity> items;

  ProfileLoadedState({required this.profile, required this.items});
}

class ProfileErrorState extends ProfileState {
  final String message;
  
  ProfileErrorState({required this.message});
}