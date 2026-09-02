import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/auth/cubit/authentication_cubit.dart';
import 'package:marquee/auth/repositories/auth_repository.dart';
import 'package:marquee/auth/repositories/firebase_auth_repository.dart';
import 'package:marquee/firebase_options.dart';
import 'package:marquee/lists/data_sources/sqflite_movie_lists_data_source.dart';
import 'package:marquee/lists/repositories/local_movie_lists_repository.dart';
import 'package:marquee/lists/repositories/movie_lists_repository.dart';
import 'package:marquee/movies/api/tmdb_api.dart';
import 'package:marquee/movies/repositories/movies_repository.dart';
import 'package:marquee/movies/repositories/tmdb_movies_repository.dart';
import 'package:marquee/shared/widgets/marquee_app.dart';
import 'package:material_ui/material_ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final movieListsDataSource = await SqfliteMovieListsDataSource.open();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => FirebaseAuthRepository(),
        ),
        RepositoryProvider<MovieListsRepository>(
          create: (context) => LocalMovieListsRepository(
            movieListsDataSource,
            context.read<AuthRepository>(),
          ),
        ),
        RepositoryProvider<MoviesRepository>(
          create: (_) => TmdbMoviesRepository(TMDBApi()),
        ),
      ],
      child: BlocProvider(
        create: (context) =>
            AuthenticationCubit(context.read<AuthRepository>()),
        child: const MarqueeApp(),
      ),
    ),
  );
}
