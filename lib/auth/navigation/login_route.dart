part of 'package:marquee/shared/navigation/marquee_route.dart';

final class const LoginRoute() extends MarqueeRoute {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthRepository>()),
      child: const LoginScreen(),
    );
  }
}
