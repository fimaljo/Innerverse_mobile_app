import 'package:dartz/dartz.dart';
import 'package:innerverse/features/entries/domain/entities/entry.dart';
import 'package:innerverse/features/entries/domain/failures/entries_failure.dart';
import 'package:innerverse/features/entries/domain/repositories/entries_repository.dart';
import 'package:innerverse/features/entries/domain/usecases/base_usecase.dart';

class UpdateEntryParams {
  const UpdateEntryParams(this.entry);
  final Entry entry;
}

class UpdateEntryUseCase implements BaseUseCase<void, UpdateEntryParams> {
  UpdateEntryUseCase(this.repository);
  final EntriesRepository repository;

  @override
  Future<Either<EntriesFailure, void>> call(UpdateEntryParams params) async {
    return repository.updateEntry(params.entry);
  }
}
