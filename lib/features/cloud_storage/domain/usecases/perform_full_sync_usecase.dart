import 'package:dartz/dartz.dart';
import 'package:innerverse/features/cloud_storage/domain/entities/sync_status.dart';
import 'package:innerverse/features/cloud_storage/domain/failures/cloud_storage_failure.dart';
import 'package:innerverse/features/cloud_storage/domain/repositories/cloud_storage_repository.dart';
import 'package:innerverse/features/cloud_storage/domain/usecases/base_usecase.dart';

class PerformFullSyncUseCase implements BaseUseCase<SyncStatus, NoParams> {
  const PerformFullSyncUseCase(this.repository);

  final CloudStorageRepository repository;

  @override
  Future<Either<CloudStorageFailure, SyncStatus>> call(NoParams params) {
    return repository.performFullSync();
  }
}
