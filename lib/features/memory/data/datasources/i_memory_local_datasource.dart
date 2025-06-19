import 'package:innerverse/features/memory/data/models/memory_model.dart';

/// Interface for local memory data source operations
abstract class IMemoryLocalDataSource {
  /// Initialize the data source
  Future<void> init();

  /// Add a new memory
  ///
  /// [memory] The memory to be added
  Future<void> addMemory(MemoryModel memory);

  /// Update an existing memory
  ///
  /// [memory] The memory to be updated
  Future<void> updateMemory(MemoryModel memory);

  /// Delete a memory by its ID
  ///
  /// [id] The ID of the memory to delete
  Future<void> deleteMemory(String id);

  /// Get a memory by its ID
  ///
  /// [id] The ID of the memory to retrieve
  /// Returns the memory if found, null otherwise
  MemoryModel? getMemory(String id);

  /// Get all memories
  ///
  /// Returns a list of all memories
  List<MemoryModel> getAllMemories();

  /// Get memories within a date range
  ///
  /// [start] The start date of the range
  /// [end] The end date of the range
  /// Returns a list of memories within the specified date range
  List<MemoryModel> getMemoriesByDateRange(DateTime start, DateTime end);

  /// Clear all memories
  ///
  /// Removes all memories from storage
  Future<void> clearAllMemories();
}
