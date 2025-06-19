import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innerverse/core/navigation/route_constants.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(RouteConstants.worldTreeName);
        },
      ),
      body: const Center(
        child: Text('Analytics Page'),
      ),
    );
  }
}
