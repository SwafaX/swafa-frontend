import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:swafa_app_frontend/features/profile/data/models/item_profile_model.dart';

class ItemRemoteDataSource {
  final String baseUrl; // Fixed base URL
  final _storage = const FlutterSecureStorage();

  ItemRemoteDataSource({required this.baseUrl});

  Future<List<ItemProfileModel>> fetchItems() async {
    String token = await _storage.read(key: 'accessToken') ?? '';

    final response = await http.get(
      Uri.parse('$baseUrl/items/me'), // Full URL: https://swafa.suba-server.org/api/v1/items/me
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print('Fetching my items');
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> itemList = jsonResponse['data'];
      return itemList.map((item) => ItemProfileModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch items');
    }
  }
}