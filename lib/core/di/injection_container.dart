import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:innerverse/core/di/navigation_di.dart';
import 'package:innerverse/core/navigation/route_tracker.dart';
import 'package:innerverse/features/memory/di/memory_module.dart';

// Add other feature di files like auth_injection.dart, memory_injection.dart,

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator(GoRouter router, RouteTracker tracker) async {
  // App-level dependencies
  sl
    ..registerLazySingleton<GoRouter>(() => router)
    ..registerLazySingleton<RouteTracker>(() => tracker);

  // Feature-wise setup
  setupNavigationDependencies();
  await MemoryModule.init(sl);
  // setupAuthDependencies();
}
