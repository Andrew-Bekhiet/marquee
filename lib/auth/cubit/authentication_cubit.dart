import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:marquee/auth/cubit/authentication_state.dart';
import 'package:marquee/auth/models/user.dart';
import 'package:marquee/auth/repositories/auth_repository.dart';

class AuthenticationCubit(final AuthRepository _authRepository)
    extends Cubit<AuthenticationState> {
  StreamSubscription<User?>? _subscription;

  User? get currentUser => switch (state) {
    AuthenticationStateAuthenticated(:final user) => user,
    AuthenticationStateUnauthenticated() => null,
  };

  this : super(_stateFor(_authRepository.currentUser)) {
    _subscription = _authRepository.userStream.listen(
      (user) => emit(_stateFor(user)),
    );
  }

  Future<void> logout() => _authRepository.logout();

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await super.close();
  }

  static AuthenticationState _stateFor(User? user) => user == null
      ? const AuthenticationStateUnauthenticated()
      : AuthenticationStateAuthenticated(user);
}
