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
import 'package:marquee/movies/repositories/movies_repository.dart';

part 'package:marquee/auth/navigation/login_route.dart';
part 'package:marquee/auth/navigation/signup_route.dart';
part 'package:marquee/home/navigation/home_route.dart';

sealed class const MarqueeRoute() extends KaiselRoute {
  Widget build(BuildContext context);
}
