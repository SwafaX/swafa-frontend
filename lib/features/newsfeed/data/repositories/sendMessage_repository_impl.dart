import 'package:swafa_app_frontend/features/newsfeed/data/datasources/sendmessage_remote_data_source.dart';
import 'package:swafa_app_frontend/features/newsfeed/data/models/sendMessage_model.dart';
import 'package:swafa_app_frontend/features/newsfeed/domain/repositories/sendMessage_repository.dart';

class SendmessageRepositoryImpl implements SendmessageRepository {
  final SendmessageRemoteDataSource sendmessageRemoteDataSource;

  SendmessageRepositoryImpl({required this.sendmessageRemoteDataSource});

  Future<SendmessageModel> sendMessage(String itemId, String message) async {
    return await sendmessageRemoteDataSource.sendMessage(itemId, message);
  }
}
