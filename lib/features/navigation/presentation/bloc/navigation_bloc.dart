import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innerverse/features/navigation/domain/entities/navigation_tab_entities.dart';
import 'package:innerverse/features/navigation/domain/usecases/navigate_to_tab_usecase.dart';
import 'package:innerverse/features/navigation/presentation/bloc/navigation_event.dart';
import 'package:innerverse/features/navigation/presentation/bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc({
    required this.navigateToTabUseCase,
    // required this.getCurrentTabUseCase,
  }) : super(const NavigationState(currentTab: NavigationTab.entries)) {
    on<NavigationTabChanged>(_onNavigationTabChanged);
    // on<NavigationRouteChanged>(_onNavigationRouteChanged);

    // _init(); // Move async/stream logic outside constructor
  }

  final NavigateToTabUseCase navigateToTabUseCase;
  // final GetCurrentTabUseCase getCurrentTabUseCase;
  late final StreamSubscription<NavigationTab> _routeSubscription;

  // Future<void> _init() async {
  //   // Route listener
  //   _routeSubscription = getCurrentTabUseCase.tabStream.listen(
  //     (tab) => add(NavigationRouteChanged(tab.route)),
  //   );

  //   // Add initial route event on next microtask
  //   final currentTab = getCurrentTabUseCase.call();
  //   await Future.microtask(() => add(NavigationRouteChanged(currentTab.route)));
  // }

  Future<void> _onNavigationTabChanged(
    NavigationTabChanged event,
    Emitter<NavigationState> emit,
  ) async {
    if (event.tab != state.currentTab) {
      emit(state.copyWith(isLoading: true, error: ''));

      try {
        await navigateToTabUseCase(event.tab);
        emit(
          state.copyWith(
            currentTab: event.tab,
            isLoading: false,
            error: '',
          ),
        );
      } on Exception catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    }
  }

  // void _onNavigationRouteChanged(
  //   NavigationRouteChanged event,
  //   Emitter<NavigationState> emit,
  // ) {
  //   final newTab = NavigationTab.fromRoute(event.route);
  //   if (newTab != state.currentTab) {
  //     emit(state.copyWith(currentTab: newTab, error: ''));
  //   }
  // }

  @override
  Future<void> close() {
    _routeSubscription.cancel();
    return super.close();
  }
}
