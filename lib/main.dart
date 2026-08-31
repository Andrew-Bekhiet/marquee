import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/auth/repositories/auth_repository.dart';
import 'package:marquee/auth/repositories/firebase_auth_repository.dart';
import 'package:marquee/firebase_options.dart';
import 'package:marquee/shared/widgets/marquee_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    RepositoryProvider<AuthRepository>(
      create: (_) => FirebaseAuthRepository(),
      child: const MarqueeApp(),
    ),
  );
}
