import 'package:equatable/equatable.dart';

sealed class const SignupState({
  required final String email,
  required final String password,
  required final String confirmPassword,
}) with Equatable {
  @override
  List<Object?> get props => [email, password, confirmPassword];

  SignupState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
  }) => SignupStateValid(
    email: email ?? this.email,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword,
  );
}

final class const SignupStateEmpty() extends SignupState {
  this : super(email: '', password: '', confirmPassword: '');
}

final class const SignupStateValid({
  required super.email,
  required super.password,
  required super.confirmPassword,
}) extends SignupState;

final class const SignupStateInvalid({
  required super.email,
  required super.password,
  required super.confirmPassword,
  final String? emailError,
  final String? passwordError,
  final String? confirmPasswordError,
}) extends SignupState {
  @override
  List<Object?> get props => [
    email,
    password,
    confirmPassword,
    emailError,
    passwordError,
    confirmPasswordError,
  ];

  @override
  SignupState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
  }) => SignupStateInvalid(
    email: email ?? this.email,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword,
    emailError: emailError ?? this.emailError,
    passwordError: passwordError ?? this.passwordError,
    confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
  );
}

final class const SignupStateLoading({
  required super.email,
  required super.password,
  required super.confirmPassword,
}) extends SignupState;

final class const SignupStateError({
  required super.email,
  required super.password,
  required super.confirmPassword,
  required final String errorMessage,
}) extends SignupState {
  @override
  List<Object?> get props => [email, password, confirmPassword, errorMessage];

  @override
  SignupState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    String? errorMessage,
  }) => SignupStateError(
    email: email ?? this.email,
    password: password ?? this.password,
    confirmPassword: confirmPassword ?? this.confirmPassword,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
