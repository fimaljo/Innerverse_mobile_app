import 'package:dartz/dartz.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';
import 'package:innerverse/features/memory/domain/failures/memory_failure.dart';
import 'package:innerverse/features/memory/domain/repositories/i_memory_repository.dart';
import 'package:innerverse/features/memory/domain/usecases/base_usecase.dart';

class GetMemoryByIdUseCase implements BaseUseCase<Memory?, String> {
  final IMemoryRepository _repository;

  GetMemoryByIdUseCase(this._repository);

  @override
  Future<Either<MemoryFailure, Memory?>> call(String id) async {
    try {
      return _repository.getMemory(id);
    } catch (e) {
      return left(const MemoryFailure.unexpected());
    }
  }
}
