import 'package:hive/hive.dart';
import 'package:innerverse/features/memory/data/datasources/i_memory_local_datasource.dart';
import 'package:innerverse/features/memory/data/models/memory_model.dart';

class MemoryLocalDataSourceImpl implements IMemoryLocalDataSource {
  static const String _boxName = 'memories';
  late Box<MemoryModel> _box;

  @override
  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<MemoryModel>(_boxName);
    } else {
      _box = Hive.box<MemoryModel>(_boxName);
    }
  }

  @override
  Future<void> addMemory(MemoryModel memory) async {
    await _box.put(memory.id, memory);
    await _box.flush();
  }

  @override
  Future<void> updateMemory(MemoryModel memory) async {
    print('🔄 LocalDataSource: Updating memory in Hive box');
    print('  - Box name: $_boxName');
    print('  - Memory ID: ${memory.id}');
    print('  - Memory title: "${memory.title}"');
    await _box.put(memory.id, memory);
    print('✅ LocalDataSource: Memory put in box');
    await _box.flush(); // Ensure data is persisted to disk
    print('✅ LocalDataSource: Box flushed to disk');

    // Verify the update
    final retrievedMemory = _box.get(memory.id);
    if (retrievedMemory != null) {
      print('✅ LocalDataSource: Verification successful - memory found in box');
      print('  - Retrieved title: "${retrievedMemory.title}"');
      print('  - Retrieved description: "${retrievedMemory.description}"');
    } else {
      print('❌ LocalDataSource: Verification failed - memory not found in box');
    }
  }

  @override
  Future<void> deleteMemory(String id) async {
    await _box.delete(id);
  }

  @override
  MemoryModel? getMemory(String id) {
    return _box.get(id);
  }

  @override
  List<MemoryModel> getAllMemories() {
    print('🔄 LocalDataSource: Getting all memories from Hive box');
    print('  - Box name: $_boxName');
    print('  - Box length: ${_box.length}');
    final memories = _box.values.toList();
    print('✅ LocalDataSource: Retrieved ${memories.length} memories from box');

    // Log each memory for debugging
    for (final memory in memories) {
      print(
          '  - ID: ${memory.id}, Title: "${memory.title}", Description: "${memory.description}"');
    }

    return memories;
  }

  @override
  List<MemoryModel> getMemoriesByDateRange(DateTime start, DateTime end) {
    return _box.values
        .where(
          (model) =>
              model.dateTime.isAfter(start) && model.dateTime.isBefore(end),
        )
        .toList();
  }

  @override
  Future<void> clearAllMemories() async {
    await _box.clear();
  }
}
