import 'package:equatable/equatable.dart';

sealed class const LoginState({
  required final String email,
  required final String password,
}) with Equatable {
  @override
  List<Object?> get props => [email, password];

  LoginState copyWith({
    String? email,
    String? password,
  }) => LoginStateValid(
    email: email ?? this.email,
    password: password ?? this.password,
  );
}

final class const LoginStateEmpty() extends LoginState {
  this : super(email: '', password: '');
}

final class const LoginStateValid({
  required super.email,
  required super.password,
}) extends LoginState;

final class const LoginStateInvalid({
  required super.email,
  required super.password,
  final String? emailError,
  final String? passwordError,
}) extends LoginState {
  @override
  List<Object?> get props => [email, password, emailError, passwordError];

  @override
  LoginState copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
  }) => LoginStateInvalid(
    email: email ?? this.email,
    password: password ?? this.password,
    emailError: emailError ?? this.emailError,
    passwordError: passwordError ?? this.passwordError,
  );
}

final class const LoginStateLoading({
  required super.email,
  required super.password,
}) extends LoginState;

final class const LoginStateError({
  required super.email,
  required super.password,
  required final String errorMessage,
}) extends LoginState {
  @override
  List<Object?> get props => [email, password, errorMessage];

  @override
  LoginState copyWith({
    String? email,
    String? password,
    String? errorMessage,
  }) => LoginStateError(
    email: email ?? this.email,
    password: password ?? this.password,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
