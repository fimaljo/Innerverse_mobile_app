import 'package:dartz/dartz.dart';
import 'package:innerverse/features/entries/domain/entities/entry.dart';
import 'package:innerverse/features/entries/domain/failures/entries_failure.dart';

abstract class EntriesRepository {
  Future<Either<EntriesFailure, List<Entry>>> getAllEntries();
  Future<Either<EntriesFailure, List<Entry>>> getEntriesByDateRange(
      DateTime startDate, DateTime endDate);
  Future<Either<EntriesFailure, List<Entry>>> searchEntries(String query);

  /// Update an existing entry
  ///
  /// [entry] The entry to be updated
  Future<Either<EntriesFailure, void>> updateEntry(Entry entry);

  /// Delete an entry by its ID
  ///
  /// [id] The ID of the entry to delete
  Future<Either<EntriesFailure, void>> deleteEntry(String id);
}
