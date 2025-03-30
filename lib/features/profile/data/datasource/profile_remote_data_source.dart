import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:swafa_app_frontend/features/profile/data/models/profile_model.dart';

class ProfileRemoteDataSource {
  final String baseUrl;
  final _storage = const FlutterSecureStorage();

  ProfileRemoteDataSource({required this.baseUrl});

  Future<UserProfileModel> fetchProfile() async {
    String token = await _storage.read(key: 'accessToken') ?? '';

    final response = await http.get(
      Uri.parse('$baseUrl/user/me/profile'),
      headers: {
        'Authorization': 'Bearer $token',
        //"x-api-key": "480d0192e7054b55b99d2233c0445d83",
      },
    );

    print('This is profile');
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return UserProfileModel.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Failed to fetch Profile');
    }
  }
}
