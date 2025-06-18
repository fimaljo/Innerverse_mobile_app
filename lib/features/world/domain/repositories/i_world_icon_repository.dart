import 'package:dartz/dartz.dart';
import 'package:innerverse/features/world/domain/entities/world.dart';
import 'package:innerverse/features/world/domain/failures/world_failure.dart';

/// Interface for world repository operations
abstract class IWorldIconRepository {
  /// Initialize the repository
  Future<Either<WorldFailure, void>> init();

  /// Add a new world
  ///
  /// [World] The world to be added
  Future<Either<WorldFailure, void>> addWorldIcon(World world);

  /// Update an existing world
  ///
  /// [World] The world to be updated
  Future<Either<WorldFailure, void>> updateWorldIcon(World world);

  /// Delete a world by its ID
  ///
  /// [id] The ID of the world to delete
  Future<Either<WorldFailure, void>> deleteWorldIcon(String id);

  /// Get a world by its ID
  ///
  /// [id] The ID of the world to retrieve
  /// Returns the world if found, null otherwise
  Either<WorldFailure, World?> getWorldIcon(String id);

  /// Get all worlds
  ///
  /// Returns a list of all worlds
  Either<WorldFailure, List<World>> getAllWorldIcons();

  /// Clear all worlds
  ///
  /// Removes all worlds from storage
  Future<Either<WorldFailure, void>> clearAllWorldIcons();
}
