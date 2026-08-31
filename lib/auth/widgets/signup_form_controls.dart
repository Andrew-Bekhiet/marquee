import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/auth/cubit/signup_cubit.dart';
import 'package:marquee/auth/cubit/signup_state.dart';
import 'package:marquee/auth/widgets/password_field.dart';
import 'package:material_ui/material_ui.dart';

class const SignupFormControls({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SignupCubit>();
    final state = cubit.state;

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: switch (state) {
              SignupStateInvalid(:final emailError) => emailError,
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
            SignupStateInvalid(:final passwordError) => passwordError,
            _ => null,
          },
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.newPassword],
          onChanged: cubit.onPasswordChanged,
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        ),
        PasswordField(
          labelText: 'Confirm password',
          errorText: switch (state) {
            SignupStateInvalid(:final confirmPasswordError) =>
              confirmPasswordError,
            _ => null,
          },
          autofillHints: const [AutofillHints.newPassword],
          onChanged: cubit.onConfirmPasswordChanged,
          onFieldSubmitted: (_) => cubit.signup(),
        ),
        FilledButton(
          onPressed: state is SignupStateLoading ? null : cubit.signup,
          child: state is SignupStateLoading
              ? SizedBox.square(
                  dimension: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: ColorScheme.of(context).onPrimary,
                  ),
                )
              : const Text('Create account'),
        ),
      ],
    );
  }
}
