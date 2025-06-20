import 'package:dartz/dartz.dart';
import 'package:innerverse/features/entries/domain/failures/entries_failure.dart';
import 'package:innerverse/features/entries/domain/repositories/entries_repository.dart';
import 'package:innerverse/features/entries/domain/usecases/base_usecase.dart';

class DeleteEntryParams {
  final String id;

  const DeleteEntryParams(this.id);
}

class DeleteEntryUseCase implements BaseUseCase<void, DeleteEntryParams> {
  final EntriesRepository repository;

  DeleteEntryUseCase(this.repository);

  @override
  Future<Either<EntriesFailure, void>> call(DeleteEntryParams params) async {
    return await repository.deleteEntry(params.id);
  }
}
