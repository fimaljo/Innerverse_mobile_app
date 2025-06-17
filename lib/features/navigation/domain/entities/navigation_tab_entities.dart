import 'package:flutter/material.dart';
import 'package:innerverse/core/navigation/route_constants.dart';

enum NavigationTab {
  entries,
  analytics,
  worlds;

  String get route {
    switch (this) {
      case NavigationTab.entries:
        return '/entries';
      case NavigationTab.analytics:
        return '/analytics';
      case NavigationTab.worlds:
        return RouteConstants.worldTree;
    }
  }

  IconData get icon {
    switch (this) {
      case NavigationTab.entries:
        return Icons.description_outlined;
      case NavigationTab.analytics:
        return Icons.show_chart;
      case NavigationTab.worlds:
        return Icons.show_chart;
    }
  }

  IconData get activeIcon {
    switch (this) {
      case NavigationTab.entries:
        return Icons.description;
      case NavigationTab.analytics:
        return Icons.trending_up;
      case NavigationTab.worlds:
        return Icons.trending_up;
    }
  }

  String get label {
    switch (this) {
      case NavigationTab.entries:
        return 'Entries';
      case NavigationTab.analytics:
        return 'Analytics';
      case NavigationTab.worlds:
        return 'Worlds';
    }
  }

  static NavigationTab fromRoute(String route) {
    for (final tab in NavigationTab.values) {
      if (route.startsWith(tab.route)) {
        return tab;
      }
    }
    return NavigationTab.entries; // Default fallback
  }
}
