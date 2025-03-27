import 'package:swafa_app_frontend/features/profile/domain/entities/user_profile_entity.dart';
import 'package:swafa_app_frontend/features/profile/domain/repositories/profile_repository.dart';

class FetchProfileUseCase {
  final ProfileRepository profileRepository;

  FetchProfileUseCase({required this.profileRepository});

  Future<UserProfileEntity> call() {
    return profileRepository.fetchProfile();
  }
}