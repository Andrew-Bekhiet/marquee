import 'package:kaisel/kaisel.dart';
import 'package:marquee/auth/cubit/authentication_cubit.dart';
import 'package:marquee/shared/navigation/marquee_route.dart';
import 'package:marquee/shared/utils/stream_as_listenable.dart';

class MarqueeRouter(final AuthenticationCubit authenticationCubit) {
  late final routerConfig = KaiselRouterConfig<MarqueeRoute>(
    androidPredictiveBack: true,
    initial: authenticationCubit.currentUser == null
        ? const LoginRoute()
        : const HomeShellRoute(),
    reevaluateOn: authenticationCubit.stream.asListenable(),
    guards: [requireAuthGuard],
    builder: (context, route) => route.build(context),
  );

  List<MarqueeRoute> requireAuthGuard(
    List<MarqueeRoute> _,
    List<MarqueeRoute> proposed,
  ) {
    final proposedTop = proposed.first;

    final currentUser = authenticationCubit.currentUser;
    if (currentUser == null &&
        proposedTop is! LoginRoute &&
        proposedTop is! SignupRoute) {
      return [const LoginRoute()];
    } else if (currentUser != null &&
        proposed.any((route) => route is LoginRoute || route is SignupRoute)) {
      return [const HomeShellRoute()];
    }

    return proposed;
  }
}
