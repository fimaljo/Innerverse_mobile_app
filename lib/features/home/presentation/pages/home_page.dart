import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innerverse/core/navigation/route_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Innerverse',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings if you have the route
              // context.go(RouteConstants.settings);
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome to Innerverse ✨',
          style: textTheme.headlineSmall?.copyWith(
            color: colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed(RouteConstants.selectMemoryTypeName);
        },
        icon: const Icon(Icons.add),
        label: Text(
          'New Memory',
          style: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
