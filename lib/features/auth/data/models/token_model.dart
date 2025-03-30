import 'package:swafa_app_frontend/features/auth/domain/entities/token_entity.dart';

class TokenModel extends TokenEntity {
  TokenModel({required super.accessToken, required super.refreshToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}
