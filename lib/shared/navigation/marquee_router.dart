import 'package:kaisel/kaisel.dart';
import 'package:marquee/auth/repositories/auth_repository.dart';
import 'package:marquee/shared/navigation/marquee_route.dart';
import 'package:marquee/shared/utils/stream_as_listenable.dart';

class MarqueeRouter(final AuthRepository authRepository) {
  late final routerConfig = KaiselRouterConfig<MarqueeRoute>(
    androidPredictiveBack: true,
    initial: authRepository.currentUser == null
        ? const LoginRoute()
        : const HomeRoute(),
    reevaluateOn: authRepository.userStream.asListenable(),
    guards: [requireAuthGuard],
    builder: (context, route) => route.build(context),
  );

  List<MarqueeRoute> requireAuthGuard(
    List<MarqueeRoute> _,
    List<MarqueeRoute> proposed,
  ) {
    final proposedTop = proposed.first;

    final currentUser = authRepository.currentUser;
    if (currentUser == null &&
        proposedTop is! LoginRoute &&
        proposedTop is! SignupRoute) {
      return [const LoginRoute()];
    } else if (currentUser != null &&
        proposed.any((route) => route is LoginRoute || route is SignupRoute)) {
      return [const HomeRoute()];
    }

    return proposed;
  }
}
