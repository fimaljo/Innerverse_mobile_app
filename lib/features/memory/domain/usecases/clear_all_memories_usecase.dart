import 'package:dartz/dartz.dart';
import 'package:innerverse/features/memory/domain/failures/memory_failure.dart';
import 'package:innerverse/features/memory/domain/repositories/i_memory_repository.dart';
import 'package:innerverse/features/memory/domain/usecases/base_usecase.dart';

class ClearAllMemoriesUseCase implements BaseUseCase<void, NoParams> {
  ClearAllMemoriesUseCase(this._repository);
  final IMemoryRepository _repository;

  @override
  Future<Either<MemoryFailure, void>> call(NoParams params) async {
    try {
      return await _repository.clearAllMemories();
    } on Exception {
      return left(const MemoryFailure.unexpected());
    }
  }
}
