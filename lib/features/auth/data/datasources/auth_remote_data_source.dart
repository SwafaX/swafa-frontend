import 'dart:convert';

import 'package:swafa_app_frontend/features/auth/data/models/token_model.dart';
import 'package:swafa_app_frontend/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String baseUrl;

  AuthRemoteDataSource({required this.baseUrl});

  Future<TokenModel> login(
      {required String email, required String password}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      body: jsonEncode(
        {
          'email': email,
          'password': password,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
        // "x-api-key": "480d0192e7054b55b99d2233c0445d83"
      },
    );

    print(response.body);

    return TokenModel.fromJson(jsonDecode(response.body));
  }

  Future<UserModel> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        body: jsonEncode({
          'name': username,
          'email': email,
          'password': password,
          'password_confirm': confirmPassword
        }),
        headers: {
          'Content-Type': 'application/json',
          "x-api-key": "480d0192e7054b55b99d2233c0445d83"
        },
      );

      print(response.statusCode);
      print(response.body);

      return UserModel.fromJson(jsonDecode(response.body)['user']);
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
