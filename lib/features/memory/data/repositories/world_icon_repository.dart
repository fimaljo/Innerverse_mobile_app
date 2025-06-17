import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:innerverse/features/memory/domain/entities/world_icon.dart';

class WorldIconRepository {
  static const String _boxName = 'world_icons';
  late Box<WorldIcon> _box;

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<WorldIcon>(_boxName);
    } else {
      _box = Hive.box<WorldIcon>(_boxName);
    }
  }

  Future<void> addWorldIcon(WorldIcon icon) async {
    await _box.add(icon);
  }

  Future<void> updateWorldIcon(int index, WorldIcon icon) async {
    await _box.putAt(index, icon);
  }

  Future<void> deleteWorldIcon(int index) async {
    await _box.deleteAt(index);
  }

  List<WorldIcon> getAllWorldIcons() {
    return _box.values.toList();
  }

  Future<void> clearAllWorldIcons() async {
    await _box.clear();
  }

  Future<void> initializeDefaultIcons() async {
    if (_box.isEmpty) {
      final defaultIcons = [
        WorldIcon(name: 'Family', icon: Icons.family_restroom),
        WorldIcon(name: 'RelationShip', icon: Icons.heat_pump_rounded),
      ];
      await _box.addAll(defaultIcons);
    }
  }
}
