import 'package:swafa_app_frontend/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String username,
    required String email,
    required String token,
  }) : super(id: id, email: email, username: username, token: token);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['ID'],
      username: json['Name'],
      email: json['Email'],
      token: json['token'] ?? '',
    );
  }
}
