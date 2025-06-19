import 'package:dartz/dartz.dart';
import 'package:innerverse/features/world/domain/failures/world_failure.dart';
import 'package:innerverse/features/world/domain/repositories/i_world_icon_repository.dart';
import 'package:innerverse/features/world/domain/usecases/base_usecase.dart';

class DeleteWorldUseCase implements BaseUseCase<Unit, String, WorldFailure> {
  DeleteWorldUseCase(this._repository);
  final IWorldIconRepository _repository;

  @override
  Future<Either<WorldFailure, Unit>> call(String params) async {
    try {
      final result = await _repository.deleteWorldIcon(params);
      return result.map((_) => unit);
    } on Exception {
      return left(const WorldFailure.unexpected());
    }
  }
}
