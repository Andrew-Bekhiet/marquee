part of 'package:marquee/shared/navigation/marquee_route.dart';

final class const HomeShellRoute() extends MarqueeRoute {
  @override
  Widget build(BuildContext context) => KaiselBranchedShell.specs(
    branches: [
      KaiselBranchSpec<HomeBranchRoute>(
        initial: const HomeRoute(),
        builder: (context, route) => route.build(context),
      ),
      KaiselBranchSpec<ListsBranchRoute>(
        initial: const MovieListsRoute(),
        builder: (context, route) => route.build(context),
      ),
    ],
    branchContentBuilder: (_, activeBranch, branches, _) => IndexedStack(
      index: activeBranch,
      children: [
        for (final (index, branch) in branches.indexed)
          HeroMode(enabled: index == activeBranch, child: branch),
      ],
    ),
    chromeBuilder: (_, activeBranch, branchContent, switchBranch) => Scaffold(
      body: branchContent,
      bottomNavigationBar: NavigationBar(
        selectedIndex: activeBranch,
        onDestinationSelected: switchBranch,
        destinations: const [
          NavigationDestination(icon: Icon(Symbols.home), label: 'Home'),
          NavigationDestination(icon: Icon(Symbols.list), label: 'Lists'),
        ],
      ),
    ),
  );
}
