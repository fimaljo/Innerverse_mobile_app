import 'package:dartz/dartz.dart';
import 'package:innerverse/features/cloud_storage/domain/failures/cloud_storage_failure.dart';
import 'package:innerverse/features/cloud_storage/domain/repositories/cloud_storage_repository.dart';
import 'package:innerverse/features/cloud_storage/domain/usecases/base_usecase.dart';

class AuthenticateUseCase implements BaseUseCase<bool, NoParams> {
  const AuthenticateUseCase(this.repository);

  final CloudStorageRepository repository;

  @override
  Future<Either<CloudStorageFailure, bool>> call(NoParams params) {
    return repository.authenticate();
  }
}
