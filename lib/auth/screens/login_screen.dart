import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/auth/cubit/login_cubit.dart';
import 'package:marquee/auth/cubit/login_state.dart';
import 'package:marquee/auth/repositories/auth_repository.dart';
import 'package:marquee/auth/screens/signup_screen.dart';
import 'package:marquee/auth/widgets/auth_screen_shell.dart';
import 'package:marquee/auth/widgets/login_form_controls.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    // TODO: move provider to a go_router route
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthRepository>()),
      child: BlocListener<LoginCubit, LoginState>(
        listenWhen: (_, current) => current is LoginStateError,
        listener: _showError,
        child: AuthScreenShell(
          title: 'Welcome back',
          subtitle: 'Sign in to pick up where you left off.',
          body: const LoginFormControls(),
          footer: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'New to Marquee?',
                style: TextTheme.of(
                  context,
                ).bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  PageRouteBuilder<void>(
                    pageBuilder: (_, _, _) => const SignupScreen(),
                    transitionDuration: Duration.zero,
                  ),
                ),
                child: const Text('Create an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showError(BuildContext context, LoginState state) {
    if (state is! LoginStateError) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state.errorMessage)),
    );
  }
}
