import 'package:dartz/dartz.dart';
import 'package:innerverse/features/entries/domain/entities/entry.dart';
import 'package:innerverse/features/entries/domain/failures/entries_failure.dart';

abstract class EntriesRepository {
  Future<Either<EntriesFailure, List<Entry>>> getAllEntries();
  Future<Either<EntriesFailure, List<Entry>>> getEntriesByDateRange(
      DateTime startDate, DateTime endDate);
  Future<Either<EntriesFailure, List<Entry>>> searchEntries(String query);
}
