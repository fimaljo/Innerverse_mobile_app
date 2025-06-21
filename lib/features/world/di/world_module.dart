import 'package:get_it/get_it.dart';
import 'package:innerverse/features/memory/domain/repositories/i_memory_repository.dart';
import 'package:innerverse/features/world/data/datasources/i_world_icon_local_datasource.dart';
import 'package:innerverse/features/world/data/datasources/world_icon_local_datasource_impl.dart';
import 'package:innerverse/features/world/data/repositories/world_icon_repository_impl.dart';
import 'package:innerverse/features/world/data/repositories/world_repository_impl.dart';
import 'package:innerverse/features/world/domain/repositories/i_world_icon_repository.dart';
import 'package:innerverse/features/world/domain/repositories/world_repository.dart';
import 'package:innerverse/features/world/domain/usecases/add_world_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/calculate_tree_growth_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/calculate_world_tree_growth_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/delete_world_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/get_all_worlds_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/get_all_worlds_with_tree_growth_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/update_world_usecase.dart';
import 'package:innerverse/features/world/presentation/blocs/world_bloc.dart';

class WorldModule {
  static Future<void> init(GetIt sl) async {
    // Data Sources
    final localDataSource = WorldIconLocalDataSourceImpl();
    await localDataSource.init();
    sl
      ..registerSingleton<IWorldIconLocalDatasource>(localDataSource)
      // Repositories
      ..registerSingleton<IWorldIconRepository>(
        WorldIconRepositoryImpl(sl()),
      )
      ..registerSingleton<WorldRepository>(
        WorldRepositoryImpl(sl()),
      )
      // Use Cases
      ..registerLazySingleton(() => GetAllWorldsUseCase(sl()))
      ..registerLazySingleton(() => AddWorldUseCase(sl()))
      ..registerLazySingleton(() => UpdateWorldUseCase(sl()))
      ..registerLazySingleton(() => DeleteWorldUseCase(sl()))
      ..registerLazySingleton(
          () => CalculateTreeGrowthUseCase(sl<IMemoryRepository>()))
      ..registerLazySingleton(
          () => CalculateWorldTreeGrowthUseCase(sl<IMemoryRepository>()))
      ..registerLazySingleton(() => GetAllWorldsWithTreeGrowthUseCase(
            worldRepository: sl(),
            calculateWorldTreeGrowthUseCase: sl(),
          ))
      // Bloc
      ..registerFactory<WorldBloc>(
        () => WorldBloc(
          getAllWorldsUseCase: sl(),
          addWorldUseCase: sl(),
          updateWorldUseCase: sl(),
          deleteWorldUseCase: sl(),
          calculateTreeGrowthUseCase: sl(),
          calculateWorldTreeGrowthUseCase: sl(),
          getAllWorldsWithTreeGrowthUseCase: sl(),
        ),
      );
  }
}
