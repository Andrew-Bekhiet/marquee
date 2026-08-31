import 'package:bloc/bloc.dart';
import 'package:marquee/auth/cubit/login_state.dart';
import 'package:marquee/auth/repositories/auth_repository.dart';
import 'package:marquee/auth/utils/login_signup_validation.dart';

class LoginCubit(final AuthRepository _authRepository)
    extends Cubit<LoginState> {
  this : super(const LoginStateEmpty());

  void onEmailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void _validateInputs() {
    final email = state.email;
    final password = state.password;

    final emailError = LoginSignupValidation.validateEmail(email);
    final passwordError = LoginSignupValidation.validatePassword(password);

    if (emailError != null || passwordError != null) {
      emit(
        LoginStateInvalid(
          email: email,
          password: password,
          emailError: emailError,
          passwordError: passwordError,
        ),
      );

      return;
    }

    emit(LoginStateValid(email: email, password: password));
  }

  Future<void> login() async {
    _validateInputs();
    if (state is! LoginStateValid) return;

    try {
      emit(LoginStateLoading(email: state.email, password: state.password));

      await _authRepository.login(
        email: state.email,
        password: state.password,
      );

      emit(LoginStateValid(email: state.email, password: state.password));
    } catch (e) {
      emit(
        LoginStateError(
          email: state.email,
          password: state.password,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
