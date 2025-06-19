import 'package:dartz/dartz.dart';

/// Base class for all use cases
abstract class BaseUseCase<Type, Params, Failure> {
  /// Execute the use case
  ///
  /// [params] The parameters required for the use case
  /// Returns the result of the use case wrapped in Either
  Future<Either<Failure, Type>> call(Params params);
}

/// Class for use cases that don't require parameters
class NoParams {
  const NoParams();
}
