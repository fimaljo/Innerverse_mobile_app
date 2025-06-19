import 'package:dartz/dartz.dart';
import 'package:innerverse/features/cloud_storage/domain/failures/cloud_storage_failure.dart';
import 'package:innerverse/features/cloud_storage/domain/repositories/cloud_storage_repository.dart';
import 'package:innerverse/features/cloud_storage/domain/usecases/base_usecase.dart';

class UploadHiveBoxParams {
  const UploadHiveBoxParams({
    required this.boxName,
    required this.data,
  });

  final String boxName;
  final List<int> data;
}

class UploadHiveBoxUseCase implements BaseUseCase<String, UploadHiveBoxParams> {
  const UploadHiveBoxUseCase(this.repository);

  final CloudStorageRepository repository;

  @override
  Future<Either<CloudStorageFailure, String>> call(UploadHiveBoxParams params) {
    return repository.uploadHiveBox(params.boxName, params.data);
  }
}
