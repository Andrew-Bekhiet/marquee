abstract final class LoginSignupValidation {
  static const _minPasswordLength = 8;
  static final _emailRegex = RegExp(r'^[^@]+@[^.]+(\.[^.]+)+$');

  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email cannot be empty';
    }

    if (!_emailRegex.hasMatch(email)) {
      return 'Invalid email format';
    }

    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }

    if (password.length < _minPasswordLength) {
      return 'Password must be at least $_minPasswordLength characters long';
    }

    return null;
  }

  static String? validateConfirmPassword(
    String password,
    String confirmPassword,
  ) {
    if (confirmPassword.isEmpty) {
      return 'Confirm password cannot be empty';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }
}
