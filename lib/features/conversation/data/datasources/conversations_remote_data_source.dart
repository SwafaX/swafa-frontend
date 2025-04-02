import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swafa_app_frontend/features/conversation/data/models/conversation_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ConversationsRemoteDataSource {
  final String baseUrl;
  final _storage = const FlutterSecureStorage();

  ConversationsRemoteDataSource({required this.baseUrl});

  // Helper function to fetch participant's name from /user/$userId/profile
  Future<String> _fetchParticipantName(
      String participantId, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/$participantId/profile'),
        headers: {'Authorization': 'Bearer $token'},
      );

      print(
          'Profile response status for $participantId: ${response.statusCode}');
      print('Profile response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        return data['name'] ?? 'Unknown';
      } else {
        throw Exception(
            'Failed to fetch profile for $participantId: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching profile for $participantId: $e');
      return 'Unknown';
    }
  }

  Future<List<ConversationModel>> fetchConversations() async {
    String token = await _storage.read(key: 'accessToken') ?? '';

    // Fetch conversations
    final response = await http.get(
      Uri.parse('$baseUrl/chats/me'),
      headers: {'Authorization': 'Bearer $token'},
    );

    print('Conversations response status: ${response.statusCode}');
    print('Conversations response body: ${response.body}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<ConversationModel> conversations = [];

      // Process each conversation
      for (var json in data) {
        try {
          // Fetch participant's name using participant2_id
          String participantName =
              await _fetchParticipantName(json['participant2_id'], token);

          // Create a modified JSON map that fromJson can use
          Map<String, dynamic> modifiedJson = {
            'id': json['id'],
            'participant_name': participantName, // Add the fetched name
            'last_message': json['last_message'] ?? '',
            'updated_at': json['updated_at'],
          };

          conversations.add(ConversationModel.fromJson(modifiedJson));
        } catch (e) {
          print('Error processing conversation ${json['id']}: $e');
        }
      }

      print('Total conversations fetched: ${conversations.length}');
      return conversations;
    } else {
      throw Exception('Failed to fetch conversations: ${response.statusCode}');
    }
  }
}
