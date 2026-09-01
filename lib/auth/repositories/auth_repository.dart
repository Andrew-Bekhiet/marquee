import 'package:marquee/auth/models/user.dart';

abstract class AuthRepository() {
  Stream<User?> get userStream;

  User? get currentUser;

  Future<void> login({required String email, required String password});

  Future<void> signup({required String email, required String password});

  Future<void> logout();
}
