import 'package:dartz/dartz.dart';
import 'package:innerverse/features/memory/data/datasources/i_memory_local_datasource.dart';
import 'package:innerverse/features/memory/data/mappers/memory_mapper.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';
import 'package:innerverse/features/memory/domain/failures/memory_failure.dart';
import 'package:innerverse/features/memory/domain/repositories/i_memory_repository.dart';

class MemoryRepositoryImpl implements IMemoryRepository {
  MemoryRepositoryImpl(this._localDataSource);
  final IMemoryLocalDataSource _localDataSource;

  @override
  Future<Either<MemoryFailure, void>> init() async {
    try {
      await _localDataSource.init();
      return right(null);
    } on Exception {
      return left(const MemoryFailure.storageError());
    }
  }

  @override
  Future<Either<MemoryFailure, void>> addMemory(Memory memory) async {
    try {
      final model = MemoryMapper.toModel(memory);
      await _localDataSource.addMemory(model);
      return right(null);
    } on Exception {
      return left(const MemoryFailure.storageError());
    }
  }

  @override
  Future<Either<MemoryFailure, void>> updateMemory(Memory memory) async {
    print('🔄 MemoryRepository: Updating memory with ID: ${memory.id}');
    print('  - Title: "${memory.title}"');
    print('  - Description: "${memory.description}"');
    try {
      final model = MemoryMapper.toModel(memory);
      print('✅ MemoryRepository: Successfully converted to model');
      await _localDataSource.updateMemory(model);
      print('✅ MemoryRepository: Successfully updated in local data source');
      return right(null);
    } on Exception catch (e) {
      print('❌ MemoryRepository: Update failed with exception: $e');
      return left(const MemoryFailure.storageError());
    }
  }

  @override
  Future<Either<MemoryFailure, void>> deleteMemory(String id) async {
    try {
      await _localDataSource.deleteMemory(id);
      return right(null);
    } on Exception {
      return left(const MemoryFailure.storageError());
    }
  }

  @override
  Either<MemoryFailure, Memory?> getMemory(String id) {
    try {
      final model = _localDataSource.getMemory(id);
      if (model == null) {
        return right(null);
      }
      return right(MemoryMapper.toEntity(model));
    } on Exception {
      return left(const MemoryFailure.storageError());
    }
  }

  @override
  Either<MemoryFailure, List<Memory>> getAllMemories() {
    print('🔄 MemoryRepository: Getting all memories from local data source');
    try {
      final models = _localDataSource.getAllMemories();
      print(
          '✅ MemoryRepository: Retrieved ${models.length} memories from data source');
      final memories = models.map(MemoryMapper.toEntity).toList();
      print(
          '✅ MemoryRepository: Converted ${memories.length} models to entities');

      // Log each memory for debugging
      for (final memory in memories) {
        print(
            '  - ID: ${memory.id}, Title: "${memory.title}", Description: "${memory.description}"');
      }

      return right(memories);
    } on Exception catch (e) {
      print('❌ MemoryRepository: Failed to get all memories: $e');
      return left(const MemoryFailure.storageError());
    }
  }

  @override
  Either<MemoryFailure, List<Memory>> getMemoriesByDateRange(
    DateTime start,
    DateTime end,
  ) {
    try {
      final models = _localDataSource.getMemoriesByDateRange(start, end);
      return right(models.map(MemoryMapper.toEntity).toList());
    } on Exception {
      return left(const MemoryFailure.storageError());
    }
  }

  @override
  Future<Either<MemoryFailure, void>> clearAllMemories() async {
    try {
      await _localDataSource.clearAllMemories();
      return right(null);
    } on Exception {
      return left(const MemoryFailure.storageError());
    }
  }
}
