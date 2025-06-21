import 'package:dartz/dartz.dart';
import 'package:innerverse/features/entries/domain/failures/entries_failure.dart';
import 'package:innerverse/features/entries/domain/repositories/entries_repository.dart';
import 'package:innerverse/features/entries/domain/usecases/base_usecase.dart';

class DeleteEntryParams {
  const DeleteEntryParams(this.id);
  final String id;
}

class DeleteEntryUseCase implements BaseUseCase<void, DeleteEntryParams> {
  DeleteEntryUseCase(this.repository);
  final EntriesRepository repository;

  @override
  Future<Either<EntriesFailure, void>> call(DeleteEntryParams params) async {
    return repository.deleteEntry(params.id);
  }
}
