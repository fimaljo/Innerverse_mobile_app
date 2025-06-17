import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:innerverse/core/di/injection_container.dart';
import 'package:innerverse/core/themes/app_theme.dart';
import 'package:innerverse/features/navigation/presentation/bloc/navigation_bloc.dart';

class InnerverseApp extends StatelessWidget {
  const InnerverseApp({required this.router, super.key});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<NavigationBloc>(
              create: (_) => sl<NavigationBloc>(),
            ),
          ],
          child: MaterialApp.router(
            title: 'Innerverse',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: router,
          ),
        );
      },
    );
  }
}
