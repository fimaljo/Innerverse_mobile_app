// //CustomeTextField(
// //             controller: _nameController,
// //             hintText: 'Enter your name',
// //             fontSize: 20,
// //             validator: (p0) {
// //               return null;
// //             },
// //             textStyle: textTheme.titleMedium,
// //             animateHint: true,
// //             hintColor: Colors.red,
// //             textColor: Colors.black,
// //           ),

// // final TextEditingController _nameController = TextEditingController();

// //  final theme = Theme.of(context);
// //   final textTheme = theme.textTheme;
// //   final colorScheme = theme.colorScheme;

// // lib/core/di/injection_container.dart
// import 'package:get_it/get_it.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// //import 'package:http/http.dart' as http;
// // import 'package:internet_connection_checker/internet_connection_checker.dart';

// // // Core
// // import 'package:innerverse/core/network/network_info.dart';

// // // Features - Auth
// // import 'package:innerverse/features/auth/data/datasources/auth_local_data_source.dart';
// // import 'package:innerverse/features/auth/data/datasources/auth_remote_data_source.dart';
// // import 'package:innerverse/features/auth/data/repositories/auth_repository_impl.dart';
// // import 'package:innerverse/features/auth/domain/repositories/auth_repository.dart';
// // import 'package:innerverse/features/auth/domain/usecases/check_auth_status.dart';
// // import 'package:innerverse/features/auth/domain/usecases/login_user.dart';
// // import 'package:innerverse/features/auth/domain/usecases/logout_user.dart';
// // import 'package:innerverse/features/auth/domain/usecases/register_user.dart';
// // import 'package:innerverse/features/auth/presentation/blocs/auth_bloc.dart';

// // // Features - Memory
// // import 'package:innerverse/features/memory/data/datasources/memory_local_data_source.dart';
// // import 'package:innerverse/features/memory/data/repositories/memory_repository_impl.dart';
// // import 'package:innerverse/features/memory/domain/repositories/memory_repository.dart';
// // import 'package:innerverse/features/memory/domain/usecases/create_memory.dart';
// // import 'package:innerverse/features/memory/domain/usecases/get_memories.dart';
// // import 'package:innerverse/features/memory/presentation/blocs/memory_bloc.dart';

// // // Features - Worlds
// // import 'package:innerverse/features/worlds/data/datasources/world_local_data_source.dart';
// // import 'package:innerverse/features/worlds/data/repositories/world_repository_impl.dart';
// // import 'package:innerverse/features/worlds/domain/repositories/world_repository.dart';
// // import 'package:innerverse/features/worlds/domain/usecases/get_worlds.dart';
// // import 'package:innerverse/features/worlds/presentation/blocs/world_bloc.dart';

// final GetIt sl = GetIt.instance;

// Future<void> init() async {
//   // //! Features - Auth
//   // // Bloc
//   // sl.registerFactory(
//   //   () => AuthBloc(
//   //     checkAuthStatus: sl(),
//   //     loginUser: sl(),
//   //     logoutUser: sl(),
//   //     registerUser: sl(),
//   //   ),
//   // );

//   // // Use cases
//   // sl.registerLazySingleton(() => CheckAuthStatus(sl()));
//   // sl.registerLazySingleton(() => LoginUser(sl()));
//   // sl.registerLazySingleton(() => LogoutUser(sl()));
//   // sl.registerLazySingleton(() => RegisterUser(sl()));

//   // // Repository
//   // sl.registerLazySingleton<AuthRepository>(
//   //   () => AuthRepositoryImpl(
//   //     remoteDataSource: sl(),
//   //     localDataSource: sl(),
//   //     networkInfo: sl(),
//   //   ),
//   // );

//   // // Data sources
//   // sl.registerLazySingleton<AuthRemoteDataSource>(
//   //   () => AuthRemoteDataSourceImpl(client: sl()),
//   // );

//   // sl.registerLazySingleton<AuthLocalDataSource>(
//   //   () => AuthLocalDataSourceImpl(hiveBox: sl()),
//   // );

//   // //! Features - Memory
//   // // Bloc
//   // sl.registerFactory(
//   //   () => MemoryBloc(
//   //     createMemory: sl(),
//   //     getMemories: sl(),
//   //   ),
//   // );

//   // // Use cases
//   // sl.registerLazySingleton(() => CreateMemory(sl()));
//   // sl.registerLazySingleton(() => GetMemories(sl()));

//   // // Repository
//   // sl.registerLazySingleton<MemoryRepository>(
//   //   () => MemoryRepositoryImpl(
//   //     localDataSource: sl(),
//   //   ),
//   // );

//   // // Data sources
//   // sl.registerLazySingleton<MemoryLocalDataSource>(
//   //   () => MemoryLocalDataSourceImpl(hiveBox: sl()),
//   // );

