import 'dart:convert';

import 'package:swafa_app_frontend/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String baseUrl = 'http://10.0.2.2:8080/auth';

  Future<UserModel> login(
      {required String email, required String password}) async {
    final response = await http.post(Uri.parse('$baseUrl/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'});
    return UserModel.fromJson(jsonDecode(response.body)['user']);
  }

  Future<UserModel> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        body: jsonEncode(
            {'name': username, 'email': email, 'password': password, 'password_confirm': confirmPassword}),
        headers: {'Content-Type': 'application/json'},
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
