import 'dart:convert';

import 'package:swafa_app_frontend/features/conversation/data/models/conversation_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ConversationsRemoteDataSource {
  final String baseUrl;
  final _storage = const FlutterSecureStorage();

  ConversationsRemoteDataSource({required this.baseUrl});

  Future<List<ConversationModel>> fetchConversations() async {
    String token = await _storage.read(key: 'accessToken') ?? '';

    final response = await http.get(
      Uri.parse('$baseUrl/conversations'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => ConversationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch conversation');
    }
  }
}
