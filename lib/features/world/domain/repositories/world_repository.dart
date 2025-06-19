import 'package:dartz/dartz.dart';
import 'package:innerverse/features/world/domain/entities/world.dart';
import 'package:innerverse/features/world/domain/failures/world_failure.dart';

abstract class WorldRepository {
  Future<Either<WorldFailure, List<World>>> getAllWorlds();
  Future<Either<WorldFailure, World>> addWorld(World world);
  Future<Either<WorldFailure, World>> updateWorld(World world);
  Future<Either<WorldFailure, Unit>> deleteWorld(String id);
}
