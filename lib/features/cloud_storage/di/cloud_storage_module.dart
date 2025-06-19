import 'package:get_it/get_it.dart';
import 'package:innerverse/features/cloud_storage/data/datasources/cloud_storage_local_datasource.dart';
import 'package:innerverse/features/cloud_storage/data/datasources/cloud_storage_local_datasource_impl.dart';
import 'package:innerverse/features/cloud_storage/data/datasources/cloud_storage_remote_datasource.dart';
import 'package:innerverse/features/cloud_storage/data/datasources/cloud_storage_remote_datasource_impl.dart';
import 'package:innerverse/features/cloud_storage/data/repositories/cloud_storage_repository_impl.dart';
import 'package:innerverse/features/cloud_storage/domain/repositories/cloud_storage_repository.dart';
import 'package:innerverse/features/cloud_storage/domain/usecases/authenticate_usecase.dart';
import 'package:innerverse/features/cloud_storage/domain/usecases/perform_full_sync_usecase.dart';
import 'package:innerverse/features/cloud_storage/domain/usecases/upload_hive_box_usecase.dart';
import 'package:innerverse/features/cloud_storage/presentation/blocs/cloud_storage_bloc.dart';

class CloudStorageModule {
  static Future<void> init(GetIt sl) async {
    // Data Sources
    final remoteDataSource = CloudStorageRemoteDataSourceImpl();
    final localDataSource = CloudStorageLocalDataSourceImpl();

    sl
      ..registerSingleton<CloudStorageRemoteDataSource>(remoteDataSource)
      ..registerSingleton<CloudStorageLocalDataSource>(localDataSource)
      // Repository
      ..registerSingleton<CloudStorageRepository>(
        CloudStorageRepositoryImpl(
          remoteDataSource: sl(),
          localDataSource: sl(),
        ),
      )
      // Use Cases
      ..registerLazySingleton(() => AuthenticateUseCase(sl()))
      ..registerLazySingleton(() => PerformFullSyncUseCase(sl()))
      ..registerLazySingleton(() => UploadHiveBoxUseCase(sl()))
      // Bloc
      ..registerFactory<CloudStorageBloc>(
        () => CloudStorageBloc(
          authenticateUseCase: sl(),
          performFullSyncUseCase: sl(),
          uploadHiveBoxUseCase: sl(),
        ),
      );
  }
}
