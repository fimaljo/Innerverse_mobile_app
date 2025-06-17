//CustomeTextField(
//             controller: _nameController,
//             hintText: 'Enter your name',
//             fontSize: 20,
//             validator: (p0) {
//               return null;
//             },
//             textStyle: textTheme.titleMedium,
//             animateHint: true,
//             hintColor: Colors.red,
//             textColor: Colors.black,
//           ),

// final TextEditingController _nameController = TextEditingController();

//  final theme = Theme.of(context);
//   final textTheme = theme.textTheme;
//   final colorScheme = theme.colorScheme;

// lib/core/di/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:http/http.dart' as http;
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// // Core
// import 'package:innerverse/core/network/network_info.dart';

// // Features - Auth
// import 'package:innerverse/features/auth/data/datasources/auth_local_data_source.dart';
// import 'package:innerverse/features/auth/data/datasources/auth_remote_data_source.dart';
// import 'package:innerverse/features/auth/data/repositories/auth_repository_impl.dart';
// import 'package:innerverse/features/auth/domain/repositories/auth_repository.dart';
// import 'package:innerverse/features/auth/domain/usecases/check_auth_status.dart';
// import 'package:innerverse/features/auth/domain/usecases/login_user.dart';
// import 'package:innerverse/features/auth/domain/usecases/logout_user.dart';
// import 'package:innerverse/features/auth/domain/usecases/register_user.dart';
// import 'package:innerverse/features/auth/presentation/blocs/auth_bloc.dart';

// // Features - Memory
// import 'package:innerverse/features/memory/data/datasources/memory_local_data_source.dart';
// import 'package:innerverse/features/memory/data/repositories/memory_repository_impl.dart';
// import 'package:innerverse/features/memory/domain/repositories/memory_repository.dart';
// import 'package:innerverse/features/memory/domain/usecases/create_memory.dart';
// import 'package:innerverse/features/memory/domain/usecases/get_memories.dart';
// import 'package:innerverse/features/memory/presentation/blocs/memory_bloc.dart';

// // Features - Worlds
// import 'package:innerverse/features/worlds/data/datasources/world_local_data_source.dart';
// import 'package:innerverse/features/worlds/data/repositories/world_repository_impl.dart';
// import 'package:innerverse/features/worlds/domain/repositories/world_repository.dart';
// import 'package:innerverse/features/worlds/domain/usecases/get_worlds.dart';
// import 'package:innerverse/features/worlds/presentation/blocs/world_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // //! Features - Auth
  // // Bloc
  // sl.registerFactory(
  //   () => AuthBloc(
  //     checkAuthStatus: sl(),
  //     loginUser: sl(),
  //     logoutUser: sl(),
  //     registerUser: sl(),
  //   ),
  // );

  // // Use cases
  // sl.registerLazySingleton(() => CheckAuthStatus(sl()));
  // sl.registerLazySingleton(() => LoginUser(sl()));
  // sl.registerLazySingleton(() => LogoutUser(sl()));
  // sl.registerLazySingleton(() => RegisterUser(sl()));

  // // Repository
  // sl.registerLazySingleton<AuthRepository>(
  //   () => AuthRepositoryImpl(
  //     remoteDataSource: sl(),
  //     localDataSource: sl(),
  //     networkInfo: sl(),
  //   ),
  // );

  // // Data sources
  // sl.registerLazySingleton<AuthRemoteDataSource>(
  //   () => AuthRemoteDataSourceImpl(client: sl()),
  // );

  // sl.registerLazySingleton<AuthLocalDataSource>(
  //   () => AuthLocalDataSourceImpl(hiveBox: sl()),
  // );

  // //! Features - Memory
  // // Bloc
  // sl.registerFactory(
  //   () => MemoryBloc(
  //     createMemory: sl(),
  //     getMemories: sl(),
  //   ),
  // );

  // // Use cases
  // sl.registerLazySingleton(() => CreateMemory(sl()));
  // sl.registerLazySingleton(() => GetMemories(sl()));

  // // Repository
  // sl.registerLazySingleton<MemoryRepository>(
  //   () => MemoryRepositoryImpl(
  //     localDataSource: sl(),
  //   ),
  // );

  // // Data sources
  // sl.registerLazySingleton<MemoryLocalDataSource>(
  //   () => MemoryLocalDataSourceImpl(hiveBox: sl()),
  // );

  // //! Features - Worlds
  // // Bloc
  // sl.registerFactory(
  //   () => WorldBloc(
  //     getWorlds: sl(),
  //   ),
  // );

  // // Use cases
  // sl.registerLazySingleton(() => GetWorlds(sl()));

  // // Repository
  // sl.registerLazySingleton<WorldRepository>(
  //   () => WorldRepositoryImpl(
  //     localDataSource: sl(),
  //   ),
  // );

  // // Data sources
  // sl.registerLazySingleton<WorldLocalDataSource>(
  //   () => WorldLocalDataSourceImpl(hiveBox: sl()),
  // );

  // //! Core
  // sl.registerLazySingleton<NetworkInfo>(
  //   () => NetworkInfoImpl(sl()),
  // );

  // //! External
  // sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => InternetConnectionChecker());

  // // Hive Boxes
  // sl.registerLazySingleton<Box>(() => Hive.box('auth_box'));
  // sl.registerLazySingleton<Box>(() => Hive.box('memory_box'));
  // sl.registerLazySingleton<Box>(() => Hive.box('world_box'));

  // // Initialize Hive boxes
  // await _initHiveBoxes();
}

Future<void> _initHiveBoxes() async {
  await Hive.openBox('auth_box');
  await Hive.openBox('memory_box');
  await Hive.openBox('world_box');
}
