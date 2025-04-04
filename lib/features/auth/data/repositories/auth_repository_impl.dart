import 'package:swafa_app_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:swafa_app_frontend/features/auth/domain/entities/token_entity.dart';
import 'package:swafa_app_frontend/features/auth/domain/entities/user_entity.dart';
import 'package:swafa_app_frontend/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<TokenEntity> login(String email, String password) async {
    return await authRemoteDataSource.login(email: email, password: password);
  }

  @override
  Future<UserEntity> register (
      String username, String email, String password, String confirmPassword) async {
    return await authRemoteDataSource.register(
        username: username, email: email, password: password, confirmPassword: confirmPassword);
  }
}
