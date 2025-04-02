import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:swafa_app_frontend/features/newsfeed/data/models/sendMessage_model.dart';

class SendmessageRemoteDataSource {
  final String baseUrl;
  final _storage = const FlutterSecureStorage();

  SendmessageRemoteDataSource({
    required this.baseUrl,
  });

  Future<SendmessageModel> sendMessage(String itemId, String message) async {
    String token = await _storage.read(key: 'accessToken') ?? '';
    final messageData = {'message': message};
    final response = await http.post(
      Uri.parse('$baseUrl/items/$itemId/swap_request'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(messageData),
    );

    print('This is send message');
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      return SendmessageModel.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to send message: ${response.statusCode}');
    }
  }
}
