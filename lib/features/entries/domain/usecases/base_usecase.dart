import 'package:dartz/dartz.dart';
import 'package:innerverse/features/entries/domain/failures/entries_failure.dart';

/// Base class for all entries use cases
abstract class BaseUseCase<Type, Params> {
  /// Execute the use case
  ///
  /// [params] The parameters required for the use case
  /// Returns the result of the use case wrapped in Either
  Future<Either<EntriesFailure, Type>> call(Params params);
}

/// Class for use cases that don't require parameters
class NoParams {
  const NoParams();
}
