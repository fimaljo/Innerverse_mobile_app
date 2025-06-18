import 'package:get_it/get_it.dart';
import 'package:innerverse/features/world/data/datasources/i_world_icon_local_datasource.dart';
import 'package:innerverse/features/world/data/datasources/world_icon_local_datasource_impl.dart';
import 'package:innerverse/features/world/data/repositories/world_icon_repository_impl.dart';
import 'package:innerverse/features/world/domain/repositories/i_world_icon_repository.dart';
import 'package:innerverse/features/world/domain/usecases/add_world_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/delete_world_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/get_all_worlds_usecase.dart';
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
      // Use Cases
      ..registerLazySingleton(() => GetAllWorldsUseCase(sl()))
      ..registerLazySingleton(() => AddWorldUseCase(sl()))
      ..registerLazySingleton(() => UpdateWorldUseCase(sl()))
      ..registerLazySingleton(() => DeleteWorldUseCase(sl()))
      // Bloc
      ..registerFactory<WorldBloc>(
        () => WorldBloc(
          getAllWorldsUseCase: sl(),
          addWorldUseCase: sl(),
          updateWorldUseCase: sl(),
          deleteWorldUseCase: sl(),
        ),
      );
  }
}
