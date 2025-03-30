import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:swafa_app_frontend/features/newsfeed/data/models/sendMessage_model.dart';

class SendmessageRemoteDataSource {
  final String baseUrl;

  SendmessageRemoteDataSource({
    required this.baseUrl,
  });

  Future<SendmessageModel> sendMessage(String itemId, String message) async {
    final messageData = {'message': message};
    final response = await http.post(
      Uri.parse('$baseUrl/items/$itemId/messages'),
      headers: {'Content-Type': 'application/json'},
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
