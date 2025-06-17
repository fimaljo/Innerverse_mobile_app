import 'package:dartz/dartz.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';
import 'package:innerverse/features/memory/domain/failures/memory_failure.dart';

/// Interface for memory repository operations
abstract class IMemoryRepository {
  /// Initialize the repository
  Future<Either<MemoryFailure, void>> init();

  /// Add a new memory
  ///
  /// [memory] The memory to be added
  Future<Either<MemoryFailure, void>> addMemory(Memory memory);

  /// Update an existing memory
  ///
  /// [memory] The memory to be updated
  Future<Either<MemoryFailure, void>> updateMemory(Memory memory);

  /// Delete a memory by its ID
  ///
  /// [id] The ID of the memory to delete
  Future<Either<MemoryFailure, void>> deleteMemory(String id);

  /// Get a memory by its ID
  ///
  /// [id] The ID of the memory to retrieve
  /// Returns the memory if found, null otherwise
  Either<MemoryFailure, Memory?> getMemory(String id);

  /// Get all memories
  ///
  /// Returns a list of all memories
  Either<MemoryFailure, List<Memory>> getAllMemories();

  /// Get memories within a date range
  ///
  /// [start] The start date of the range
  /// [end] The end date of the range
  /// Returns a list of memories within the specified date range
  Either<MemoryFailure, List<Memory>> getMemoriesByDateRange(
    DateTime start,
    DateTime end,
  );

  /// Clear all memories
  ///
  /// Removes all memories from storage
  Future<Either<MemoryFailure, void>> clearAllMemories();
}
