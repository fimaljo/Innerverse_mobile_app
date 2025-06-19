import 'package:dartz/dartz.dart';
import 'package:innerverse/features/entries/domain/entities/entry.dart';
import 'package:innerverse/features/entries/domain/failures/entries_failure.dart';
import 'package:innerverse/features/entries/domain/repositories/entries_repository.dart';
import 'package:innerverse/features/entries/domain/usecases/base_usecase.dart';

class SearchEntriesParams {
  final String query;

  const SearchEntriesParams(this.query);
}

class SearchEntriesUseCase
    implements BaseUseCase<List<Entry>, SearchEntriesParams> {
  final EntriesRepository repository;

  SearchEntriesUseCase(this.repository);

  @override
  Future<Either<EntriesFailure, List<Entry>>> call(
      SearchEntriesParams params) async {
    return await repository.searchEntries(params.query);
  }
}
