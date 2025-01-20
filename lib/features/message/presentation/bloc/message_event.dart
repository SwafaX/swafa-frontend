abstract class MessageEvent {}

class LoadMessagesEvent extends MessageEvent {
  final String conversationId;
  LoadMessagesEvent({required this.conversationId});
}

class SendMessageEvent extends MessageEvent {
  final String conversationId;
  final String content;

  SendMessageEvent({required this.conversationId, required this.content});
}

class ReceivedMessageEvent extends MessageEvent {
  final Map<String, dynamic> message;
  ReceivedMessageEvent({required this.message});
}
