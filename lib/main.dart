import 'package:swafa_app_frontend/core/socket_service.dart';
import 'package:swafa_app_frontend/core/theme.dart';
import 'package:swafa_app_frontend/di_container.dart';
import 'package:swafa_app_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:swafa_app_frontend/features/auth/presentation/pages/login_page.dart';
import 'package:swafa_app_frontend/features/auth/presentation/pages/register_page.dart';
import 'package:swafa_app_frontend/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:swafa_app_frontend/features/conversation/presentation/pages/conversations_page.dart';
import 'package:swafa_app_frontend/features/message/presentation/bloc/message_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/bloc/newsfeed_bloc.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/pages/newsfeed_page.dart';
import 'package:swafa_app_frontend/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:swafa_app_frontend/features/trade/presentation/bloc/trade_bloc.dart';
import 'package:swafa_app_frontend/features/upload/presentation/bloc/upload_bloc.dart';
import 'package:swafa_app_frontend/onboarding_page.dart';
import 'package:swafa_app_frontend/tabs_screen.dart';

void main() async {
  final socketService = SocketService();
  await socketService.initSocket();

  // Setting up getIt
  setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            registerUseCase: sl(),
            loginUseCase: sl(),
          ),
        ),
        BlocProvider(
          create: (_) => ConversationsBloc(fetchConversationsUseCase: sl()),
        ),
        BlocProvider(
          create: (_) => MessageBloc(fetchMessagesUseCase: sl()),
        ),
        BlocProvider(
          create: (_) => NewsfeedBloc(fetchItemsUsecase: sl()),
        ),
        BlocProvider(
          create: (_) => TradeBloc(fetchTradesUseCase: sl()),
        ),
        BlocProvider(
          create: (_) => ProfileBloc(fetchProfileUseCase: sl(), fetchItemUseCase: sl()),
        ),
        BlocProvider(
          create: (_) => UploadBloc(uploadUseCase: sl()),
        )
      ],
      child: MaterialApp(
        title: 'Swafa App',
        theme: AppTheme.swafaTheme,
        debugShowCheckedModeBanner: false,
        home: const OnboardingPage(),
        routes: {
          '/login': (_) => const LoginPage(),
          '/register': (_) => const RegisterPage(),
          '/tabs': (_) => const TabsScreen(),
          '/newsfeed': (_) => const NewsFeedPage(),
          '/conversations': (_) => const ConversationsPage(),
        },
      ),
    );
  }
}
