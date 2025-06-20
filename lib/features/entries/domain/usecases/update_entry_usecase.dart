import 'package:dartz/dartz.dart';
import 'package:innerverse/features/entries/domain/entities/entry.dart';
import 'package:innerverse/features/entries/domain/failures/entries_failure.dart';
import 'package:innerverse/features/entries/domain/repositories/entries_repository.dart';
import 'package:innerverse/features/entries/domain/usecases/base_usecase.dart';

class UpdateEntryParams {
  final Entry entry;

  const UpdateEntryParams(this.entry);
}

class UpdateEntryUseCase implements BaseUseCase<void, UpdateEntryParams> {
  final EntriesRepository repository;

  UpdateEntryUseCase(this.repository);

  @override
  Future<Either<EntriesFailure, void>> call(UpdateEntryParams params) async {
    return await repository.updateEntry(params.entry);
  }
}
