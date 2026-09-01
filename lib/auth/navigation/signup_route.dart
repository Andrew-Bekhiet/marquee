part of 'package:marquee/shared/navigation/marquee_route.dart';

final class const SignupRoute() extends MarqueeRoute {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(context.read<AuthRepository>()),
      child: const SignupScreen(),
    );
  }
}
