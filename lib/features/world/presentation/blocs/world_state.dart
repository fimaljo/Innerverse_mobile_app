import 'package:equatable/equatable.dart';
import 'package:innerverse/features/world/domain/entities/world.dart';
import 'package:innerverse/features/world/domain/usecases/get_all_worlds_with_tree_growth_usecase.dart';

class WorldState extends Equatable {
  const WorldState({
    this.worlds = const [],
    this.isLoading = false,
    this.error,
    // Tree growth visualization data
    this.averageEmotionValue = 0.0,
    this.treeGrowthValue = 0.0,
    this.isNightMode = false,
    this.memoryCount = 0,
    // Enhanced day/night system
    this.isRaining = false,
    this.daysSinceLastMemory = 0,
    this.currentHour = 0,
    this.isTimeBasedNight = false,
    // Worlds with individual tree growth
    this.worldsWithTreeGrowth = const [],
    this.selectedWorldId,
  });

  final List<World> worlds;
  final bool isLoading;
  final String? error;

  // Tree growth visualization properties
  final double averageEmotionValue;
  final double treeGrowthValue;
  final bool isNightMode;
  final int memoryCount;

  // Enhanced day/night system properties
  final bool isRaining;
  final int daysSinceLastMemory;
  final int currentHour;
  final bool isTimeBasedNight;

  // Worlds with individual tree growth
  final List<WorldWithTreeGrowth> worldsWithTreeGrowth;
  final String? selectedWorldId;

  WorldState copyWith({
    List<World>? worlds,
    bool? isLoading,
    String? error,
    double? averageEmotionValue,
    double? treeGrowthValue,
    bool? isNightMode,
    int? memoryCount,
    bool? isRaining,
    int? daysSinceLastMemory,
    int? currentHour,
    bool? isTimeBasedNight,
    List<WorldWithTreeGrowth>? worldsWithTreeGrowth,
    String? selectedWorldId,
  }) {
    return WorldState(
      worlds: worlds ?? this.worlds,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      averageEmotionValue: averageEmotionValue ?? this.averageEmotionValue,
      treeGrowthValue: treeGrowthValue ?? this.treeGrowthValue,
      isNightMode: isNightMode ?? this.isNightMode,
      memoryCount: memoryCount ?? this.memoryCount,
      isRaining: isRaining ?? this.isRaining,
      daysSinceLastMemory: daysSinceLastMemory ?? this.daysSinceLastMemory,
      currentHour: currentHour ?? this.currentHour,
      isTimeBasedNight: isTimeBasedNight ?? this.isTimeBasedNight,
      worldsWithTreeGrowth: worldsWithTreeGrowth ?? this.worldsWithTreeGrowth,
      selectedWorldId: selectedWorldId ?? this.selectedWorldId,
    );
  }

  @override
  List<Object?> get props => [
        worlds,
        isLoading,
        error,
        averageEmotionValue,
        treeGrowthValue,
        isNightMode,
        memoryCount,
        isRaining,
        daysSinceLastMemory,
        currentHour,
        isTimeBasedNight,
        worldsWithTreeGrowth,
        selectedWorldId,
      ];
}
