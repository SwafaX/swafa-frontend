import 'package:swafa_app_frontend/features/auth/domain/entities/token_entity.dart';
import 'package:swafa_app_frontend/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<TokenEntity> login(String email, String password);
  Future<UserEntity> register(String username, String email, String password, String confirmPassword);
}