//   // //! Features - Worlds
//   // // Bloc
//   // sl.registerFactory(
//   //   () => WorldBloc(
//   //     getWorlds: sl(),
//   //   ),
//   // );

//   // // Use cases
//   // sl.registerLazySingleton(() => GetWorlds(sl()));

//   // // Repository
//   // sl.registerLazySingleton<WorldRepository>(
//   //   () => WorldRepositoryImpl(
//   //     localDataSource: sl(),
//   //   ),
//   // );

//   // // Data sources
//   // sl.registerLazySingleton<WorldLocalDataSource>(
//   //   () => WorldLocalDataSourceImpl(hiveBox: sl()),
//   // );

//   // //! Core
//   // sl.registerLazySingleton<NetworkInfo>(
//   //   () => NetworkInfoImpl(sl()),
//   // );

//   // //! External
//   // sl.registerLazySingleton(() => http.Client());
//   // sl.registerLazySingleton(() => InternetConnectionChecker());

//   // // Hive Boxes
//   // sl.registerLazySingleton<Box>(() => Hive.box('auth_box'));
//   // sl.registerLazySingleton<Box>(() => Hive.box('memory_box'));
//   // sl.registerLazySingleton<Box>(() => Hive.box('world_box'));

//   // // Initialize Hive boxes
//   // await _initHiveBoxes();
// }

