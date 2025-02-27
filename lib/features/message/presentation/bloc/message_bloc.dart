import 'package:swafa_app_frontend/core/socket_service.dart';
import 'package:swafa_app_frontend/features/message/domain/entities/message_entity.dart';
import 'package:swafa_app_frontend/features/message/domain/usecases/fetch_messages_use_case.dart';
import 'package:swafa_app_frontend/features/message/presentation/bloc/message_event.dart';
import 'package:swafa_app_frontend/features/message/presentation/bloc/message_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final FetchMessagesUseCase fetchMessagesUseCase;
  final SocketService _socketService = SocketService();
  final List<MessageEntity> _messages = [];
  final _storage = const FlutterSecureStorage();

  MessageBloc({required this.fetchMessagesUseCase})
      : super(MessageLoadingState()) {
    on<LoadMessagesEvent>(_onLoadMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<ReceivedMessageEvent>(_onReceivedMessage);
  }

  Future<void> _onLoadMessages(
      LoadMessagesEvent event, Emitter<MessageState> emit) async {
    emit(MessageLoadingState());
    try {
      final messages = await fetchMessagesUseCase(event.conversationId);
      _messages.clear();
      _messages.addAll(messages);
      emit(MessageLoadedState(messages: List.from(_messages)));

      _socketService.socket.emit('joinConversation', event.conversationId);
      _socketService.socket.on(
        'newMessage',
        (message) {
          print('step 1 - receive : $message');
          add(ReceivedMessageEvent(message: message));
        },
      );
    } catch (e) {
      emit(MessageErrorState(message: 'Failed to load messages'));
    }
  }

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<MessageState> emit) async {
    String userId = await _storage.read(key: 'accessToken') ?? '';
    print('userId : $userId');

    final newMessage = {
      'conversationId': event.conversationId,
      'content': event.content,
      'senderId': userId,
    };

    _socketService.socket.emit('sendMessage', newMessage);
  }

  Future<void> _onReceivedMessage(
      ReceivedMessageEvent event, Emitter<MessageState> emit) async {
    print('step 2 - receive event called');
    print(event.message);

    final message = MessageEntity(
      id: event.message['id'],
      conversationId: event.message['conversation_id'],
      senderId: event.message['sender_id'],
      content: event.message['content'],
      createdAt: event.message['created_at'],
    );

    _messages.add(message);
    emit(MessageLoadedState(messages: List.from(_messages)));
  }
}
