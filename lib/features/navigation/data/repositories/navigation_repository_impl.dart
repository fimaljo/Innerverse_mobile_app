import 'package:go_router/go_router.dart';
import 'package:innerverse/core/navigation/route_tracker.dart';
import 'package:innerverse/features/navigation/domain/entities/navigation_tab_entities.dart';
import 'package:innerverse/features/navigation/domain/repositories/navigation_repository.dart';

class NavigationRepositoryImpl implements NavigationRepository {
  NavigationRepositoryImpl(this.router, this.tracker);
  final GoRouter router;
  final RouteTracker tracker;

  @override
  Future<void> navigateToTab(NavigationTab tab) async {
    router.go(tab.route);
  }

  @override
  String getCurrentRoute() {
    return router.routerDelegate.currentConfiguration.last.matchedLocation;
  }

  @override
  Stream<String> get routeStream => tracker.routeStream;
}
