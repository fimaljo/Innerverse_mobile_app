// lib/core/navigation/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:innerverse/core/navigation/route_constants.dart';
import 'package:innerverse/core/navigation/route_tracker.dart';
import 'package:innerverse/features/analytics/presentation/page/analytics_page.dart';
import 'package:innerverse/features/entries/presentation/blocs/entries_bloc.dart';
import 'package:innerverse/features/entries/presentation/blocs/entries_event.dart';
import 'package:innerverse/features/entries/presentation/page/entries_page.dart';
import 'package:innerverse/features/home/presentation/pages/home_page.dart';
import 'package:innerverse/features/memory/presentation/blocs/memory_bloc.dart';
import 'package:innerverse/features/memory/presentation/pages/select_memory_type_page.dart';
import 'package:innerverse/features/navigation/domain/entities/navigation_tab_entities.dart';
import 'package:innerverse/features/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:innerverse/features/navigation/presentation/bloc/navigation_event.dart';
import 'package:innerverse/features/world/presentation/blocs/world_bloc.dart';
import 'package:innerverse/features/world/world_page.dart';

class AppRouter {
  static GoRouter createRouter(RouteTracker tracker) {
    return GoRouter(
      initialLocation: RouteConstants.splash,
      debugLogDiagnostics: true,
      observers: [tracker],
      redirect: (context, state) {
        // Add auth redirect logic if needed
        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: RouteConstants.splash,
          name: RouteConstants.splashName,
          builder: (context, state) => const SplashPage(),
        ),
        ShellRoute(
          navigatorKey: GlobalKey<NavigatorState>(),
          builder: (context, state, child) {
            return HomePage(child: child);
          },
          routes: [
            GoRoute(
              path: RouteConstants.entries,
              name: RouteConstants.entriesName,
              builder: (context, state) => BlocProvider(
                create: (_) => GetIt.I<EntriesBloc>(),
                child: const EntriesPage(),
              ),
            ),
            GoRoute(
              path: RouteConstants.worldTree,
              name: RouteConstants.worldTreeName,
              builder: (context, state) => const WorldPage(),
            ),
            GoRoute(
              path: RouteConstants.analytics,
              name: RouteConstants.analyticsName,
              builder: (context, state) => const AnalyticsPage(),
            ),
          ],
        ),
        GoRoute(
          path: RouteConstants.selectMemoryType,
          name: RouteConstants.selectMemoryTypeName,
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) => GetIt.I<MemoryBloc>(),
                  ),
                  BlocProvider(
                    create: (_) => GetIt.I<WorldBloc>(),
                  ),
                ],
                child: const SelectMemoryTypePage(),
              ),
            );
          },
        ),
      ],
    );
  }
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
        context.read<NavigationBloc>().add(
              const NavigationTabChanged(NavigationTab.worlds),
            );
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
