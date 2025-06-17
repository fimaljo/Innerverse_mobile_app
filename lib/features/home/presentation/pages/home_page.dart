import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innerverse/features/navigation/domain/entities/navigation_tab_entities.dart';
import 'package:innerverse/features/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:innerverse/features/navigation/presentation/bloc/navigation_event.dart';
import 'package:innerverse/features/navigation/presentation/bloc/navigation_state.dart';
import 'package:innerverse/features/navigation/presentation/widgets/app_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return AppNavigationBar(
            currentIndex: state.currentTab.index,
            onNavTap: (index) {
              final tab = NavigationTab.values[index];
              if (tab != state.currentTab && !state.isLoading) {
                context.read<NavigationBloc>().add(NavigationTabChanged(tab));
              }
            },
          );
        },
      ),
    );
  }
}
