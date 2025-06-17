import 'package:dartz/dartz.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';
import 'package:innerverse/features/memory/domain/failures/memory_failure.dart';
import 'package:innerverse/features/memory/domain/repositories/i_memory_repository.dart';
import 'package:innerverse/features/memory/domain/usecases/base_usecase.dart';

class DateRangeParams {
  final DateTime start;
  final DateTime end;

  const DateRangeParams({
    required this.start,
    required this.end,
  });
}

class GetMemoriesByDateRangeUseCase
    implements BaseUseCase<List<Memory>, DateRangeParams> {
  final IMemoryRepository _repository;

  GetMemoriesByDateRangeUseCase(this._repository);

  @override
  Future<Either<MemoryFailure, List<Memory>>> call(
    DateRangeParams params,
  ) async {
    try {
      return _repository.getMemoriesByDateRange(params.start, params.end);
    } catch (e) {
      return left(const MemoryFailure.unexpected());
    }
  }
}
