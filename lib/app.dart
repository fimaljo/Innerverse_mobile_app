// lib/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innerverse/core/navigation/app_router.dart';
import 'package:innerverse/core/themes/app_theme.dart';

class InnerverseApp extends StatelessWidget {
  const InnerverseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Innerverse',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}

  // Uncomment when BLoCs are implemented
        // BlocProvider<AuthBloc>(
        //   create: (context) => di.sl<AuthBloc>()..add(const CheckAuthStatusEvent()),
        // ),
        // BlocProvider<MemoryBloc>(
        //   create: (context) => di.sl<MemoryBloc>(),
        // ),
        // BlocProvider<WorldBloc>(
        //   create: (context) => di.sl<WorldBloc>()..add(const LoadWorldsEvent()),
        // ),