import 'package:dartz/dartz.dart';
import 'package:innerverse/features/memory/domain/failures/memory_failure.dart';
import 'package:innerverse/features/memory/domain/repositories/i_memory_repository.dart';
import 'package:innerverse/features/memory/domain/usecases/base_usecase.dart';

class DeleteMemoryUseCase implements BaseUseCase<void, String> {
  DeleteMemoryUseCase(this._repository);
  final IMemoryRepository _repository;

  @override
  Future<Either<MemoryFailure, void>> call(String id) async {
    try {
      final result = await _repository.deleteMemory(id);
      return result;
    } on Exception {
      return left(const MemoryFailure.unexpected());
    }
  }
}
