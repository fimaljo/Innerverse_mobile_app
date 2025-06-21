import 'package:dartz/dartz.dart';
import 'package:innerverse/features/world/domain/entities/world.dart';
import 'package:innerverse/features/world/domain/failures/world_failure.dart';
import 'package:innerverse/features/world/domain/repositories/i_world_icon_repository.dart';
import 'package:innerverse/features/world/domain/repositories/world_repository.dart';

class WorldRepositoryImpl implements WorldRepository {
  WorldRepositoryImpl(this._worldIconRepository);
  final IWorldIconRepository _worldIconRepository;

  @override
  Future<Either<WorldFailure, List<World>>> getAllWorlds() async {
    try {
      final result = _worldIconRepository.getAllWorldIcons();
      return result;
    } on Exception {
      return left(const WorldFailure.storageError());
    }
  }

  @override
  Future<Either<WorldFailure, World>> addWorld(World world) async {
    try {
      final result = await _worldIconRepository.addWorldIcon(world);
      return result.map((_) => world);
    } on Exception {
      return left(const WorldFailure.storageError());
    }
  }

  @override
  Future<Either<WorldFailure, World>> updateWorld(World world) async {
    try {
      final result = await _worldIconRepository.updateWorldIcon(world);
      return result.map((_) => world);
    } on Exception {
      return left(const WorldFailure.storageError());
    }
  }

  @override
  Future<Either<WorldFailure, Unit>> deleteWorld(String id) async {
    try {
      final result = await _worldIconRepository.deleteWorldIcon(id);
      return result.map((_) => unit);
    } on Exception {
      return left(const WorldFailure.storageError());
    }
  }
}
