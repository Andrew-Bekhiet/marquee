class AuthException implements Exception {
  static const Map<String, String> _messagesByCode = {
    'invalid-email': 'That email address is not valid',
    'user-disabled': 'This account has been disabled',
    'user-not-found': 'No account found for that email',
    'wrong-password': 'Incorrect password. Please try again',
    'invalid-credential': 'Email or password is incorrect',
    'email-already-in-use': 'An account already uses that email',
    'weak-password': 'Password is too weak. Use 6 or more characters',
    'operation-not-allowed': 'Email sign-in is disabled for this app',
    'too-many-requests': 'Too many attempts. Please try again later',
    'network-request-failed': 'No internet connection',
  };

  final String message;

  const AuthException(this.message);

  factory AuthException.fromCode(String code) =>
      AuthException(_messagesByCode[code] ?? 'Authentication failed.');

  @override
  String toString() => message;
}
