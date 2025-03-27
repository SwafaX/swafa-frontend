import 'package:swafa_app_frontend/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:swafa_app_frontend/features/profile/domain/entities/user_profile_entity.dart';
import 'package:swafa_app_frontend/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepositoryImpl({required this.profileRemoteDataSource});

  @override
  Future<UserProfileEntity> fetchProfile() async {
    return profileRemoteDataSource.fetchProfile();
  }
}