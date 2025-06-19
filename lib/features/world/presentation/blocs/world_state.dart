import 'package:equatable/equatable.dart';
import 'package:innerverse/features/world/domain/entities/world.dart';

class WorldState extends Equatable {
  const WorldState({
    this.worlds = const [],
    this.isLoading = false,
    this.error,
  });

  final List<World> worlds;
  final bool isLoading;
  final String? error;

  WorldState copyWith({
    List<World>? worlds,
    bool? isLoading,
    String? error,
  }) {
    return WorldState(
      worlds: worlds ?? this.worlds,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [worlds, isLoading, error];
}
