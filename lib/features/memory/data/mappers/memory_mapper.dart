import 'package:innerverse/features/memory/data/models/memory_model.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';

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
      worldIcons: memory.worldIcons,
      title: memory.title,
      description: memory.description,
      images: memory.images,
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
      worldIcons: model.worldIcons,
      title: model.title,
      description: model.description,
      images: model.images,
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
