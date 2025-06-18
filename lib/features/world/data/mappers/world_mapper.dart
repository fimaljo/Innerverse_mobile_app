import 'package:innerverse/features/world/data/models/world_icon_model.dart';
import 'package:innerverse/features/world/domain/entities/world.dart';

class WorldMapper {
  static WorldIconModel toModel(World world) {
    return WorldIconModel(
      id: world.id,
      name: world.name,
      icon: world.icon,
    );
  }

  static World toEntity(
    WorldIconModel model,
  ) {
    return World(
      id: model.id,
      name: model.name,
      icon: model.icon,
    );
  }

  static List<WorldIconModel> toModelList(List<World> worlds) {
    return worlds.map((world) => toModel(world)).toList();
  }

  static List<World> toEntityList(
    List<WorldIconModel> models, {
    required Map<String, DateTime> createdAts,
    required Map<String, DateTime> updatedAts,
  }) {
    return models
        .map((model) => toEntity(
              model,
            ))
        .toList();
  }
}
