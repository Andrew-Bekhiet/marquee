import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/auth/cubit/authentication_cubit.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const HomeScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authenticationCubit = context.watch<AuthenticationCubit>();
    final currentUser = authenticationCubit.currentUser;
    final name = currentUser?.name ?? currentUser?.email ?? 'Unknown user';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marquee'),
        actions: [
          IconButton(
            onPressed: authenticationCubit.logout,
            icon: const Icon(Symbols.logout),
            tooltip: 'Sign out',
          ),
        ],
      ),
      body: Center(child: Text('Signed in as $name')),
    );
  }
}
