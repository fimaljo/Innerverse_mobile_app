import 'package:innerverse/core/di/injection_container.dart';
import 'package:innerverse/features/navigation/data/repositories/navigation_repository_impl.dart';
import 'package:innerverse/features/navigation/domain/repositories/navigation_repository.dart';
import 'package:innerverse/features/navigation/domain/usecases/navigate_to_tab_usecase.dart';
import 'package:innerverse/features/navigation/presentation/bloc/navigation_bloc.dart';

void setupNavigationDependencies() {
  sl
    ..registerLazySingleton<NavigationRepository>(
      () => NavigationRepositoryImpl(sl(), sl()),
    )
    ..registerLazySingleton(() => NavigateToTabUseCase(sl()))
    // ..registerLazySingleton(() => GetCurrentTabUseCase(sl()))
    ..registerFactory(
      () => NavigationBloc(
        navigateToTabUseCase: sl(),
        //  getCurrentTabUseCase: sl(),
      ),
    );
}
