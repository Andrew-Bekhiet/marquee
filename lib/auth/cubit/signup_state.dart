import 'package:equatable/equatable.dart';

sealed class SignupState with Equatable {
  final String email;
  final String password;
  final String confirmPassword;

  @override
  List<Object?> get props => [email, password, confirmPassword];

  const SignupState({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

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

final class SignupStateEmpty extends SignupState {
  const SignupStateEmpty()
    : super(email: '', password: '', confirmPassword: '');
}

final class SignupStateValid extends SignupState {
  const SignupStateValid({
    required super.email,
    required super.password,
    required super.confirmPassword,
  });
}

final class SignupStateInvalid extends SignupState {
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  @override
  List<Object?> get props => [
    email,
    password,
    confirmPassword,
    emailError,
    passwordError,
    confirmPasswordError,
  ];

  const SignupStateInvalid({
    required super.email,
    required super.password,
    required super.confirmPassword,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
  });

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

final class SignupStateLoading extends SignupState {
  const SignupStateLoading({
    required super.email,
    required super.password,
    required super.confirmPassword,
  });
}

final class SignupStateError extends SignupState {
  final String errorMessage;

  @override
  List<Object?> get props => [email, password, confirmPassword, errorMessage];

  const SignupStateError({
    required super.email,
    required super.password,
    required super.confirmPassword,
    required this.errorMessage,
  });

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
