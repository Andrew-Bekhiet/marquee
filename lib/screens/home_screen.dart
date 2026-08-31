import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/auth/repositories/auth_repository.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const HomeScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();
    final currentUser = authRepository.currentUser;
    final name = currentUser?.name ?? currentUser?.email ?? 'Unknown user';

    // TODO: use AuthBloc to signout instead of directly calling the repository
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marquee'),
        actions: [
          IconButton(
            onPressed: authRepository.logout,
            icon: const Icon(Symbols.logout),
            tooltip: 'Sign out',
          ),
        ],
      ),
      body: Center(child: Text('Signed in as $name')),
    );
  }
}
