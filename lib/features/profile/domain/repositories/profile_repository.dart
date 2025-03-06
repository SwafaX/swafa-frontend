import 'package:swafa_app_frontend/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> fetchProfile();
}