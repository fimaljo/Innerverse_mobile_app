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
  }

  @override
  Future<void> updateMemory(MemoryModel memory) async {
    await _box.put(memory.id, memory);
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
    return _box.values.toList();
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
