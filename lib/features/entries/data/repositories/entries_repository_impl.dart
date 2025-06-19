import 'package:dartz/dartz.dart';
import 'package:innerverse/features/entries/domain/entities/entry.dart';
import 'package:innerverse/features/entries/domain/failures/entries_failure.dart';
import 'package:innerverse/features/entries/domain/repositories/entries_repository.dart';
import 'package:innerverse/features/memory/domain/failures/memory_failure.dart';
import 'package:innerverse/features/memory/domain/repositories/i_memory_repository.dart';

class EntriesRepositoryImpl implements EntriesRepository {
  final IMemoryRepository memoryRepository;

  EntriesRepositoryImpl(this.memoryRepository);

  @override
  Future<Either<EntriesFailure, List<Entry>>> getAllEntries() async {
    final result = memoryRepository.getAllMemories();
    return result.fold(
      (memoryFailure) => Left(_mapMemoryFailureToEntriesFailure(memoryFailure)),
      (memories) => Right(memories),
    );
  }

  @override
  Future<Either<EntriesFailure, List<Entry>>> getEntriesByDateRange(
      DateTime startDate, DateTime endDate) async {
    final result = memoryRepository.getMemoriesByDateRange(startDate, endDate);
    return result.fold(
      (memoryFailure) => Left(_mapMemoryFailureToEntriesFailure(memoryFailure)),
      (memories) => Right(memories),
    );
  }

  @override
  Future<Either<EntriesFailure, List<Entry>>> searchEntries(
      String query) async {
    // For now, we'll get all entries and filter them
    // In a real implementation, you might want to implement search at the data source level
    final result = await getAllEntries();
    return result.fold(
      (failure) => Left(failure),
      (entries) {
        if (query.isEmpty) return Right(entries);

        final filteredEntries = entries.where((entry) {
          final title = entry.title?.toLowerCase() ?? '';
          final description = entry.description?.toLowerCase() ?? '';
          final emojiLabel = entry.emojiLabel.toLowerCase();
          final searchQuery = query.toLowerCase();

          return title.contains(searchQuery) ||
              description.contains(searchQuery) ||
              emojiLabel.contains(searchQuery);
        }).toList();

        return Right(filteredEntries);
      },
    );
  }

  EntriesFailure _mapMemoryFailureToEntriesFailure(
      MemoryFailure memoryFailure) {
    return memoryFailure.when(
      unexpected: () => const EntriesFailure.unexpected(),
      notFound: () => const EntriesFailure.notFound(),
      invalidData: () => const EntriesFailure.invalidData(),
      storageError: () => const EntriesFailure.storageError(),
    );
  }
}
