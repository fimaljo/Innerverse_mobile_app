import 'package:hive_flutter/hive_flutter.dart';
import 'package:innerverse/features/memory/data/adapters/icon_data_adapter.dart';
import 'package:innerverse/features/memory/data/adapters/time_of_day_adapter.dart';
import 'package:innerverse/features/memory/data/models/memory_model.dart';
import 'package:innerverse/features/world/data/adapters/world_icon_adapter.dart';
import 'package:innerverse/features/world/data/models/world_icon_model.dart';
import 'package:innerverse/features/world/data/adapters/world_icon_model_list_adapter.dart';

class HiveInit {
  static Future<void> init() async {
    try {
      // Register adapters only if not already registered
      _registerAdapters();

      // Open boxes
      await _openBoxes();
    } on HiveError catch (e) {
      // Handle specific Hive errors
      if (e.message.contains('TypeId') ||
          e.message.contains('already registered')) {
        await _handleTypeIdConflict();
      } else {
        rethrow;
      }
    } catch (e) {
      // Handle other errors
      throw Exception('Failed to initialize Hive: $e');
    }
  }

  static void _registerAdapters() {
    // Check if adapters are already registered before registering
    if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(MemoryModelAdapter()); // typeId: 6
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(IconDataAdapter()); // typeId: 2
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(WorldIconAdapter()); // typeId: 3
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(TimeOfDayAdapter()); // typeId: 4
    }
  }

  static Future<void> _openBoxes() async {
    try {
      await Hive.openBox<MemoryModel>('memories');
      await Hive.openBox<WorldIconModel>('world_icons');
      await Hive.openBox<MemoryModel>('draft_memories');
    } catch (e) {
      // If we can't open the boxes, they might be corrupted
      print('Error opening Hive boxes: $e');
      print('Attempting to recover by clearing corrupted data...');

      // Close boxes if they're open
      if (Hive.isBoxOpen('memories')) {
        await Hive.box<MemoryModel>('memories').close();
      }
      if (Hive.isBoxOpen('world_icons')) {
        await Hive.box<WorldIconModel>('world_icons').close();
      }
      if (Hive.isBoxOpen('draft_memories')) {
        await Hive.box<MemoryModel>('draft_memories').close();
      }

      // Delete corrupted boxes
      await Hive.deleteBoxFromDisk('memories');
      await Hive.deleteBoxFromDisk('world_icons');
      await Hive.deleteBoxFromDisk('draft_memories');

      // Try opening boxes again
      await Hive.openBox<MemoryModel>('memories');
      await Hive.openBox<WorldIconModel>('world_icons');
      await Hive.openBox<MemoryModel>('draft_memories');
    }
  }

  static Future<void> _handleTypeIdConflict() async {
    // Log the conflict for debugging
    print('TypeId conflict detected. This usually happens during development.');

    // Option 1: Clear boxes and reinitialize (development only)
    if (const bool.fromEnvironment('dart.vm.product') == false) {
      await _clearAndReinitialize();
    } else {
      // Option 2: In production, you might want to handle this differently
      // Perhaps migrate data or show user a message
      throw Exception('Database schema conflict. Please contact support.');
    }
  }

  static Future<void> _clearAndReinitialize() async {
    try {
      // Close boxes if they're open
      if (Hive.isBoxOpen('memories')) {
        await Hive.box<MemoryModel>('memories').close();
      }
      if (Hive.isBoxOpen('world_icons')) {
        await Hive.box<WorldIconModel>('world_icons').close();
      }
      if (Hive.isBoxOpen('draft_memories')) {
        await Hive.box<MemoryModel>('draft_memories').close();
      }

      // Delete boxes
      await Hive.deleteBoxFromDisk('memories');
      await Hive.deleteBoxFromDisk('world_icons');
      await Hive.deleteBoxFromDisk('draft_memories');

      // Reinitialize
      await _openBoxes();
    } catch (e) {
      throw Exception('Failed to recover from TypeId conflict: $e');
    }
  }

  // Helper method to check if Hive is properly initialized
  static bool isInitialized() {
    return Hive.isBoxOpen('memories') && Hive.isBoxOpen('world_icons');
  }

  // Clean shutdown method
  static Future<void> close() async {
    if (Hive.isBoxOpen('memories')) {
      await Hive.box<MemoryModel>('memories').close();
    }
    if (Hive.isBoxOpen('world_icons')) {
      await Hive.box<WorldIconModel>('world_icons').close();
    }
  }
}
