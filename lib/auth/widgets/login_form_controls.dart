import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/auth/cubit/login_cubit.dart';
import 'package:marquee/auth/cubit/login_state.dart';
import 'package:marquee/auth/widgets/password_field.dart';

class LoginFormControls extends StatelessWidget {
  const LoginFormControls({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<LoginCubit>();
    final state = cubit.state;

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: switch (state) {
              LoginStateInvalid(:final emailError) => emailError,
              _ => null,
            },
          ),
          autofillHints: const [AutofillHints.email],
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: cubit.onEmailChanged,
        ),
        PasswordField(
          errorText: switch (state) {
            LoginStateInvalid(:final passwordError) => passwordError,
            _ => null,
          },
          onChanged: cubit.onPasswordChanged,
          onFieldSubmitted: (_) => cubit.login(),
        ),
        FilledButton(
          onPressed: state is LoginStateLoading ? null : cubit.login,
          child: state is LoginStateLoading
              ? SizedBox.square(
                  dimension: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: ColorScheme.of(context).onPrimary,
                  ),
                )
              : const Text('Sign in'),
        ),
      ],
    );
  }
}
