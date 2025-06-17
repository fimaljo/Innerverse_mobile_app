import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:innerverse/core/di/navigation_di.dart';
import 'package:innerverse/core/navigation/route_tracker.dart';

// Add other feature di files like auth_injection.dart, memory_injection.dart, etc.

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator(GoRouter router, RouteTracker tracker) async {
  // App-level dependencies
  sl
    ..registerLazySingleton<GoRouter>(() => router)
    ..registerLazySingleton<RouteTracker>(() => tracker);

  // Feature-wise setup
  setupNavigationDependencies();
  // setupAuthDependencies();
  // setupMemoryDependencies();

  // Optional: init local storage
  await _initHiveBoxes();
}

Future<void> _initHiveBoxes() async {
  // Put all Hive boxes here
  // Better: move each box open to their respective feature init if needed
  await Hive.openBox('auth_box');
  await Hive.openBox('memory_box');
  await Hive.openBox('world_box');
}
