import 'package:dartz/dartz.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';
import 'package:innerverse/features/memory/domain/failures/memory_failure.dart';
import 'package:innerverse/features/memory/domain/repositories/i_memory_repository.dart';
import 'package:innerverse/features/memory/domain/usecases/base_usecase.dart';

class AddMemoryUseCase implements BaseUseCase<void, Memory> {
  final IMemoryRepository _repository;

  AddMemoryUseCase(this._repository);

  @override
  Future<Either<MemoryFailure, void>> call(Memory memory) async {
    try {
      final result = await _repository.addMemory(memory);
      return result;
    } catch (e) {
      return left(const MemoryFailure.unexpected());
    }
  }
}
