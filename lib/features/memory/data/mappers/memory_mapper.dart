import 'package:innerverse/features/memory/data/models/memory_model.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';
import 'package:innerverse/features/world/data/models/world_icon_model.dart';

/// Helper class for mapping between domain and data models
class MemoryMapper {
  /// Converts a domain entity to a data model
  static MemoryModel toModel(Memory memory) {
    return MemoryModel(
      id: memory.id,
      emojiLabel: memory.emojiLabel,
      riveAsset: memory.riveAsset,
      emotionSliderValue: memory.emotionSliderValue,
      dateTime: memory.dateTime,
      time: memory.time,
      worldIcon: WorldIconModel(
        id: memory.id,
        name: memory.worldIconTitle,
        icon: memory.worldIcon,
      ),
      title: memory.title,
      description: memory.description,
    );
  }

  /// Converts a data model to a domain entity
  static Memory toEntity(MemoryModel model) {
    return Memory(
      id: model.id,
      emojiLabel: model.emojiLabel,
      riveAsset: model.riveAsset,
      emotionSliderValue: model.emotionSliderValue,
      dateTime: model.dateTime,
      time: model.time,
      worldIcon: model.worldIcon.icon,
      worldIconTitle: model.worldIcon.name,
      title: model.title,
      description: model.description,
    );
  }

  /// Converts a list of domain entities to data models
  static List<MemoryModel> toModelList(List<Memory> memories) {
    return memories.map(toModel).toList();
  }

  /// Converts a list of data models to domain entities
  static List<Memory> toEntityList(List<MemoryModel> models) {
    return models.map(toEntity).toList();
  }
}
