import 'package:dartz/dartz.dart';
import 'package:innerverse/features/memory/domain/repositories/i_memory_repository.dart';
import 'package:innerverse/features/world/domain/usecases/base_usecase.dart';
import 'package:innerverse/features/world/domain/failures/world_failure.dart';

class TreeGrowthData {
  const TreeGrowthData({
    required this.averageEmotionValue,
    required this.treeGrowthValue,
    required this.isNightMode,
    required this.memoryCount,
    required this.isRaining,
    required this.daysSinceLastMemory,
    required this.currentHour,
    required this.isTimeBasedNight,
  });

  final double averageEmotionValue;
  final double treeGrowthValue;
  final bool isNightMode;
  final int memoryCount;
  final bool isRaining;
  final int daysSinceLastMemory;
  final int currentHour;
  final bool isTimeBasedNight;
}

class CalculateTreeGrowthUseCase
    implements BaseUseCase<TreeGrowthData, NoParams, WorldFailure> {
  CalculateTreeGrowthUseCase(this._memoryRepository);

  final IMemoryRepository _memoryRepository;

  /// Calculate tree growth contribution based on emotion type and intensity
  double _calculateEmotionContribution(String emojiLabel, double intensity) {
    switch (emojiLabel.toLowerCase()) {
      case 'positive':
        // Positive emotions increase growth (0-10 intensity = 0-100% growth)
        return intensity;
      case 'neutral':
        // Neutral emotions have minimal positive effect (0-10 intensity = 0-20% growth)
        return intensity * 0.2;
      case 'sad':
        // Sad emotions decrease growth (0-10 intensity = 0 to -50% growth)
        return -intensity * 0.5;
      case 'angry':
        // Angry emotions significantly decrease growth (0-10 intensity = 0 to -80% growth)
        return -intensity * 0.8;
      case 'fearful':
        // Fearful emotions decrease growth (0-10 intensity = 0 to -60% growth)
        return -intensity * 0.6;
      default:
        // Unknown emotion type has neutral effect
        return 0.0;
    }
  }

  @override
  Future<Either<WorldFailure, TreeGrowthData>> call(NoParams params) async {
    try {
      final memoriesResult = await _memoryRepository.getAllMemories();

      return memoriesResult.fold(
        (failure) => left(WorldFailure.storageError()),
        (memories) {
          final now = DateTime.now();
          final currentHour = now.hour;

          // Calculate time-based night mode (6 PM to 6 AM)
          final isTimeBasedNight = currentHour < 6 || currentHour >= 18;

          if (memories.isEmpty) {
            return right(TreeGrowthData(
              averageEmotionValue: 0.0,
              treeGrowthValue: 0.0,
              isNightMode: isTimeBasedNight,
              memoryCount: 0,
              isRaining: true, // Always raining if no memories
              daysSinceLastMemory: 999, // Large number to indicate no memories
              currentHour: currentHour,
              isTimeBasedNight: isTimeBasedNight,
            ));
          }

          // Calculate emotion contributions for each memory
          double totalEmotionContribution = 0.0;
          double totalEmotionValue = 0.0;

          for (final memory in memories) {
            final emotionContribution = _calculateEmotionContribution(
              memory.emojiLabel,
              memory.emotionSliderValue,
            );
            totalEmotionContribution += emotionContribution;
            totalEmotionValue += memory.emotionSliderValue;
          }

          // Calculate average emotion value (for display purposes)
          final averageEmotionValue = totalEmotionValue / memories.length;

          // Calculate tree growth value (0-100)
          // Base growth from emotion contributions, normalized to 0-100 range
          final baseGrowth = totalEmotionContribution / memories.length;
          final treeGrowthValue =
              (baseGrowth + 5.0) * 10.0; // Shift to 0-100 range

          // Find the most recent memory
          final mostRecentMemory =
              memories.reduce((a, b) => a.dateTime.isAfter(b.dateTime) ? a : b);

          // Calculate days since last memory
          final daysSinceLastMemory =
              now.difference(mostRecentMemory.dateTime).inMinutes;

          // Determine if it's raining (no memories for 1+ minutes)
          final isRaining = daysSinceLastMemory >= 1;

          // Determine night mode: time-based OR raining (rain creates night effect)
          final isNightMode = isTimeBasedNight || isRaining;

          return right(TreeGrowthData(
            averageEmotionValue: averageEmotionValue,
            treeGrowthValue: treeGrowthValue.clamp(0.0, 100.0),
            isNightMode: isNightMode,
            memoryCount: memories.length,
            isRaining: isRaining,
            daysSinceLastMemory: daysSinceLastMemory,
            currentHour: currentHour,
            isTimeBasedNight: isTimeBasedNight,
          ));
        },
      );
    } catch (e) {
      return left(WorldFailure.storageError());
    }
  }
}
