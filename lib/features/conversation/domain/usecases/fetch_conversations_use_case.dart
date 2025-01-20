import 'package:swafa_app_frontend/features/conversation/domain/entities/conversation_entity.dart';
import 'package:swafa_app_frontend/features/conversation/domain/repositories/conversation_repository.dart';

class FetchConversationsUseCase {
  final ConversationRepository repository;

  FetchConversationsUseCase({required this.repository});

  Future<List<ConversationEntity>> call() {
    return repository.fetchConversation();
  }
}
