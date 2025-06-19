import 'package:dartz/dartz.dart';
import 'package:innerverse/features/entries/domain/entities/entry.dart';
import 'package:innerverse/features/entries/domain/failures/entries_failure.dart';
import 'package:innerverse/features/entries/domain/repositories/entries_repository.dart';
import 'package:innerverse/features/entries/domain/usecases/base_usecase.dart';

class GetAllEntriesUseCase implements BaseUseCase<List<Entry>, NoParams> {
  final EntriesRepository repository;

  GetAllEntriesUseCase(this.repository);

  @override
  Future<Either<EntriesFailure, List<Entry>>> call(NoParams params) async {
    return await repository.getAllEntries();
  }
}
