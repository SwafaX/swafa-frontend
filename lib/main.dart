import 'package:swafa_app_frontend/core/socket_service.dart';
import 'package:swafa_app_frontend/core/theme.dart';
import 'package:swafa_app_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:swafa_app_frontend/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:swafa_app_frontend/features/auth/domain/usecases/login_use_case.dart';
import 'package:swafa_app_frontend/features/auth/domain/usecases/register_use_case.dart';
import 'package:swafa_app_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:swafa_app_frontend/features/auth/presentation/pages/login_page.dart';
import 'package:swafa_app_frontend/features/auth/presentation/pages/register_page.dart';
import 'package:swafa_app_frontend/features/conversation/data/datasources/conversations_remote_data_source.dart';
import 'package:swafa_app_frontend/features/conversation/data/repositories/conversations_repository_impl.dart';
import 'package:swafa_app_frontend/features/conversation/domain/usecases/fetch_conversations_use_case.dart';
import 'package:swafa_app_frontend/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:swafa_app_frontend/features/conversation/presentation/pages/conversations_page.dart';
import 'package:swafa_app_frontend/features/message/data/datasources/messages_remote_data_source.dart';
import 'package:swafa_app_frontend/features/message/data/repositories/message_repository_impl.dart';
import 'package:swafa_app_frontend/features/message/domain/usecases/fetch_messages_use_case.dart';
import 'package:swafa_app_frontend/features/message/presentation/bloc/message_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/pages/newsfeed_page.dart';
import 'package:swafa_app_frontend/onboarding_page.dart';

void main() async {
  final socketService = SocketService();
  await socketService.initSocket();

  final authRepository =
      AuthRepositoryImpl(authRemoteDataSource: AuthRemoteDataSource());
  final conversationRepository = ConversationsRepositoryImpl(
      conversationsRemoteDataSource: ConversationsRemoteDataSource());
  final messagesRepository = MessagesRepositoryImpl(
      messagesRemoteDataSource: MessagesRemoteDataSource());

  runApp(MyApp(
    authRepository: authRepository,
    conversationsRepository: conversationRepository,
    messagesRepository: messagesRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final ConversationsRepositoryImpl conversationsRepository;
  final MessagesRepositoryImpl messagesRepository;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.conversationsRepository,
    required this.messagesRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            registerUseCase: RegisterUseCase(repository: authRepository),
            loginUseCase: LoginUseCase(repository: authRepository),
          ),
        ),
        BlocProvider(
          create: (_) => ConversationsBloc(
              fetchConversationsUseCase: FetchConversationsUseCase(
                  repository: conversationsRepository)),
        ),
        BlocProvider(
            create: (_) => MessageBloc(
                fetchMessagesUseCase: FetchMessagesUseCase(
                    messagesRepository: messagesRepository))),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.swafaTheme,
        debugShowCheckedModeBanner: false,
        home: const OnboardingPage(),
        routes: {
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/newsfeed': (_) => const NewsFeedPage(),
          '/conversations': (_) => const ConversationsPage(),
        },
      ),
    );
  }
}
