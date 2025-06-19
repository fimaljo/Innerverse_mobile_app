import 'package:dartz/dartz.dart';
import 'package:innerverse/features/memory/domain/entities/memory_creation_data.dart';
import 'package:innerverse/features/memory/domain/failures/memory_failure.dart';
import 'package:innerverse/features/memory/domain/repositories/i_memory_repository.dart';
import 'package:innerverse/features/memory/domain/usecases/base_usecase.dart';

/// Use case for saving memory drafts
class SaveMemoryDraftUseCase implements BaseUseCase<void, MemoryCreationData> {
  const SaveMemoryDraftUseCase(this._repository);

  final IMemoryRepository _repository;

  @override
  Future<Either<MemoryFailure, void>> call(MemoryCreationData params) async {
    try {
      // Convert to memory and save as draft
      final memory = params.toMemory();
      final result = await _repository.addMemory(memory);
      return result;
    } on Exception {
      return left(const MemoryFailure.storageError());
    }
  }
}
