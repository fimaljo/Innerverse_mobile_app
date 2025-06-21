import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innerverse/features/memory/domain/entities/emoji_option.dart';
import 'package:innerverse/features/world/data/models/world_icon_model.dart';
import 'package:innerverse/features/world/domain/entities/world.dart';
import 'package:innerverse/features/world/presentation/blocs/world_bloc.dart';
import 'package:innerverse/features/world/presentation/blocs/world_event.dart';
import 'package:innerverse/features/world/presentation/blocs/world_state.dart';
import 'package:innerverse/features/memory/presentation/constants/memory_creation_constants.dart';
import 'package:innerverse/shared/buttons/app_primary_button.dart';
import 'package:innerverse/shared/widgets/custome_text_field.dart';
import 'package:uuid/uuid.dart';

/// Widget for selecting world icons in memory creation
class WorldSelectionWidget extends StatefulWidget {
  const WorldSelectionWidget({
    required this.selectedEmoji,
    required this.onWorldIconsChanged,
    required this.initialWorldIcons,
    super.key,
  });

  final EmojiOption selectedEmoji;
  final ValueChanged<List<WorldIconModel>> onWorldIconsChanged;
  final List<WorldIconModel> initialWorldIcons;

  @override
  State<WorldSelectionWidget> createState() => _WorldSelectionWidgetState();
}

class _WorldSelectionWidgetState extends State<WorldSelectionWidget> {
  bool isAdding = false;
  IconData? pickedIcon;
  final TextEditingController nameController = TextEditingController();
  Set<int> selectedWorldIndices = {};

  @override
  void initState() {
    super.initState();
    context.read<WorldBloc>().add(const LoadWorlds());
    _initializeSelectedIndices();
  }

  void _initializeSelectedIndices() {
    if (widget.initialWorldIcons.isNotEmpty) {
      final state = context.read<WorldBloc>().state;
      for (var i = 0; i < state.worlds.length; i++) {
        final world = state.worlds[i];
        if (widget.initialWorldIcons
            .any((w) => w.icon == world.icon && w.name == world.name)) {
          selectedWorldIndices.add(i);
        }
      }
    }
  }

  void _addWorldSymbol() {
    final name = nameController.text.trim();
    if (name.isNotEmpty && pickedIcon != null) {
      final newWorld = World(
        id: const Uuid().v4(),
        name: name,
        icon: pickedIcon!,
      );
      context.read<WorldBloc>().add(AddWorld(newWorld));

      setState(() {
        final newWorldModel = WorldIconModel(
          id: newWorld.id,
          name: name,
          icon: pickedIcon!,
        );
        final updatedWorldIcons = [...widget.initialWorldIcons, newWorldModel];
        widget.onWorldIconsChanged(updatedWorldIcons);
        nameController.clear();
        pickedIcon = null;
        isAdding = false;
      });
    }
  }

