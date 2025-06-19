// 3. Use Cases
import 'package:innerverse/features/navigation/domain/entities/navigation_tab_entities.dart';
import 'package:innerverse/features/navigation/domain/repositories/navigation_repository.dart';

class NavigateToTabUseCase {
  NavigateToTabUseCase(this.repository);
  final NavigationRepository repository;

  Future<void> call(NavigationTab tab) async {
    await repository.navigateToTab(tab);
  }
}

// class GetCurrentTabUseCase {
//   const GetCurrentTabUseCase(this._repository);

//   final NavigationRepository _repository;

//   NavigationTab call() {
//     final currentRoute = _repository.getCurrentRoute();
//     return NavigationTab.fromRoute(currentRoute);
//   }

//   Stream<NavigationTab> get tabStream {
//     return _repository.routeStream.map(
//       NavigationTab.fromRoute,
//     );
//   }
// }
