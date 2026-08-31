import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:marquee/auth/models/auth_exception.dart';
import 'package:marquee/auth/models/user.dart';
import 'package:marquee/auth/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final firebase.FirebaseAuth _firebaseAuth;

  @override
  Stream<User?> get user => _firebaseAuth.userChanges().map(_toDomainUser);

  @override
  User? get currentUser => _toDomainUser(_firebaseAuth.currentUser);

  FirebaseAuthRepository({firebase.FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? firebase.FirebaseAuth.instance;

  @override
  Future<void> login({
    required String email,
    required String password,
  }) => _catchAndConvertToDomainException(
    () => _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ),
  );

  @override
  Future<void> signup({
    required String email,
    required String password,
  }) => _catchAndConvertToDomainException(
    () => _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ),
  );

  @override
  Future<void> logout() =>
      _catchAndConvertToDomainException(_firebaseAuth.signOut);

  Future<void> _catchAndConvertToDomainException(
    Future<void> Function() action,
  ) async {
    try {
      await action();
    } on firebase.FirebaseAuthException catch (exception) {
      throw AuthException.fromCode(exception.code);
    }
  }

  User? _toDomainUser(firebase.User? user) => user == null
      ? null
      : User(
          uid: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? '',
        );
}