  void _toggleWorldSelection(int index) {
    setState(() {
      if (selectedWorldIndices.contains(index)) {
        selectedWorldIndices.remove(index);
        final state = context.read<WorldBloc>().state;
        if (index < state.worlds.length) {
          final worldToRemove = state.worlds[index];
          final updatedWorldIcons = widget.initialWorldIcons
              .where((w) => !(w.icon == worldToRemove.icon &&
                  w.name == worldToRemove.name))
              .toList();
          widget.onWorldIconsChanged(updatedWorldIcons);
        }
      } else {
        selectedWorldIndices.add(index);
        final state = context.read<WorldBloc>().state;
        if (index < state.worlds.length) {
          final worldToAdd = WorldIconModel(
            id: state.worlds[index].id,
            name: state.worlds[index].name,
            icon: state.worlds[index].icon,
          );
          final updatedWorldIcons = [...widget.initialWorldIcons, worldToAdd];
          widget.onWorldIconsChanged(updatedWorldIcons);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocListener<WorldBloc, WorldState>(
      listener: (context, state) {
        if (!state.isLoading && state.worlds.isNotEmpty) {
          if (widget.initialWorldIcons.isNotEmpty) {
            final newSelectedIndices = <int>{};
            for (var i = 0; i < state.worlds.length; i++) {
              final world = state.worlds[i];
              if (widget.initialWorldIcons
                  .any((w) => w.icon == world.icon && w.name == world.name)) {
                newSelectedIndices.add(i);
              }
            }
            if (newSelectedIndices != selectedWorldIndices) {
              setState(() {
                selectedWorldIndices = newSelectedIndices;
              });
            }
          }
        }
      },
      child: BlocBuilder<WorldBloc, WorldState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAdding
                      ? 'Create Your World Symbol'
                      : 'Pick Your World Symbols (${selectedWorldIndices.length} selected)',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!isAdding) ...[
                  if (selectedWorldIndices.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: MemoryCreationConstants.defaultPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${selectedWorldIndices.length} world${selectedWorldIndices.length == 1 ? '' : 's'} selected',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: widget.selectedEmoji.gradient.first,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                selectedWorldIndices.clear();
                                widget.onWorldIconsChanged([]);
                              });
                            },
                            child: Text(
                              'Clear All',
                              style: TextStyle(
                                color: widget.selectedEmoji.gradient.first,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                        height: MemoryCreationConstants.smallPadding),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: MemoryCreationConstants.defaultPadding,
                      vertical: MemoryCreationConstants.largePadding,
                    ),
                    child: Wrap(
                      spacing: MemoryCreationConstants.worldIconSpacing,
                      runSpacing: MemoryCreationConstants.worldIconSpacing,
                      children: [
                        ...state.worlds.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          final isSelected =
                              selectedWorldIndices.contains(index);
                          return _WorldIconItem(
                            world: item,
                            isSelected: isSelected,
                            onTap: () => _toggleWorldSelection(index),
                            selectedEmoji: widget.selectedEmoji,
                          );
                        }),
                        _AddWorldIconItem(
                          onTap: () => setState(() => isAdding = true),
                          selectedEmoji: widget.selectedEmoji,
                        ),
                      ],
                    ),
                  ),
                ],
                if (isAdding) ...[
                  const SizedBox(height: MemoryCreationConstants.largePadding),
                  CustomeTextField(
                    controller: nameController,
                    hintText: 'Add World Name...',
                    fontSize: 16,
                    validator: (p0) => null,
                    textStyle: theme.textTheme.titleMedium,
                    animateHint: true,
                    hintColor: colorScheme.outlineVariant,
                    textColor: Colors.black,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: MemoryCreationConstants.largePadding,
                    ),
                    child: Text(
                      'Choose an Icon',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: MemoryCreationConstants.largePadding,
                    ),
                    child: Wrap(
                      spacing: MemoryCreationConstants.worldIconSpacing,
                      runSpacing: MemoryCreationConstants.worldIconSpacing,
                      children: _getAvailableIcons().map((icon) {
                        final isSelected = pickedIcon == icon;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              pickedIcon = icon;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[200],
                              border: isSelected
                                  ? Border.all(
                                      color: colorScheme.onPrimaryContainer,
                                    )
                                  : null,
                            ),
                            child: Icon(
                              icon,
                              size: MemoryCreationConstants.worldIconSize,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: MemoryCreationConstants.largePadding,
                    ),
                    child: Row(
                      children: [
                        AppPrimaryButton(
                          onTap: _addWorldSymbol,
                          height: 50,
                          maxWidth: 50,
                          minWidth: 50,
                          gradientColors: widget.selectedEmoji.gradient,
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        AppPrimaryButton(
                          onTap: () {
                            setState(() {
                              isAdding = false;
                              nameController.clear();
                              pickedIcon = null;
                            });
                          },
                          height: 50,
                          maxWidth: 50,
                          minWidth: 50,
                          gradientColors: widget.selectedEmoji.gradient,
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  List<IconData> _getAvailableIcons() {
    return [
      Icons.star_outline,
      Icons.favorite_outline,
      Icons.home_outlined,
      Icons.person_outline,
      Icons.music_note_outlined,
      Icons.ac_unit_outlined,
      Icons.cake_outlined,
      Icons.beach_access_outlined,
      Icons.book_outlined,
      Icons.camera_alt_outlined,
      Icons.flight_outlined,
      Icons.flag_outlined,
      Icons.lightbulb_outline,
      Icons.mood_outlined,
      Icons.phone_outlined,

      // Newly added outline icons:
      Icons.pets_outlined,
      Icons.shopping_cart_outlined,
      Icons.sports_esports_outlined,
      Icons.fitness_center_outlined,
      Icons.local_cafe_outlined,
      Icons.movie_outlined,
      Icons.park_outlined,
      Icons.palette_outlined,
      Icons.wb_sunny_outlined,
      Icons.bolt_outlined,
      Icons.brush_outlined,
      Icons.directions_walk_outlined,
      Icons.nightlight_outlined,
      Icons.emoji_nature_outlined,
      Icons.public_outlined,
      Icons.umbrella_outlined,
      Icons.construction_outlined,
    ];
  }
}

/// Individual world icon item widget
class _WorldIconItem extends StatelessWidget {
  const _WorldIconItem({
    required this.world,
    required this.isSelected,
    required this.onTap,
    required this.selectedEmoji,
  });

  final World world;
  final bool isSelected;
  final VoidCallback onTap;
  final EmojiOption selectedEmoji;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4 - 24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? selectedEmoji.gradient.first
                    : Colors.grey[200],
                border: isSelected
                    ? Border.all(
                        color: selectedEmoji.gradient.last,
                        width: 2,
                      )
                    : null,
              ),
              child: Icon(
                world.icon,
                size: MemoryCreationConstants.worldIconSize,
                color: isSelected ? Colors.white : Colors.grey[800],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              world.name,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? selectedEmoji.gradient.first : Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Add world icon item widget
class _AddWorldIconItem extends StatelessWidget {
  const _AddWorldIconItem({
    required this.onTap,
    required this.selectedEmoji,
  });

  final VoidCallback onTap;
  final EmojiOption selectedEmoji;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4 - 24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: selectedEmoji.gradient,
                ),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            const SizedBox(height: 6),
            const Text('Add', style: TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
