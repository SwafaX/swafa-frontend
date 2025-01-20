import 'package:swafa_app_frontend/features/message/domain/entities/message_entity.dart';

abstract class MessageRepository {
  Future<List<MessageEntity>> fetchMessage(String conversationId);
  Future<void> sendMessage(String content);
}
