import 'package:bloc/bloc.dart';
import 'package:marquee/auth/cubit/signup_state.dart';
import 'package:marquee/auth/repositories/auth_repository.dart';
import 'package:marquee/auth/utils/login_signup_validation.dart';

class SignupCubit(final AuthRepository _authRepository)
    extends Cubit<SignupState> {
  this : super(const SignupStateEmpty());

  void onEmailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void onConfirmPasswordChanged(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void _validateInputs() {
    final email = state.email;
    final password = state.password;
    final confirmPassword = state.confirmPassword;

    final emailError = LoginSignupValidation.validateEmail(email);
    final passwordError = LoginSignupValidation.validatePassword(password);
    final confirmPasswordError = LoginSignupValidation.validateConfirmPassword(
      password,
      confirmPassword,
    );

    if (emailError != null ||
        passwordError != null ||
        confirmPasswordError != null) {
      emit(
        SignupStateInvalid(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          emailError: emailError,
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
        ),
      );

      return;
    }

    emit(
      SignupStateValid(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      ),
    );
  }

  Future<void> signup() async {
    _validateInputs();
    if (state is! SignupStateValid) return;

    try {
      emit(
        SignupStateLoading(
          email: state.email,
          password: state.password,
          confirmPassword: state.confirmPassword,
        ),
      );

      await _authRepository.signup(
        email: state.email,
        password: state.password,
      );

      emit(
        SignupStateValid(
          email: state.email,
          password: state.password,
          confirmPassword: state.confirmPassword,
        ),
      );
    } catch (e) {
      emit(
        SignupStateError(
          email: state.email,
          password: state.password,
          confirmPassword: state.confirmPassword,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
