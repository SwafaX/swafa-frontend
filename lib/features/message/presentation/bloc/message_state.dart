import 'package:swafa_app_frontend/features/message/domain/entities/message_entity.dart';

abstract class MessageState {}

class MessageLoadingState extends MessageState {}

class MessageLoadedState extends MessageState {
  final List<MessageEntity> messages;
  MessageLoadedState({required this.messages});
}

class MessageErrorState extends MessageState {
  final String message;
  MessageErrorState({required this.message});
}
