import 'package:swafa_app_frontend/features/newsfeed/domain/entities/sendMessage_entity.dart';
import 'package:swafa_app_frontend/features/newsfeed/domain/repositories/sendMessage_repository.dart';

class SendmessageUseCase {
  final SendmessageRepository repository;

  SendmessageUseCase({required this.repository});

  Future<SendmessageEntity> call(String itemId, String message) {
    return repository.sendMessage(itemId, message);
  }
}
