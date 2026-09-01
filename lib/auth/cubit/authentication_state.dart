import 'package:equatable/equatable.dart';
import 'package:marquee/auth/models/user.dart';

sealed class const AuthenticationState() with Equatable {
  @override
  List<Object?> get props => const [];
}

final class const AuthenticationStateAuthenticated(final User user)
    extends AuthenticationState {
  @override
  List<Object?> get props => [user];
}

final class const AuthenticationStateUnauthenticated()
    extends AuthenticationState;
