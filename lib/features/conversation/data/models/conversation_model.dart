import 'package:swafa_app_frontend/features/conversation/domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel({
    required super.id,
    required super.participantName,
    required super.lastMessage,
    required super.lastMessageTime,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'],
      participantName: json['participant_name'] ?? 'Unknown',
      lastMessage: json['last_message'] ?? 'Unknown',
      lastMessageTime: DateTime.parse(json['updated_at']),
    );
  }
}
