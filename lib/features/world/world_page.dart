import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;

class WorldPage extends StatefulWidget {
  const WorldPage({super.key});

  @override
  State<WorldPage> createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
  rive.SMIInput<double>? _growthInput;

  double growthValue = 0;

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
          growthValue = 0;
        });
      } else {
        debugPrint("❌ 'input' not found.");
      }
    } else {
      debugPrint('❌ StateMachineController not found.');
    }
  }

  bool get isNight => growthValue < 50;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Stack(
      children: [
        // 🌄 Background Sky (day/night)
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isNight
                  ? [
                      Colors.black, // Navy blue
                      Colors.black, // Navy blue
                      const Color(0xFF1B263B), // Slightly lighter navy
                    ]
                  : [Colors.blue.shade300, Colors.lightBlue.shade100],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 200), // adjust as needed
            child: Text(
              'Family',
              style: textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),

        // 🌳 Tree Animation
        Column(
          children: [
            if (_growthInput != null)
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Slider(
                  max: 100,
                  divisions: 100,
                  label: growthValue.toStringAsFixed(0),
                  value: growthValue.clamp(0, 100),
                  onChanged: (val) {
                    setState(() {
                      growthValue = val;
                      _growthInput?.value = val;
                    });
                  },
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Loading animation or missing input...'),
              ),

            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Transform.translate(
                  offset: const Offset(-10, 0),
                  child: SizedBox(
                    height: 400,
                    child: rive.RiveAnimation.asset(
                      'assets/rive/tree_demo.riv',
                      onInit: _onRiveInit,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
