import 'package:dartz/dartz.dart';
import 'package:innerverse/features/world/data/datasources/i_world_icon_local_datasource.dart';
import 'package:innerverse/features/world/data/mappers/world_mapper.dart';
import 'package:innerverse/features/world/domain/entities/world.dart';
import 'package:innerverse/features/world/domain/failures/world_failure.dart';
import 'package:innerverse/features/world/domain/repositories/i_world_icon_repository.dart';

class WorldIconRepositoryImpl implements IWorldIconRepository {
  WorldIconRepositoryImpl(this._localDataSource);
  final IWorldIconLocalDatasource _localDataSource;

  @override
  Future<Either<WorldFailure, void>> init() async {
    try {
      await _localDataSource.init();
      return right(null);
    } on Exception {
      return left(const WorldFailure.storageError());
    }
  }

  @override
  Future<Either<WorldFailure, void>> addWorldIcon(World world) async {
    try {
      final model = WorldMapper.toModel(world);
      await _localDataSource.addWorldIcon(model);
      return right(null);
    } on Exception {
      return left(const WorldFailure.storageError());
    }
  }

  @override
  Future<Either<WorldFailure, void>> clearAllWorldIcons() async {
    try {
      await _localDataSource.clearAllWorldIcons();
      return right(null);
    } on Exception {
      return left(const WorldFailure.storageError());
    }
  }

  @override
  Future<Either<WorldFailure, void>> deleteWorldIcon(String id) async {
    try {
      await _localDataSource.deleteWorldIcon(id);
      return right(null);
    } on Exception {
      return left(const WorldFailure.storageError());
    }
  }

  @override
  Future<Either<WorldFailure, void>> updateWorldIcon(World world) async {
    try {
      final model = WorldMapper.toModel(world);
      await _localDataSource.updateWorldIcon(model);
      return right(null);
    } on Exception {
      return left(const WorldFailure.storageError());
    }
  }

  @override
  Either<WorldFailure, World?> getWorldIcon(String id) {
    try {
      final model = _localDataSource.getWorldIcon(id);
      if (model == null) {
        return right(null);
      }
      return right(WorldMapper.toEntity(model));
    } on Exception {
      return left(const WorldFailure.storageError());
    }
  }

  @override
  Either<WorldFailure, List<World>> getAllWorldIcons() {
    try {
      final models = _localDataSource.getAllWorldIcons();
      return right(models.map(WorldMapper.toEntity).toList());
    } on Exception {
      return left(const WorldFailure.storageError());
    }
  }
}
