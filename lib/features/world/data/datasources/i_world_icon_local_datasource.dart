import 'package:innerverse/features/world/data/models/world_icon_model.dart';

/// Interface for local memory data source operations
abstract class IWorldIconLocalDatasource {
  /// Initialize the data source
  Future<void> init();

  /// Add a new memory
  ///
  /// [WorldIcon] The WorldIcon to be added
  Future<void> addWorldIcon(WorldIconModel worldIcon);

  /// Update an existing memory
  ///
  /// [WorldIcon] The WorldIcon to be updated
  Future<void> updateWorldIcon(WorldIconModel worldIcon);

  /// Delete a memory by its ID
  ///
  /// [id] The ID of the memory to delete
  Future<void> deleteWorldIcon(String id);

  /// Get a memory by its ID
  ///
  /// [id] The ID of the memory to retrieve
  /// Returns the memory if found, null otherwise
  WorldIconModel? getWorldIcon(String id);

  /// Get all memories
  ///
  /// Returns a list of all memories
  List<WorldIconModel> getAllWorldIcons();

  /// Clear all memories
  ///
  /// Removes all memories from storage
  Future<void> clearAllWorldIcons();
}
