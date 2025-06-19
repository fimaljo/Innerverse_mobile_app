import 'package:dartz/dartz.dart';
import 'package:innerverse/features/memory/domain/entities/memory_creation_data.dart';
import 'package:innerverse/features/memory/domain/failures/memory_failure.dart';
import 'package:innerverse/features/memory/domain/usecases/base_usecase.dart';

/// Use case for validating memory creation data
class ValidateMemoryCreationDataUseCase
    implements BaseUseCase<bool, MemoryCreationData> {
  const ValidateMemoryCreationDataUseCase();

  @override
  Future<Either<MemoryFailure, bool>> call(MemoryCreationData params) async {
    try {
      final errors = params.validationErrors;

      if (errors.isNotEmpty) {
        return left(const MemoryFailure.invalidData());
      }

      return right(true);
    } on Exception {
      return left(const MemoryFailure.unexpected());
    }
  }
}
