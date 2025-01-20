import 'package:swafa_app_frontend/core/socket_service.dart';
import 'package:swafa_app_frontend/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:swafa_app_frontend/features/conversation/presentation/bloc/conversations_event.dart';
import 'package:swafa_app_frontend/features/conversation/presentation/bloc/conversations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final FetchConversationsUseCase fetchConversationsUseCase;
  final SocketService _socketService = SocketService();

  ConversationsBloc({required this.fetchConversationsUseCase})
      : super(ConversationsInitial()) {
    on<FetchConversationsEvent>(_onFetchConversations);
    _initializeSocketListeners();
  }

  void _initializeSocketListeners() {
    try {
      _socketService.socket.on('conversationUpdated', _onConversationUpdated);
    } catch (e) {
      print('Error initializing socket listeners: $e');
    }
  }

  Future<void> _onFetchConversations(
      FetchConversationsEvent event, Emitter<ConversationsState> emit) async {
    emit(ConversationsLoading());
    try {
      final conversations = await fetchConversationsUseCase.call();
      emit(ConversationsLoaded(conversations: conversations));
    } catch (e) {
      emit(ConversationsError(message: 'Failed to load conversations'));
    }
  }

  void _onConversationUpdated(data) {
    add(FetchConversationsEvent());
  }
}
