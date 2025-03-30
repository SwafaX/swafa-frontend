import 'package:swafa_app_frontend/features/newsfeed/domain/entities/sendMessage_entity.dart';

class SendmessageModel extends SendmessageEntity {
  SendmessageModel({required super.message});

  factory SendmessageModel.fromJson(Map<String, dynamic> json) {
    return SendmessageModel(message: json['message']);
  }
}
