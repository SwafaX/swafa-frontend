import 'package:swafa_app_frontend/features/auth/domain/usecases/login_use_case.dart';
import 'package:swafa_app_frontend/features/auth/domain/usecases/register_use_case.dart';
import 'package:swafa_app_frontend/features/auth/presentation/bloc/auth_event.dart';
import 'package:swafa_app_frontend/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final _storage = const FlutterSecureStorage();

  AuthBloc({required this.registerUseCase, required this.loginUseCase})
      : super(AuthInitial()) {
    on<RegisterEvent>(_onRegister);
    on<LoginEvent>(_onLogin);
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase.call(
        event.username,
        event.email,
        event.password,
        event.confirmPassword,
      );
      emit(AuthSuccess(message: "Registration successful"));
    } catch (e) {
      emit(AuthFailure(error: "Registration failed"));
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await loginUseCase.call(
        event.email,
        event.password,
      );
      await _storage.write(key: 'accessToken', value: token.accessToken);
      await _storage.write(key: 'refreshToken', value: token.refreshToken);
      emit(AuthSuccess(message: "Login successful"));
    } catch (e) {
      emit(AuthFailure(error: "Login failed"));
    }
  }
}
