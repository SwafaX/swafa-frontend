import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:swafa_app_frontend/features/newsfeed/data/models/item_model.dart';

class NewsfeedRemoteDataSource {
  final String baseUrl;
  final _storage = const FlutterSecureStorage();

  NewsfeedRemoteDataSource({required this.baseUrl});

  Future<List<ItemModel>> fetchItems() async {
    String token = await _storage.read(key: 'accessToken') ?? '';
    
    final response = await http.get(
      Uri.parse('$baseUrl/items'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print('This is newsfeed');
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['item'];
      return data.map((json) => ItemModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch Messages');
    }
  }
}
