import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const HomeNavigationBar({
  required final int selectedIndex,
  required final ValueChanged<int> onDestinationSelected,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: const [
        NavigationDestination(icon: Icon(Symbols.home), label: 'Home'),
        NavigationDestination(icon: Icon(Symbols.list), label: 'Lists'),
      ],
    );
  }
}
