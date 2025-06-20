import 'package:get_it/get_it.dart';
import 'package:innerverse/features/entries/data/repositories/entries_repository_impl.dart';
import 'package:innerverse/features/entries/domain/repositories/entries_repository.dart';
import 'package:innerverse/features/entries/domain/usecases/delete_entry_usecase.dart';
import 'package:innerverse/features/entries/domain/usecases/get_all_entries_usecase.dart';
import 'package:innerverse/features/entries/domain/usecases/search_entries_usecase.dart';
import 'package:innerverse/features/entries/domain/usecases/update_entry_usecase.dart';
import 'package:innerverse/features/entries/presentation/blocs/entries_bloc.dart';
import 'package:innerverse/features/memory/domain/repositories/i_memory_repository.dart';

class EntriesModule {
  static void registerDependencies(GetIt getIt) {
    // Repository
    getIt.registerLazySingleton<EntriesRepository>(
      () => EntriesRepositoryImpl(getIt<IMemoryRepository>()),
    );

    // Use cases
    getIt.registerLazySingleton(
      () => GetAllEntriesUseCase(getIt<EntriesRepository>()),
    );

    getIt.registerLazySingleton(
      () => SearchEntriesUseCase(getIt<EntriesRepository>()),
    );

    getIt.registerLazySingleton(
      () => UpdateEntryUseCase(getIt<EntriesRepository>()),
    );

    getIt.registerLazySingleton(
      () => DeleteEntryUseCase(getIt<EntriesRepository>()),
    );

    // Bloc
    getIt.registerFactory(
      () => EntriesBloc(
        getAllEntriesUseCase: getIt<GetAllEntriesUseCase>(),
        searchEntriesUseCase: getIt<SearchEntriesUseCase>(),
        updateEntryUseCase: getIt<UpdateEntryUseCase>(),
        deleteEntryUseCase: getIt<DeleteEntryUseCase>(),
      ),
    );
  }
}
