import 'package:swafa_app_frontend/features/profile/domain/entities/user_profile_entity.dart';

abstract class ProfileRepository {
  Future<UserProfileEntity> fetchProfile();
}