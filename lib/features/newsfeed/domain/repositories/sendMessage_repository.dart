import 'package:swafa_app_frontend/features/newsfeed/domain/entities/sendMessage_entity.dart';

abstract class SendmessageRepository {
  Future<SendmessageEntity> sendMessage(String itemId, String message);
}
