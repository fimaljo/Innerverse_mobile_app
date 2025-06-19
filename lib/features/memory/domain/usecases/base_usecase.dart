import 'package:dartz/dartz.dart';
import 'package:innerverse/features/memory/domain/failures/memory_failure.dart';

/// Base class for all use cases
abstract class BaseUseCase<Type, Params> {
  /// Execute the use case
  ///
  /// [params] The parameters required for the use case
  /// Returns the result of the use case wrapped in Either
  Future<Either<MemoryFailure, Type>> call(Params params);
}

/// Class for use cases that don't require parameters
class NoParams {
  const NoParams();
}