// Future<void> _initHiveBoxes() async {
//   await Hive.openBox('auth_box');
//   await Hive.openBox('memory_box');
//   await Hive.openBox('world_box');
// }


 // return Container(
    //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(16),
    //     boxShadow: const [
    //       BoxShadow(
    //         color: Colors.grey,
    //         blurRadius: 10,
    //         offset: Offset(0, 4),
    //       ),
    //     ],
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Container(
    //         padding: const EdgeInsets.all(16),
    //         decoration: const BoxDecoration(
    //           gradient: LinearGradient(
    //             colors: [
    //               Colors.blue,
    //               Colors.purple,
    //             ],
    //             begin: Alignment.topLeft,
    //             end: Alignment.bottomRight,
    //           ),
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(16),
    //             topRight: Radius.circular(16),
    //           ),
    //         ),
    //         child: Row(
    //           children: [
    //             Row(
    //               children: entry.worldIcons
    //                   .map(
    //                     (worldIcon) => Padding(
    //                       padding: const EdgeInsets.only(right: 8),
    //                       child: Icon(
    //                         worldIcon.icon,
    //                         color: Colors.white,
    //                         size: 24,
    //                       ),
    //                     ),
    //                   )
    //                   .toList(),
    //             ),
    //             const SizedBox(width: 12),
    //             Expanded(
    //               child: Text(
    //                 entry.title ?? 'Untitled',
    //                 style: const TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ),
    //             if (entry.images != null && entry.images!.isNotEmpty) ...[
    //               Container(
    //                 padding:
    //                     const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    //                 decoration: BoxDecoration(
    //                   color: Colors.white24,
    //                   borderRadius: BorderRadius.circular(8),
    //                 ),
    //                 child: Row(
    //                   mainAxisSize: MainAxisSize.min,
    //                   children: [
    //                     const Icon(
    //                       Icons.photo_library,
    //                       color: Colors.white,
    //                       size: 12,
    //                     ),
    //                     const SizedBox(width: 2),
    //                     Text(
    //                       '${entry.images!.length}',
    //                       style: const TextStyle(
    //                         color: Colors.white,
    //                         fontSize: 10,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               const SizedBox(width: 8),
    //             ],
    //             Text(
    //               entry.emojiLabel,
    //               style: const TextStyle(
    //                 color: Colors.white70,
    //                 fontSize: 14,
    //               ),
    //             ),
    //             Text(
    //               DateFormat('MMM d, y').format(entry.dateTime),
    //               style: const TextStyle(
    //                 color: Colors.white70,
    //                 fontSize: 14,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(16),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             if (entry.description != null) ...[
    //               Text(
    //                 entry.description!,
    //                 style: const TextStyle(
    //                   fontSize: 16,
    //                   color: Colors.black87,
    //                 ),
    //               ),
    //               const SizedBox(height: 12),
    //             ],
    //             // Image Gallery
    //             if (entry.images != null && entry.images!.isNotEmpty) ...[
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     'Images',
    //                     style: TextStyle(
    //                       fontSize: 14,
    //                       fontWeight: FontWeight.w600,
    //                       color: Colors.grey[700],
    //                     ),
    //                   ),
    //                   if (entry.images!.length > 3)
    //                     GestureDetector(
    //                       onTap: () => _showAllImages(context, entry.images!),
    //                       child: Text(
    //                         'View All (${entry.images!.length})',
    //                         style: TextStyle(
    //                           fontSize: 12,
    //                           color: Colors.blue[600],
    //                           fontWeight: FontWeight.w500,
    //                         ),
    //                       ),
    //                     ),
    //                 ],
    //               ),
    //               const SizedBox(height: 8),
    //               SizedBox(
    //                 height: 80,
    //                 child: ListView.separated(
    //                   scrollDirection: Axis.horizontal,
    //                   itemCount:
    //                       entry.images!.length > 3 ? 3 : entry.images!.length,
    //                   separatorBuilder: (_, __) => const SizedBox(width: 8),
    //                   itemBuilder: (context, imageIndex) {
    //                     final imagePath = entry.images![imageIndex];
    //                     return GestureDetector(
    //                       onTap: () => _showImageFullScreen(context, imagePath),
    //                       child: Stack(
    //                         children: [
    //                           ClipRRect(
    //                             borderRadius: BorderRadius.circular(8),
    //                             child: Image.file(
    //                               File(imagePath),
    //                               width: 80,
    //                               height: 80,
    //                               fit: BoxFit.cover,
    //                               errorBuilder: (context, error, stackTrace) {
    //                                 return Container(
    //                                   width: 80,
    //                                   height: 80,
    //                                   decoration: BoxDecoration(
    //                                     color: Colors.grey[300],
    //                                     borderRadius: BorderRadius.circular(8),
    //                                   ),
    //                                   child: Icon(
    //                                     Icons.broken_image,
    //                                     color: Colors.grey[600],
    //                                     size: 24,
    //                                   ),
    //                                 );
    //                               },
    //                             ),
    //                           ),
    //                           if (imageIndex == 2 && entry.images!.length > 3)
    //                             Positioned.fill(
    //                               child: Container(
    //                                 decoration: BoxDecoration(
    //                                   color: Colors.black54,
    //                                   borderRadius: BorderRadius.circular(8),
    //                                 ),
    //                                 child: Center(
    //                                   child: Text(
    //                                     '+${entry.images!.length - 3}',
    //                                     style: const TextStyle(
    //                                       color: Colors.white,
    //                                       fontSize: 16,
    //                                       fontWeight: FontWeight.bold,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                         ],
    //                       ),
    //                     );
    //                   },
    //                 ),
    //               ),
    //               const SizedBox(height: 12),
    //             ],
    //             Row(
    //               children: [
    //                 Icon(
    //                   Icons.access_time,
    //                   size: 16,
    //                   color: Colors.grey[600],
    //                 ),
    //                 const SizedBox(width: 4),
    //                 Text(
    //                   entry.time.hour.toString(),
    //                   style: TextStyle(
    //                     fontSize: 14,
    //                     color: Colors.grey[600],
    //                   ),
    //                 ),
    //                 const SizedBox(width: 16),
    //                 Icon(
    //                   Icons.emoji_emotions,
    //                   size: 16,
    //                   color: Colors.grey[600],
    //                 ),
    //                 const SizedBox(width: 4),
    //                 Text(
    //                   'Emotion: ${entry.emotionSliderValue}',
    //                   style: TextStyle(
    //                     fontSize: 14,
    //                     color: Colors.grey[600],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 12),
    //             // Action Buttons
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 BlocBuilder<EntriesBloc, EntriesState>(
    //                   builder: (context, state) {
    //                     final isUpdating = state is EntryUpdating;
    //                     final isDeleting = state is EntryDeleting;

    //                     return Row(
    //                       children: [
    //                         TextButton.icon(
    //                           onPressed: (isUpdating || isDeleting)
    //                               ? null
    //                               : () => _showEditDialog(context),
    //                           icon: isUpdating
    //                               ? const SizedBox(
    //                                   width: 16,
    //                                   height: 16,
    //                                   child: CircularProgressIndicator(
    //                                       strokeWidth: 2),
    //                                 )
    //                               : const Icon(Icons.edit, size: 16),
    //                           label: Text(isUpdating ? 'Updating...' : 'Edit'),
    //                           style: TextButton.styleFrom(
    //                             foregroundColor: Colors.blue[600],
    //                           ),
    //                         ),
    //                         const SizedBox(width: 8),
    //                         TextButton.icon(
    //                           onPressed: (isUpdating || isDeleting)
    //                               ? null
    //                               : () => _showDeleteConfirmation(context),
    //                           icon: isDeleting
    //                               ? const SizedBox(
    //                                   width: 16,
    //                                   height: 16,
    //                                   child: CircularProgressIndicator(
    //                                       strokeWidth: 2),
    //                                 )
    //                               : const Icon(Icons.delete, size: 16),
    //                           label:
    //                               Text(isDeleting ? 'Deleting...' : 'Delete'),
    //                           style: TextButton.styleFrom(
    //                             foregroundColor: Colors.red[600],
    //                           ),
    //                         ),
    //                       ],
    //                     );
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );