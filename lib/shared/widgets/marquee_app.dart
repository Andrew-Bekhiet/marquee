import 'package:marquee/auth/cubit/authentication_cubit.dart';
import 'package:marquee/shared/marquee_theme.dart';
import 'package:marquee/shared/navigation/marquee_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

class const MarqueeApp({super.key}) extends StatefulWidget {
  @override
  State<MarqueeApp> createState() => _MarqueeAppState();
}

class _MarqueeAppState() extends State<MarqueeApp> {
  late final router = MarqueeRouter(context.read<AuthenticationCubit>());

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Marquee',
      debugShowCheckedModeBanner: false,
      theme: MarqueeTheme.theme,
      routerConfig: router.routerConfig,
    );
  }

  @override
  void dispose() {
    router.routerConfig.dispose();
    super.dispose();
  }
}
