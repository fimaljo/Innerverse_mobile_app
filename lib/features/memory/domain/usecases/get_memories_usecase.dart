import 'package:dartz/dartz.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';
import 'package:innerverse/features/memory/domain/failures/memory_failure.dart';
import 'package:innerverse/features/memory/domain/repositories/i_memory_repository.dart';
import 'package:innerverse/features/memory/domain/usecases/base_usecase.dart';

class GetMemoriesUseCase implements BaseUseCase<List<Memory>, NoParams> {
  GetMemoriesUseCase(this._repository);
  final IMemoryRepository _repository;

  @override
  Future<Either<MemoryFailure, List<Memory>>> call(NoParams params) async {
    try {
      return _repository.getAllMemories();
    } on Exception {
      return left(const MemoryFailure.unexpected());
    }
  }
}
