import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart' as rive;
import 'package:innerverse/features/world/presentation/blocs/world_bloc.dart';
import 'package:innerverse/features/world/presentation/blocs/world_event.dart';
import 'package:innerverse/features/world/presentation/blocs/world_state.dart';
import 'package:innerverse/features/world/presentation/widgets/rain_animation_widget.dart';
import 'package:innerverse/features/world/presentation/widgets/world_selector_widget.dart';

class WorldPage extends StatefulWidget {
  const WorldPage({super.key});

  @override
  State<WorldPage> createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> with TickerProviderStateMixin {
  rive.SMIInput<double>? _growthInput;
  late AnimationController _updateAnimationController;
  late Animation<double> _updateAnimation;

  @override
  void initState() {
    super.initState();
    _updateAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _updateAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _updateAnimationController,
      curve: Curves.easeInOut,
    ));

    // Load worlds with tree growth when the page initializes
    context.read<WorldBloc>().add(const LoadWorldsWithTreeGrowth());
  }

  @override
  void dispose() {
    _updateAnimationController.dispose();
    super.dispose();
  }

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
        _updateTreeGrowth();
      } else {
        debugPrint("❌ 'input' not found.");
      }
    } else {
      debugPrint('❌ StateMachineController not found.');
    }
  }

  void _updateTreeGrowth() {
    if (_growthInput != null) {
      final worldState = context.read<WorldBloc>().state;
      _growthInput!.value = worldState.treeGrowthValue;

      // Trigger update animation
      _updateAnimationController.forward().then((_) {
        _updateAnimationController.reverse();
      });
    }
  }

  String _getTimeBasedMessage(int hour, bool isTimeBasedNight) {
    if (isTimeBasedNight) {
      if (hour >= 18 || hour < 6) {
        return '🌙 Night Time';
      }
    } else {
      if (hour >= 6 && hour < 12) {
        return '🌅 Morning';
      } else if (hour >= 12 && hour < 18) {
        return '☀️ Afternoon';
      }
    }
    return '🌙 Night Time';
  }

  String _getRainMessage(bool isRaining, int daysSinceLastMemory) {
    if (isRaining) {
      if (daysSinceLastMemory == 1) {
        return '🌧️ It\'s been 1 minute since your last memory';
      } else if (daysSinceLastMemory == 2) {
        return '🌧️💨 It\'s been 2 minutes - the storm is growing stronger';
      } else if (daysSinceLastMemory == 3) {
        return '⛈️ It\'s been 3 minutes - thunder echoes through the darkness';
      } else if (daysSinceLastMemory >= 4 && daysSinceLastMemory <= 7) {
        return '⛈️🌩️ It\'s been $daysSinceLastMemory minutes - a fierce storm rages';
      } else {
        return '🌩️⚡ It\'s been $daysSinceLastMemory minutes - the storm is relentless';
      }
    }
    return '';
  }

  String _getWorldTitle(WorldState state) {
    if (state.selectedWorldId != null &&
        state.worldsWithTreeGrowth.isNotEmpty) {
      final selectedWorld = state.worldsWithTreeGrowth
          .firstWhere((w) => w.world.id == state.selectedWorldId);
      return selectedWorld.world.name;
    }
    return 'Your Inner World';
  }

  List<Color> _getBackgroundColors(WorldState state) {
    // For 1 minute or less, keep the default time-based background
    if (state.daysSinceLastMemory <= 1) {
      return state.isTimeBasedNight
          ? [
              Colors.black,
              Colors.black,
              const Color(0xFF1B263B),
            ]
          : [Colors.blue.shade300, Colors.lightBlue.shade100];
    }

    // For longer gaps, create storm effect - ignore user's actual time
    final intensity = (state.daysSinceLastMemory / 4.0).clamp(0.0, 1.0);

    // Create storm background that gets darker with intensity
    final stormIntensity = 0.2 + (intensity * 0.8); // 20% to 100% darkness

    return [
      Colors.black.withOpacity(stormIntensity),
      Colors.black.withOpacity(stormIntensity),
      const Color(0xFF1B263B).withOpacity(stormIntensity),
    ];
  }

  bool _shouldUseLightText(WorldState state) {
    // Use light text for dark backgrounds, dark text for light backgrounds
    if (state.daysSinceLastMemory <= 1) {
      return state.isTimeBasedNight; // Light text for night, dark text for day
    }

    // For longer gaps, always use light text as background gets darker
    return true; // Always use light text for storm backgrounds
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return BlocListener<WorldBloc, WorldState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
        // Update tree growth when state changes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _updateTreeGrowth();
        });
      },
      child: BlocBuilder<WorldBloc, WorldState>(
        builder: (context, state) {
          return Stack(
            children: [
              // 🌄 Background Sky (day/night)
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: _getBackgroundColors(state),
                  ),
                ),
              ),

              // 🌧️ Rain Animation
              RainAnimationWidget(
                isRaining: state.isRaining,
                daysSinceLastMemory: state.daysSinceLastMemory,
              ),

              // 🌍 World Selector
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: WorldSelectorWidget(),
              ),

              // 📊 Memory Stats Display
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Column(
                    children: [
                      Text(
                        _getWorldTitle(state),
                        style: textTheme.displayMedium?.copyWith(
                          color: _shouldUseLightText(state)
                              ? Colors.white
                              : Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      if (state.isLoading)
                        Column(
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 8),
                            Text(
                              'Updating tree growth...',
                              style: textTheme.bodyMedium?.copyWith(
                                color: _shouldUseLightText(state)
                                    ? Colors.white70
                                    : Colors.black54,
                              ),
                            ),
                          ],
                        )
                      else ...[
                        Text(
                          'Memories: ${state.memoryCount}',
                          style: textTheme.titleMedium?.copyWith(
                            color: _shouldUseLightText(state)
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Average Emotion: ${state.averageEmotionValue.toStringAsFixed(1)}/10',
                          style: textTheme.titleMedium?.copyWith(
                            color: _shouldUseLightText(state)
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 8),
                        AnimatedBuilder(
                          animation: _updateAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: 1.0 + (_updateAnimation.value * 0.1),
                              child: Text(
                                'Tree Growth: ${state.treeGrowthValue.toStringAsFixed(0)}%',
                                style: textTheme.titleMedium?.copyWith(
                                  color: _shouldUseLightText(state)
                                      ? Colors.white70
                                      : Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getTimeBasedMessage(
                              state.currentHour, state.isTimeBasedNight),
                          style: textTheme.titleSmall?.copyWith(
                            color: _shouldUseLightText(state)
                                ? Colors.white60
                                : Colors.black45,
                          ),
                        ),
                        if (state.isRaining) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: _shouldUseLightText(state)
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _shouldUseLightText(state)
                                    ? Colors.white.withOpacity(0.3)
                                    : Colors.black.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              _getRainMessage(
                                  state.isRaining, state.daysSinceLastMemory),
                              style: textTheme.bodySmall?.copyWith(
                                color: _shouldUseLightText(state)
                                    ? Colors.white70
                                    : Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ),

              // 🌳 Tree Animation
              Column(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 2,
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

              // 🔄 Refresh Button
              Positioned(
                top: 50,
                right: 20,
                child: FloatingActionButton.small(
                  onPressed: () {
                    context
                        .read<WorldBloc>()
                        .add(const LoadWorldsWithTreeGrowth());
                  },
                  backgroundColor: _shouldUseLightText(state)
                      ? Colors.white24
                      : Colors.black12,
                  foregroundColor: _shouldUseLightText(state)
                      ? Colors.white
                      : Colors.black87,
                  child: const Icon(Icons.refresh),
                ),
              ),

              // 🌱 Live Update Indicator
              if (state.isLoading)
                Positioned(
                  top: 180,
                  left: 20,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _shouldUseLightText(state)
                          ? Colors.white24
                          : Colors.black12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _shouldUseLightText(state)
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Live',
                          style: textTheme.bodySmall?.copyWith(
                            color: _shouldUseLightText(state)
                                ? Colors.white70
                                : Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
