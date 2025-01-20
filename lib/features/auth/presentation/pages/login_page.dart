import 'package:swafa_app_frontend/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:swafa_app_frontend/features/auth/presentation/bloc/auth_event.dart';
import 'package:swafa_app_frontend/features/auth/presentation/bloc/auth_state.dart';
import 'package:swafa_app_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:swafa_app_frontend/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:swafa_app_frontend/features/auth/presentation/widgets/prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    BlocProvider.of<AuthBloc>(context).add(
      LoginEvent(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 70, left: 70, bottom: 70),
                child: Image.asset('assets/images/branding_name.png'),
              ),
              AuthInputField(
                  hint: 'Email',
                  icon: Icons.person,
                  controller: _emailController),
              const SizedBox(height: 20),
              AuthInputField(
                  hint: 'Password',
                  icon: Icons.lock,
                  controller: _passwordController,
                  isPassword: true),
              const SizedBox(height: 30),
              BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return AuthButton(
                    text: 'Login',
                    onPress: _onLogin,
                  );
                },
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/conversations',
                      (route) => false,
                    );
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              Prompt(
                title: 'Have not had the account yet ? ',
                subtitle: 'Sign Up',
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
