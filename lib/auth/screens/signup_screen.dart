import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/auth/cubit/signup_cubit.dart';
import 'package:marquee/auth/cubit/signup_state.dart';
import 'package:marquee/auth/repositories/auth_repository.dart';
import 'package:marquee/auth/screens/login_screen.dart';
import 'package:marquee/auth/widgets/auth_screen_shell.dart';
import 'package:marquee/auth/widgets/signup_form_controls.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // TODO: move provider to a go_router route
    return BlocProvider(
      create: (context) => SignupCubit(context.read<AuthRepository>()),
      child: BlocListener<SignupCubit, SignupState>(
        listenWhen: (_, current) => current is SignupStateError,
        listener: _showError,
        child: AuthScreenShell(
          title: 'Create your account',
          subtitle: 'Track what you watch, and what comes next.',
          body: const SignupFormControls(),
          footer: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: TextTheme.of(
                  context,
                ).bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  PageRouteBuilder<void>(
                    pageBuilder: (_, _, _) => const LoginScreen(),
                    transitionDuration: Duration.zero,
                  ),
                ),
                child: const Text('Sign in'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showError(BuildContext context, SignupState state) {
    if (state is! SignupStateError) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(state.errorMessage)),
    );
  }
}
