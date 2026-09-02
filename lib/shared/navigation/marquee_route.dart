import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaisel/kaisel.dart';
import 'package:marquee/auth/cubit/login_cubit.dart';
import 'package:marquee/auth/cubit/signup_cubit.dart';
import 'package:marquee/auth/repositories/auth_repository.dart';
import 'package:marquee/auth/screens/login_screen.dart';
import 'package:marquee/auth/screens/signup_screen.dart';
import 'package:marquee/home/cubit/home_cubit.dart';
import 'package:marquee/home/screens/home_screen.dart';
import 'package:marquee/lists/cubit/movie_lists_cubit.dart';
import 'package:marquee/lists/repositories/movie_lists_repository.dart';
import 'package:marquee/lists/screens/movie_lists_screen.dart';
import 'package:marquee/movies/cubit/movie_details_cubit.dart';
import 'package:marquee/movies/models/movie.dart';
import 'package:marquee/movies/repositories/movies_repository.dart';
import 'package:marquee/movies/screens/movie_details_screen.dart';
import 'package:marquee/search/cubit/search_cubit.dart';
import 'package:marquee/search/screens/search_screen.dart';

part 'package:marquee/auth/navigation/login_route.dart';
part 'package:marquee/auth/navigation/signup_route.dart';
part 'package:marquee/home/navigation/home_route.dart';
part 'package:marquee/lists/navigation/movie_lists_route.dart';
part 'package:marquee/movies/navigation/movie_details_route.dart';
part 'package:marquee/search/navigation/search_route.dart';

sealed class const MarqueeRoute() extends KaiselRoute {
  Widget build(BuildContext context);
}
