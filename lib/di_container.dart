import 'package:swafa_app_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:swafa_app_frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:swafa_app_frontend/features/auth/domain/repositories/auth_repository.dart';
import 'package:swafa_app_frontend/features/auth/domain/usecases/login_use_case.dart';
import 'package:swafa_app_frontend/features/auth/domain/usecases/register_use_case.dart';
import 'package:swafa_app_frontend/features/conversation/data/datasources/conversations_remote_data_source.dart';
import 'package:swafa_app_frontend/features/conversation/data/repositories/conversations_repository_impl.dart';
import 'package:swafa_app_frontend/features/conversation/domain/repositories/conversation_repository.dart';
import 'package:swafa_app_frontend/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:swafa_app_frontend/features/message/data/datasources/messages_remote_data_source.dart';
import 'package:swafa_app_frontend/features/message/data/repositories/message_repository_impl.dart';
import 'package:swafa_app_frontend/features/message/domain/repositories/message_repository.dart';
import 'package:swafa_app_frontend/features/message/domain/usecases/fetch_messages_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:swafa_app_frontend/features/newsfeed/data/datasources/newsfeed_remote_data_source.dart';
import 'package:swafa_app_frontend/features/newsfeed/data/datasources/sendmessage_remote_data_source.dart';
import 'package:swafa_app_frontend/features/newsfeed/data/repositories/newsfeed_repository_impl.dart';
import 'package:swafa_app_frontend/features/newsfeed/data/repositories/sendMessage_repository_impl.dart';
import 'package:swafa_app_frontend/features/newsfeed/domain/repositories/newsfeed_repository.dart';
import 'package:swafa_app_frontend/features/newsfeed/domain/repositories/sendMessage_repository.dart';
import 'package:swafa_app_frontend/features/newsfeed/domain/usecases/fetch_items_use_case.dart';
import 'package:swafa_app_frontend/features/newsfeed/domain/usecases/sendMessage_use_case.dart';
import 'package:swafa_app_frontend/features/profile/data/datasource/profileItem_remote_datasource.dart';
import 'package:swafa_app_frontend/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:swafa_app_frontend/features/profile/data/repositories/item_repository_impl.dart';
import 'package:swafa_app_frontend/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:swafa_app_frontend/features/profile/domain/repositories/item_repository.dart';
import 'package:swafa_app_frontend/features/profile/domain/repositories/profile_repository.dart';
import 'package:swafa_app_frontend/features/profile/domain/usecase/fetch_item_use_case.dart';
import 'package:swafa_app_frontend/features/profile/domain/usecase/fetch_profile_use_case.dart';
import 'package:swafa_app_frontend/features/trade/data/datasources/trade_remote_data_source.dart';
import 'package:swafa_app_frontend/features/trade/data/repositories/trade_repository_impl.dart';
import 'package:swafa_app_frontend/features/trade/domain/repositories/trade_repository.dart';
import 'package:swafa_app_frontend/features/trade/domain/usecases/fetch_trades_use_case.dart';
import 'package:swafa_app_frontend/features/upload/data/datasource/upload_remote_datasource.dart';
import 'package:swafa_app_frontend/features/upload/data/repositories/upload_repository_impl.dart';
import 'package:swafa_app_frontend/features/upload/domain/repositories/upload_repository.dart';
import 'package:swafa_app_frontend/features/upload/domain/usecases/upload_use_case.dart';

final GetIt sl = GetIt.instance;

void setupDependencies() {
  const String baseUrl = 'http://swafa.suba-server.org/api/v1';
  //const String baseUrl = 'https://api.mockapi.com';

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(baseUrl: baseUrl));
  sl.registerLazySingleton<ConversationsRemoteDataSource>(
      () => ConversationsRemoteDataSource(baseUrl: baseUrl));
  sl.registerLazySingleton<MessagesRemoteDataSource>(
      () => MessagesRemoteDataSource(baseUrl: baseUrl));
  sl.registerLazySingleton<NewsfeedRemoteDataSource>(
      () => NewsfeedRemoteDataSource(baseUrl: baseUrl));
  sl.registerLazySingleton<TradesRemoteDataSource>(
      () => TradesRemoteDataSource(baseUrl: baseUrl));
  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSource(baseUrl: baseUrl));
  sl.registerLazySingleton<UploadRemoteDatasource>(
      () => UploadRemoteDatasource(baseUrl: baseUrl));
  sl.registerLazySingleton<ItemRemoteDataSource>(
      () => ItemRemoteDataSource(baseUrl: baseUrl));
  sl.registerLazySingleton<SendmessageRemoteDataSource>(
      () => SendmessageRemoteDataSource(baseUrl: baseUrl));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: sl()));
  sl.registerLazySingleton<ConversationRepository>(
      () => ConversationsRepositoryImpl(conversationsRemoteDataSource: sl()));
  sl.registerLazySingleton<MessageRepository>(
      () => MessagesRepositoryImpl(messagesRemoteDataSource: sl()));
  sl.registerLazySingleton<NewsfeedRepository>(
      () => NewsfeedRepositoryImpl(newsfeedRemoteDataSource: sl()));
  sl.registerLazySingleton<TradeRepository>(
      () => TradeRepositoryImpl(tradesRemoteDataSource: sl()));
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(profileRemoteDataSource: sl()));
  sl.registerLazySingleton<UploadRepository>(
      () => UploadRepositoryImpl(uploadRemoteDatasource: sl()));
  sl.registerLazySingleton<ItemProfileRepositoty>(
      () => ItemRepositoryImpl(itemRemoteDataSource: sl()));
  sl.registerLazySingleton<SendmessageRepository>(
      () => SendmessageRepositoryImpl(sendmessageRemoteDataSource: sl()));

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchConversationsUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => FetchMessagesUseCase(messagesRepository: sl()));
  sl.registerLazySingleton(() => FetchItemsUseCase(repository: sl()));
  sl.registerLazySingleton(() => FetchTradesUseCase(tradeRepository: sl()));
  sl.registerLazySingleton(() => FetchProfileUseCase(profileRepository: sl()));
  sl.registerLazySingleton(
      () => FetchItemProfileUseCase(itemProfileRepositoty: sl()));
  sl.registerLazySingleton(() => UploadUseCase(uploadRepository: sl()));
  sl.registerLazySingleton(() => SendmessageUseCase(repository: sl()));
  sl.registerLazySingleton(() => AcceptTradeUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeclineTradeUseCase(repository: sl()));
}
