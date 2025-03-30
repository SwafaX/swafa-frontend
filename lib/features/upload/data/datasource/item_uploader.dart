import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ItemUploader {
  final String baseUrl;
  final FlutterSecureStorage _storage;

  ItemUploader({required this.baseUrl, required FlutterSecureStorage storage})
      : _storage = storage;

  Future<void> uploadItemData(
    String title,
    String description,
    String imageUrl, // Changed to a single string instead of a list
    String token,
  ) async {
    final itemData = {
      'title': title,
      'description': description,
      'image_url': imageUrl, // Matches the backend's "image_url" field
    };

    final response = await http.post(
      Uri.parse('$baseUrl/items'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(itemData),
    );

    print('Item upload status: ${response.statusCode}');
    print('Item upload body: ${response.body}');

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to upload item data: ${response.statusCode} - ${response.body}');
    }
  }
}