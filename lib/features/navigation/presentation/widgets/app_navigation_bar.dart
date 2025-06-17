import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innerverse/features/navigation/domain/entities/navigation_tab_entities.dart';
import 'package:innerverse/features/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:innerverse/features/navigation/presentation/bloc/navigation_event.dart';
import 'package:innerverse/features/navigation/presentation/bloc/navigation_state.dart';
import 'package:innerverse/features/navigation/presentation/widgets/navigation_item.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    required this.currentIndex,
    required this.onNavTap,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onNavTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        final currentTab = state.currentTab;

        return SizedBox(
          height: screenHeight / 9,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Arc background
              Positioned.fill(
                child: CustomPaint(painter: ArcPainter()),
              ),

              // Navigation items row
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Left nav item - Entries
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onTabTap(context, NavigationTab.entries),
                        child: NavigationItem(
                          icon: Icons.description_outlined,
                          label: 'Entries',
                          isActive: currentTab == NavigationTab.entries,
                        ),
                      ),
                    ),

                    // Center nav item - Worlds (with FAB space consideration)
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onTabTap(context, NavigationTab.worlds),
                        child: NavigationItem(
                          icon: Icons
                              .public_outlined, // Changed to a more world-like icon
                          label: 'Worlds',
                          isActive: currentTab == NavigationTab.worlds,
                        ),
                      ),
                    ),

                    // Right nav item - Analytics
                    Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            _onTabTap(context, NavigationTab.analytics),
                        child: NavigationItem(
                          icon: Icons.show_chart,
                          label: 'Analytics',
                          isActive: currentTab == NavigationTab.analytics,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onTabTap(BuildContext context, NavigationTab tab) {
    context.read<NavigationBloc>().add(NavigationTabChanged(tab));
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Slightly reduced curve for better gap filling
    final path = Path()
      ..lineTo(0, 15)
      ..quadraticBezierTo(size.width / 2, -15, size.width, 15)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFF3E7FF),
          Color(0xFFD6B3FA),
        ],
        stops: [0.0, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    // Softer shadow
    canvas
      ..drawShadow(path, Colors.black.withOpacity(0.15), 6, true)
      ..drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
