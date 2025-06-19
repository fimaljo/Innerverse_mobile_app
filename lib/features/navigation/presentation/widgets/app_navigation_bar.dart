import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innerverse/features/navigation/domain/entities/navigation_tab_entities.dart';
import 'package:innerverse/features/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:innerverse/features/navigation/presentation/bloc/navigation_event.dart';
import 'package:innerverse/features/navigation/presentation/bloc/navigation_state.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    required this.currentIndex,
    required this.onNavTap,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onNavTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        final currentTab = state.currentTab;

        return BottomNavigationBar(
          currentIndex: _getTabIndex(currentTab),
          onTap: (index) => _onTabTap(context, _getTabFromIndex(index)),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.surface,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor:
              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          elevation: 8,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined),
              activeIcon: Icon(Icons.description),
              label: 'Entries',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public_outlined),
              activeIcon: Icon(Icons.public),
              label: 'Worlds',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart_outlined),
              activeIcon: Icon(Icons.show_chart),
              label: 'Analytics',
            ),
          ],
        );
      },
    );
  }

  int _getTabIndex(NavigationTab tab) {
    switch (tab) {
      case NavigationTab.entries:
        return 0;
      case NavigationTab.worlds:
        return 1;
      case NavigationTab.analytics:
        return 2;
    }
  }

  NavigationTab _getTabFromIndex(int index) {
    switch (index) {
      case 0:
        return NavigationTab.entries;
      case 1:
        return NavigationTab.worlds;
      case 2:
        return NavigationTab.analytics;
      default:
        return NavigationTab.entries;
    }
  }

  void _onTabTap(BuildContext context, NavigationTab tab) {
    context.read<NavigationBloc>().add(NavigationTabChanged(tab));
  }
}
