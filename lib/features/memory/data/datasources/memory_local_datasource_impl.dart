import 'package:hive/hive.dart';
import 'package:innerverse/features/memory/data/datasources/i_memory_local_datasource.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';

class MemoryLocalDataSourceImpl implements IMemoryLocalDataSource {
  static const String _boxName = 'memories';
  late Box<Memory> _box;

  @override
  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<Memory>(_boxName);
    } else {
      _box = Hive.box<Memory>(_boxName);
    }
  }

  @override
  Future<void> addMemory(Memory memory) async {
    await _box.put(memory.id, memory);
  }

  @override
  Future<void> updateMemory(Memory memory) async {
    await _box.put(memory.id, memory);
  }

  @override
  Future<void> deleteMemory(String id) async {
    await _box.delete(id);
  }

  @override
  Memory? getMemory(String id) {
    return _box.get(id);
  }

  @override
  List<Memory> getAllMemories() {
    return _box.values.toList();
  }

  @override
  List<Memory> getMemoriesByDateRange(DateTime start, DateTime end) {
    return _box.values
        .where(
          (memory) =>
              memory.dateTime.isAfter(start) && memory.dateTime.isBefore(end),
        )
        .toList();
  }

  @override
  Future<void> clearAllMemories() async {
    await _box.clear();
  }
}
