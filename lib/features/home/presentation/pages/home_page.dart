import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innerverse/core/navigation/route_constants.dart';
import 'package:innerverse/shared/buttons/app_primary_button.dart';
import 'package:rive/rive.dart' as rive;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _currentPage = 1; // Center by default

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  void _onNavTap(int index) {
    setState(() => _currentPage = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        children: const [
          Center(child: Text('Entries Page', style: TextStyle(fontSize: 24))),
          WorldTreePage(),
          Center(child: Text('Analytics Page', style: TextStyle(fontSize: 24))),
        ],
      ),
      bottomNavigationBar: ArcBottomNavBar(
        currentIndex: _currentPage,
        onNavTap: _onNavTap,
      ),
    );
  }
}

class WorldTreePage extends StatefulWidget {
  const WorldTreePage({super.key});

  @override
  State<WorldTreePage> createState() => _WorldTreePageState();
}

class _WorldTreePageState extends State<WorldTreePage> {
  rive.SMIInput<double>? _growthInput;

  void _onRiveInit(rive.Artboard artboard) {
    final controller = rive.StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    );

    if (controller != null) {
      artboard.addController(controller);
      final input = controller.findInput<double>('input');
      if (input != null) {
        _growthInput = input;
        setState(() {
          _growthInput?.value = 0;
        });
      } else {
        debugPrint("❌ 'input' input not found in State Machine 1.");
      }
    } else {
      debugPrint("❌ StateMachineController 'State Machine 1' not found.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_growthInput != null)
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Slider(
              min: 0,
              max: 100,
              divisions: 100,
              label: _growthInput!.value.toStringAsFixed(0),
              value: _growthInput!.value.clamp(0, 100),
              onChanged: (val) {
                setState(() {
                  _growthInput!.value = val;
                });
              },
            ),
          )
        else
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text("Loading animation or missing input..."),
          ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Transform.translate(
              offset: const Offset(-10, 0),
              child: rive.RiveAnimation.asset(
                'assets/rive/tree_demo.riv',
                onInit: _onRiveInit,
                fit: BoxFit.fitHeight, // Makes tree grow from bottom up
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ArcBottomNavBar extends StatelessWidget {
  const ArcBottomNavBar({
    required this.currentIndex,
    required this.onNavTap,
    super.key,
  });
  final int currentIndex;
  final void Function(int) onNavTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return SizedBox(
      height: 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Arc background
          Positioned.fill(child: CustomPaint(painter: ArcPainter())),

          // Left nav item
          Positioned(
            bottom: 20,
            left: 80,
            child: GestureDetector(
              onTap: () => onNavTap(0),
              child: _NavItem(
                icon: Icons.description_outlined,
                label: 'Entries',
                isActive: currentIndex == 0,
              ),
            ),
          ),

          // Right nav item
          Positioned(
            bottom: 20,
            right: 80,
            child: GestureDetector(
              onTap: () => onNavTap(2),
              child: _NavItem(
                icon: Icons.show_chart,
                label: 'Analytics',
                isActive: currentIndex == 2,
              ),
            ),
          ),

          // Center FAB
          Positioned(
            top: 10,
            child: Column(
              children: [
                AppPrimaryButton(
                  onTap: () {
                    context.pushNamed(RouteConstants.selectMemoryTypeName);
                  },
                  height: 50,
                  maxWidth: 50,
                  minWidth: 50,
                  // cornerSide: ButtonCornerSide.right,
                  gradientColors: const [
                    Color(0xFFD6B3FA),
                    Color(0xFFF3E7FF),
                  ],
                  child: Icon(
                    Icons.add,
                    color: colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'World',
                  style: TextStyle(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _NavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      children: [
        Icon(
          icon,
          color: isActive ? colorScheme.onPrimary : colorScheme.onPrimary,
          size: 28,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? colorScheme.onPrimary : colorScheme.onPrimary,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..lineTo(0, 20)
      ..quadraticBezierTo(size.width / 2, -20, size.width, 20)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF3E7FF), Color(0xFFD6B3FA)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas
      ..drawShadow(path, Colors.black, 4, true)
      ..drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
