import 'package:swafa_app_frontend/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String username,
    required String email,
  }) : super(id: id, email: email, username: username);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
<<<<<<< HEAD
      id: json['id'],
      username: json['username'],
      email: json['email'],
=======
      id: json['ID'],
      username: json['Name'],
      email: json['Email'],
      token: json['token'] ?? '',
>>>>>>> 8675e5e4062c1c1b6dc0b84786d02a1dd32b3f00
    );
  }
}
