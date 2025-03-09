import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:swafa_app_frontend/features/newsfeed/data/models/item_model.dart';

class NewsfeedRemoteDataSource {
  final String baseUrl;
  final _storage = const FlutterSecureStorage();

  NewsfeedRemoteDataSource({required this.baseUrl});

  Future<List<ItemModel>> fetchItems() async {
    String token = await _storage.read(key: 'token') ?? '';
    
    final response = await http.get(
      Uri.parse('$baseUrl/newsfeed'),
      headers: {
        'Authorization': 'Bearer $token',
        // "x-api-key": "480d0192e7054b55b99d2233c0445d83",
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['item'];
      return data.map((json) => ItemModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch Messages');
    }
  }
}
