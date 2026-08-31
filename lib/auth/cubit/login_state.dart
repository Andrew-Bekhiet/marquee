import 'package:equatable/equatable.dart';

sealed class LoginState with Equatable {
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];

  const LoginState({
    required this.email,
    required this.password,
  });

  LoginState copyWith({
    String? email,
    String? password,
  }) => LoginStateValid(
    email: email ?? this.email,
    password: password ?? this.password,
  );
}

final class LoginStateEmpty extends LoginState {
  const LoginStateEmpty() : super(email: '', password: '');
}

final class LoginStateValid extends LoginState {
  const LoginStateValid({
    required super.email,
    required super.password,
  });
}

final class LoginStateInvalid extends LoginState {
  final String? emailError;
  final String? passwordError;

  @override
  List<Object?> get props => [email, password, emailError, passwordError];

  const LoginStateInvalid({
    required super.email,
    required super.password,
    this.emailError,
    this.passwordError,
  });

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

final class LoginStateLoading extends LoginState {
  const LoginStateLoading({
    required super.email,
    required super.password,
  });
}

final class LoginStateError extends LoginState {
  final String errorMessage;

  @override
  List<Object?> get props => [email, password, errorMessage];

  const LoginStateError({
    required super.email,
    required super.password,
    required this.errorMessage,
  });

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
