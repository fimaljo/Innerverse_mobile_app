// lib/core/navigation/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:innerverse/core/navigation/route_constants.dart';
import 'package:innerverse/features/home/presentation/pages/home_page.dart';
import 'package:innerverse/features/memory/presentation/pages/create_memory_page.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: RouteConstants.splash,
    debugLogDiagnostics: true,

    // Global error handling
    // errorBuilder: (context, state) => ErrorPage(
    //   error: state.error.toString(),
    // ),

    // Route redirect logic for authentication
    redirect: (context, state) {
      return null;
    
      // final authBloc = context.read<AuthBloc>();
      // final authState = authBloc.state;

      // final isOnSplash = state.matchedLocation == RouteConstants.splash;
      // final isOnAuth =
      //     state.matchedLocation == RouteConstants.login ||
      //     state.matchedLocation == RouteConstants.register;

      // // Show splash while loading
      // if (authState is AuthLoadingState && !isOnSplash) {
      //   return RouteConstants.splash;
      // }

      // // Redirect to login if not authenticated
      // if (authState is AuthUnauthenticatedState && !isOnAuth && !isOnSplash) {
      //   return RouteConstants.login;
      // }

      // // Redirect to home if authenticated and on auth pages
      // if (authState is AuthAuthenticatedState && (isOnAuth || isOnSplash)) {
      //   return RouteConstants.home;
      // }

      // return null; // No redirect needed
    },

    routes: <RouteBase>[
      // Splash Route
      GoRoute(
        path: RouteConstants.splash,
        name: RouteConstants.splashName,
        builder: (context, state) => const SplashPage(),
      ),

      GoRoute(
        path: RouteConstants.home,
        name: RouteConstants.homeName,
        builder: (context, state) => const HomePage(),
      ),

      GoRoute(
        path: RouteConstants.createMemory,
        name: RouteConstants.createMemoryName,
        builder: (context, state) => const CreateMemoryPage(),
      ),

      // Authentication Routes

      // Main App Routes with Shell Route for Bottom Navigation
      // ShellRoute(
      //   builder: (context, state, child) {
      //     return MainShell(child: child);
      //   },
      //   routes: [
      //     // Home Route
      //     GoRoute(
      //       path: RouteConstants.home,
      //       name: RouteConstants.homeName,
      //       builder: (context, state) => const HomePage(),
      //     ),

      //     // Memory Routes
      //     GoRoute(
      //       path: RouteConstants.memories,
      //       name: RouteConstants.memoriesName,
      //       builder: (context, state) => const MemoryListPage(),
      //       routes: [
      //         GoRoute(
      //           path: '/create',
      //           name: RouteConstants.createMemoryName,
      //           builder: (context, state) => const CreateMemoryPage(),
      //         ),
      //         GoRoute(
      //           path: '/:memoryId',
      //           name: RouteConstants.memoryDetailName,
      //           builder: (context, state) {
      //             final memoryId = state.pathParameters['memoryId']!;
      //             return MemoryDetailPage(memoryId: memoryId);
      //           },
      //         ),
      //       ],
      //     ),

      //     // Worlds Routes
      //     GoRoute(
      //       path: RouteConstants.worlds,
      //       name: RouteConstants.worldsName,
      //       builder: (context, state) => const WorldsPage(),
      //       routes: [
      //         GoRoute(
      //           path: '/:worldId',
      //           name: RouteConstants.worldDetailName,
      //           builder: (context, state) {
      //             final worldId = state.pathParameters['worldId']!;
      //             return WorldDetailPage(worldId: worldId);
      //           },
      //         ),
      //       ],
      //     ),

      // Profile Route
      //     GoRoute(
      //       path: RouteConstants.profile,
      //       name: RouteConstants.profileName,
      //       builder: (context, state) => const ProfilePage(),
      //     ),
      //   ],
      // ),

      // Settings Route (outside shell for full-screen)
      // GoRoute(
      //   path: RouteConstants.settings,
      //   name: RouteConstants.settingsName,
      //   builder: (context, state) => const SettingsPage(),
      // ),
    ],
  );

  static GoRouter get router => _router;
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.pushNamed(RouteConstants.createMemoryName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Innerverse Splash',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
