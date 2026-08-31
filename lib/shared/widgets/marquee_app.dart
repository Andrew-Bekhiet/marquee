import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/auth/repositories/auth_repository.dart';
import 'package:marquee/auth/repositories/firebase_auth_repository.dart';
import 'package:marquee/auth/widgets/auth_gate.dart';
import 'package:marquee/theme/marquee_theme.dart';

class MarqueeApp extends StatelessWidget {
  const MarqueeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      create: (_) => FirebaseAuthRepository(),
      child: MaterialApp(
        title: 'Marquee',
        debugShowCheckedModeBanner: false,
        theme: MarqueeTheme.theme,
        home: const AuthGate(),
      ),
    );
  }
}
