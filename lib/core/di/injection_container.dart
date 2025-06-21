import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:innerverse/core/di/navigation_di.dart';
import 'package:innerverse/core/navigation/route_tracker.dart';
import 'package:innerverse/core/services/event_bus_service.dart';
import 'package:innerverse/features/entries/di/entries_module.dart';
import 'package:innerverse/features/memory/di/memory_module.dart';
import 'package:innerverse/features/world/di/world_module.dart';

// Add other feature di files like auth_injection.dart, memory_injection.dart,

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator(GoRouter router, RouteTracker tracker) async {
  // App-level dependencies
  sl
    ..registerLazySingleton<GoRouter>(() => router)
    ..registerLazySingleton<RouteTracker>(() => tracker)
    ..registerLazySingleton<EventBusService>(EventBusService.new);

  // Feature-wise setup
  setupNavigationDependencies();
  await MemoryModule.init(sl);
  await WorldModule.init(sl);
  EntriesModule.registerDependencies(sl);
  // setupAuthDependencies();
}
