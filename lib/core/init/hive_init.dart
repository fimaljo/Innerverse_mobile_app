import 'package:hive_flutter/hive_flutter.dart';
import 'package:innerverse/features/memory/data/adapters/icon_data_adapter.dart';
import 'package:innerverse/features/memory/data/adapters/time_of_day_adapter.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';
import 'package:innerverse/features/memory/domain/entities/world_icon.dart';

class HiveInit {
  static Future<void> init() async {
    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(MemoryAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TimeOfDayAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(IconDataAdapter());
    }

    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(WorldIconAdapter());
    }

    // Open boxes
    if (!Hive.isBoxOpen('memories')) {
      await Hive.openBox<Memory>('memories');
    }
    // if (!Hive.isBoxOpen('world_box')) {
    //   await Hive.openBox('world_box');
    // }
    if (!Hive.isBoxOpen('world_icons')) {
      await Hive.openBox<WorldIcon>('world_icons');
    }
  }
}
