import 'package:get_it/get_it.dart';
import 'package:innerverse/features/memory/data/datasources/i_memory_local_datasource.dart';
import 'package:innerverse/features/memory/data/datasources/memory_local_datasource_impl.dart';
import 'package:innerverse/features/memory/data/repositories/memory_repository_impl.dart';
import 'package:innerverse/features/memory/domain/repositories/i_memory_repository.dart';
import 'package:innerverse/features/memory/domain/usecases/add_memory_usecase.dart';
import 'package:innerverse/features/memory/domain/usecases/clear_all_memories_usecase.dart';
import 'package:innerverse/features/memory/domain/usecases/delete_memory_usecase.dart';
import 'package:innerverse/features/memory/domain/usecases/get_all_memories_usecase.dart';
import 'package:innerverse/features/memory/domain/usecases/get_memories_by_date_range_usecase.dart';
import 'package:innerverse/features/memory/domain/usecases/get_memory_by_id_usecase.dart';
import 'package:innerverse/features/memory/domain/usecases/update_memory_usecase.dart';
import 'package:innerverse/features/memory/presentation/blocs/memory_bloc.dart';

class MemoryModule {
  static Future<void> init(GetIt sl) async {
    // Data Sources
    final localDataSource = MemoryLocalDataSourceImpl();
    await localDataSource.init();
    sl
      ..registerSingleton<IMemoryLocalDataSource>(localDataSource)
      // Repositories
      ..registerSingleton<IMemoryRepository>(
        MemoryRepositoryImpl(sl()),
      )
      // Use Cases
      ..registerLazySingleton(() => GetAllMemoriesUseCase(sl()))
      ..registerLazySingleton(() => GetMemoryByIdUseCase(sl()))
      ..registerLazySingleton(() => AddMemoryUseCase(sl()))
      ..registerLazySingleton(() => UpdateMemoryUseCase(sl()))
      ..registerLazySingleton(() => DeleteMemoryUseCase(sl()))
      ..registerLazySingleton(() => GetMemoriesByDateRangeUseCase(sl()))
      ..registerLazySingleton(() => ClearAllMemoriesUseCase(sl()))
      // Bloc
      ..registerFactory<MemoryBloc>(
        () => MemoryBloc(
          getAllMemoriesUseCase: sl(),
          addMemoryUseCase: sl(),
          updateMemoryUseCase: sl(),
          deleteMemoryUseCase: sl(),
          getMemoriesByDateRangeUseCase: sl(),
          clearAllMemoriesUseCase: sl(),
        ),
      );
  }
}
