import 'package:equatable/equatable.dart';
import 'package:innerverse/features/navigation/domain/entities/navigation_tab_entities.dart';

class NavigationState extends Equatable {
  const NavigationState({
    required this.currentTab,
    this.isLoading = false,
    this.error,
  });

  final NavigationTab currentTab;
  final bool isLoading;
  final String? error;

  NavigationState copyWith({
    NavigationTab? currentTab,
    bool? isLoading,
    String? error,
  }) {
    return NavigationState(
      currentTab: currentTab ?? this.currentTab,
      isLoading: isLoading ?? this.isLoading,
      error: error, // Allow null to clear errors
    );
  }

  bool get hasError => error != null;

  @override
  List<Object?> get props => [currentTab, isLoading, error];

  @override
  String toString() {
    return 'NavigationState(currentTab: $currentTab, isLoading: $isLoading, error: $error)';
  }
}
