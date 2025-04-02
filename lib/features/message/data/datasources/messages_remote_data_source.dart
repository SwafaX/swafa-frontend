import 'dart:convert';

import 'package:swafa_app_frontend/features/message/data/models/message_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MessagesRemoteDataSource {
  final String baseUrl;
  final _storage = const FlutterSecureStorage();

  MessagesRemoteDataSource({required this.baseUrl});

  Future<List<MessageModel>> fetchMessages(String conversationId) async {
    String token = await _storage.read(key: 'accessToken') ?? '';
    final response = await http.get(
      Uri.parse('$baseUrl/$conversationId/messages'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    // Debugging logs
    print('Conversation ID: $conversationId');
    print('Messages response status: ${response.statusCode}');
    print('Messages response body: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => MessageModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch Messages');
    }
  }
}
