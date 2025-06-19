import 'package:dartz/dartz.dart';
import 'package:innerverse/features/world/domain/entities/world.dart';
import 'package:innerverse/features/world/domain/failures/world_failure.dart';
import 'package:innerverse/features/world/domain/repositories/i_world_icon_repository.dart';
import 'package:innerverse/features/world/domain/usecases/base_usecase.dart';

class GetAllWorldsUseCase
    implements BaseUseCase<List<World>, NoParams, WorldFailure> {
  GetAllWorldsUseCase(this._repository);
  final IWorldIconRepository _repository;

  @override
  Future<Either<WorldFailure, List<World>>> call(NoParams params) async {
    try {
      return _repository.getAllWorldIcons();
    } on Exception {
      return left(const WorldFailure.unexpected());
    }
  }
}
