import 'package:swafa_app_frontend/features/profile/domain/entities/profile_entity.dart';
import 'package:swafa_app_frontend/features/profile/domain/repositories/profile_repository.dart';

class FetchProfileUseCase {
  final ProfileRepository profileRepository;

  FetchProfileUseCase({required this.profileRepository});

  Future<ProfileEntity> call() {
    return profileRepository.fetchProfile();
  }
}