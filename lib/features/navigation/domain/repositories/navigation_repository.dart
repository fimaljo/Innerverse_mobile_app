import 'package:innerverse/features/navigation/domain/entities/navigation_tab_entities.dart';

abstract class NavigationRepository {
  Future<void> navigateToTab(NavigationTab tab);
  String getCurrentRoute();
  Stream<String> get routeStream;
}
