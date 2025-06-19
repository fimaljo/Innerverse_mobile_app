import 'package:dartz/dartz.dart';
import 'package:innerverse/features/world/domain/entities/world.dart';
import 'package:innerverse/features/world/domain/failures/world_failure.dart';
import 'package:innerverse/features/world/domain/repositories/i_world_icon_repository.dart';
import 'package:innerverse/features/world/domain/usecases/base_usecase.dart';

class UpdateWorldUseCase implements BaseUseCase<World, World, WorldFailure> {
  UpdateWorldUseCase(this._repository);
  final IWorldIconRepository _repository;

  @override
  Future<Either<WorldFailure, World>> call(World params) async {
    try {
      final result = await _repository.updateWorldIcon(params);
      return result.map((_) => params);
    } on Exception {
      return left(const WorldFailure.unexpected());
    }
  }
}
