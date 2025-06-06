import 'package:swafa_app_frontend/features/auth/domain/entities/token_entity.dart';
import 'package:swafa_app_frontend/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase({required this.repository});

  Future<TokenEntity> call(String email, String password) {
    return repository.login(email, password);
  }
}
