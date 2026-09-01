import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/auth/models/user.dart';
import 'package:marquee/auth/repositories/auth_repository.dart';
import 'package:marquee/auth/screens/login_screen.dart';
import 'package:marquee/screens/home_screen.dart';
import 'package:material_ui/material_ui.dart';

// TODO: replace with a go_router route guard
class const AuthGate({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();

    return StreamBuilder<User?>(
      stream: authRepository.userStream,
      initialData: authRepository.currentUser,
      builder: (_, snapshot) =>
          snapshot.data == null ? const LoginScreen() : const HomeScreen(),
    );
  }
}
