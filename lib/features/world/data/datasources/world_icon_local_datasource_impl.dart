import 'package:hive/hive.dart';
import 'package:innerverse/features/world/data/datasources/i_world_icon_local_datasource.dart';
import 'package:innerverse/features/world/data/models/world_icon_model.dart';

class WorldIconLocalDataSourceImpl implements IWorldIconLocalDatasource {
  static const String _boxName = 'world_icons';
  late Box<WorldIconModel> _box;

  @override
  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<WorldIconModel>(_boxName);
    } else {
      _box = Hive.box<WorldIconModel>(_boxName);
    }
  }

  @override
  Future<void> addWorldIcon(WorldIconModel worldIcon) async {
    await _box.put(worldIcon.id, worldIcon);
  }

  @override
  Future<void> clearAllWorldIcons() async {
    await _box.clear();
  }

  @override
  Future<void> deleteWorldIcon(String id) async {
    await _box.delete(id);
  }

  @override
  List<WorldIconModel> getAllWorldIcons() {
    return _box.values.toList();
  }

  @override
  WorldIconModel? getWorldIcon(String id) {
    return _box.get(id);
  }

  @override
  Future<void> updateWorldIcon(WorldIconModel worldIcon) async {
    await _box.put(worldIcon.id, worldIcon);
  }
}
