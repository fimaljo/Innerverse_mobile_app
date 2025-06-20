import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innerverse/features/world/presentation/blocs/world_bloc.dart';
import 'package:innerverse/features/world/presentation/blocs/world_event.dart';
import 'package:innerverse/features/world/presentation/blocs/world_state.dart';

class WorldSelectorWidget extends StatelessWidget {
  const WorldSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldBloc, WorldState>(
      builder: (context, state) {
        if (state.worldsWithTreeGrowth.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          height: 120,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.worldsWithTreeGrowth.length,
            itemBuilder: (context, index) {
              final worldWithTreeGrowth = state.worldsWithTreeGrowth[index];
              final world = worldWithTreeGrowth.world;
              final treeGrowthData = worldWithTreeGrowth.treeGrowthData;
              final isSelected = state.selectedWorldId == world.id;

              return GestureDetector(
                onTap: () {
                  context.read<WorldBloc>().add(SelectWorld(world.id));
                },
                child: Container(
                  width: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (treeGrowthData.isNightMode
                            ? Colors.white.withOpacity(0.2)
                            : Colors.black.withOpacity(0.1))
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? (treeGrowthData.isNightMode
                              ? Colors.white.withOpacity(0.5)
                              : Colors.black.withOpacity(0.3))
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // World Icon
                      Icon(
                        world.icon,
                        size: 32,
                        color: treeGrowthData.isNightMode
                            ? Colors.white
                            : Colors.black87,
                      ),
                      const SizedBox(height: 4),
                      // World Name
                      Text(
                        world.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: treeGrowthData.isNightMode
                              ? Colors.white70
                              : Colors.black54,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Tree Growth Indicator
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: treeGrowthData.isRaining
                              ? Colors.red.withOpacity(0.2)
                              : Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${treeGrowthData.treeGrowthValue.toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: treeGrowthData.isNightMode
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      // Memory Count
                      Text(
                        '${treeGrowthData.memoryCount} memories',
                        style: TextStyle(
                          fontSize: 8,
                          color: treeGrowthData.isNightMode
                              ? Colors.white60
                              : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
