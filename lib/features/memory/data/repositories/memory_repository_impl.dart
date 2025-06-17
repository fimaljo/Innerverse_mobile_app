import 'package:dartz/dartz.dart';
import 'package:innerverse/features/memory/data/datasources/i_memory_local_datasource.dart';
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
    } catch (e) {
      return left(const MemoryFailure.storageError());
    }
  }

  @override
  Future<Either<MemoryFailure, void>> addMemory(Memory memory) async {
    try {
      await _localDataSource.addMemory(memory);
      return right(null);
    } catch (e) {
      return left(const MemoryFailure.storageError());
    }
  }

  @override
  Future<Either<MemoryFailure, void>> updateMemory(Memory memory) async {
    try {
      await _localDataSource.updateMemory(memory);
      return right(null);
    } catch (e) {
      return left(const MemoryFailure.storageError());
    }
  }

  @override
  Future<Either<MemoryFailure, void>> deleteMemory(String id) async {
    try {
      await _localDataSource.deleteMemory(id);
      return right(null);
    } catch (e) {
      return left(const MemoryFailure.storageError());
    }
  }

  @override
  Either<MemoryFailure, Memory?> getMemory(String id) {
    try {
      final memory = _localDataSource.getMemory(id);
      return right(memory);
    } catch (e) {
      return left(const MemoryFailure.storageError());
    }
  }

  @override
  Either<MemoryFailure, List<Memory>> getAllMemories() {
    try {
      final memories = _localDataSource.getAllMemories();
      return right(memories);
    } catch (e) {
      return left(const MemoryFailure.storageError());
    }
  }

  @override
  Either<MemoryFailure, List<Memory>> getMemoriesByDateRange(
    DateTime start,
    DateTime end,
  ) {
    try {
      final memories = _localDataSource.getMemoriesByDateRange(start, end);
      return right(memories);
    } catch (e) {
      return left(const MemoryFailure.storageError());
    }
  }

  @override
  Future<Either<MemoryFailure, void>> clearAllMemories() async {
    try {
      await _localDataSource.clearAllMemories();
      return right(null);
    } catch (e) {
      return left(const MemoryFailure.storageError());
    }
  }
}
