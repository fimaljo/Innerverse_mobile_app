import 'package:dartz/dartz.dart';
import 'package:innerverse/features/entries/domain/entities/entry.dart';
import 'package:innerverse/features/entries/domain/failures/entries_failure.dart';
import 'package:innerverse/features/entries/domain/repositories/entries_repository.dart';
import 'package:innerverse/features/entries/domain/usecases/base_usecase.dart';

class SearchEntriesParams {
  const SearchEntriesParams(this.query);
  final String query;
}

class SearchEntriesUseCase
    implements BaseUseCase<List<Entry>, SearchEntriesParams> {
  SearchEntriesUseCase(this.repository);
  final EntriesRepository repository;

  @override
  Future<Either<EntriesFailure, List<Entry>>> call(
      SearchEntriesParams params) async {
    return repository.searchEntries(params.query);
  }
}
