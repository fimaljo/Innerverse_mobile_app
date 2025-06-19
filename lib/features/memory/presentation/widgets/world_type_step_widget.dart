import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:innerverse/features/memory/domain/entities/emoji_option.dart';
import 'package:innerverse/features/memory/domain/entities/memory_creation_data.dart';
import 'package:innerverse/features/memory/presentation/blocs/memory_bloc.dart';
import 'package:innerverse/features/memory/presentation/blocs/memory_event.dart';
import 'package:innerverse/features/memory/presentation/widgets/world_selection_widget.dart';
import 'package:innerverse/features/world/data/models/world_icon_model.dart';
import 'package:innerverse/features/world/data/mappers/world_mapper.dart';
import 'package:innerverse/features/world/domain/entities/world.dart';
import 'package:innerverse/features/world/presentation/blocs/world_bloc.dart';
import 'package:innerverse/features/world/presentation/blocs/world_event.dart';
import 'package:innerverse/features/world/presentation/blocs/world_state.dart';
import 'package:innerverse/shared/buttons/app_primary_button.dart';
import 'package:innerverse/shared/widgets/custome_text_field.dart';
import 'package:uuid/uuid.dart';

class WorldTypeStepWidget extends StatefulWidget {
  const WorldTypeStepWidget({
    super.key,
    required this.onWorldIconsChanged,
    required this.onBack,
    required this.onSubmit,
    required this.selectedData,
    required this.memoryData,
  });

  final VoidCallback onBack;
  final VoidCallback onSubmit;
  final EmojiOption selectedData;
  final ValueChanged<List<WorldIconModel>> onWorldIconsChanged;
  final MemoryCreationData memoryData;

  @override
  State<WorldTypeStepWidget> createState() => _WorldTypeStepWidgetState();
}

class _WorldTypeStepWidgetState extends State<WorldTypeStepWidget> {
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
    if (widget.memoryData.worldIcons.isNotEmpty) {
      final state = context.read<WorldBloc>().state;
      for (int i = 0; i < state.worlds.length; i++) {
        final world = state.worlds[i];
        if (widget.memoryData.worldIcons
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
        widget.memoryData.worldIcons = [
          ...widget.memoryData.worldIcons,
          newWorldModel
        ];
        nameController.clear();
        pickedIcon = null;
        isAdding = false;
      });

      widget.onWorldIconsChanged(widget.memoryData.worldIcons);
    }
  }

  void _toggleWorldSelection(int index) {
    setState(() {
      if (selectedWorldIndices.contains(index)) {
        selectedWorldIndices.remove(index);
        final state = context.read<WorldBloc>().state;
        if (index < state.worlds.length) {
          final worldToRemove = state.worlds[index];
          widget.memoryData.worldIcons.removeWhere(
            (w) => w.icon == worldToRemove.icon && w.name == worldToRemove.name,
          );
        }
      } else {
        selectedWorldIndices.add(index);
        final state = context.read<WorldBloc>().state;
        if (index < state.worlds.length) {
          final worldToAdd = WorldMapper.toModel(state.worlds[index]);
          widget.memoryData.worldIcons = [
            ...widget.memoryData.worldIcons,
            worldToAdd
          ];
        }
      }
    });

    widget.onWorldIconsChanged(widget.memoryData.worldIcons);
  }

  void _saveMemory() {
    final memory = widget.memoryData.toMemory();
    context.read<MemoryBloc>().add(AddMemory(memory));
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final allIcons = [
      Icons.star,
      Icons.favorite,
      Icons.home,
      Icons.person,
      Icons.music_note,
      Icons.ac_unit,
      Icons.cake,
      Icons.beach_access,
      Icons.book,
      Icons.camera_alt,
      Icons.flight,
      Icons.flag,
      Icons.lightbulb,
      Icons.mood,
      Icons.phone,
    ];

    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return BlocListener<WorldBloc, WorldState>(
      listener: (context, state) {
        if (!state.isLoading && state.worlds.isNotEmpty) {
          if (widget.memoryData.worldIcons.isNotEmpty) {
            final newSelectedIndices = <int>{};
            for (int i = 0; i < state.worlds.length; i++) {
              final world = state.worlds[i];
              if (widget.memoryData.worldIcons
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
          return Scaffold(
            bottomNavigationBar: !isAdding
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppPrimaryButton(
                        onTap: widget.onBack,
                        height: 80,
                        maxWidth: 70,
                        minWidth: 70,
                        cornerSide: ButtonCornerSide.left,
                        gradientColors: widget.selectedData.gradient,
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                      AppPrimaryButton(
                        onTap: _saveMemory,
                        height: 80,
                        maxWidth: 70,
                        minWidth: 70,
                        cornerSide: ButtonCornerSide.right,
                        gradientColors: widget.selectedData.gradient,
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            body: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(textTheme),
                        if (!isAdding) ...[
                          _buildSelectedCount(textTheme),
                          _buildWorldGrid(state),
                        ],
                        if (isAdding) ...[
                          _buildAddWorldForm(textTheme, colorScheme, allIcons),
                        ],
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
      child: Text(
        isAdding
            ? 'Create Your World Symbol'
            : 'Pick Your World Symbols (${selectedWorldIndices.length} selected)',
        style: textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSelectedCount(TextTheme textTheme) {
    if (selectedWorldIndices.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${selectedWorldIndices.length} world${selectedWorldIndices.length == 1 ? '' : 's'} selected',
            style: textTheme.bodyMedium?.copyWith(
              color: widget.selectedData.gradient.first,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                selectedWorldIndices.clear();
                widget.memoryData.worldIcons.clear();
              });
            },
            child: Text(
              'Clear All',
              style: TextStyle(
                color: widget.selectedData.gradient.first,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorldGrid(WorldState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          ...state.worlds.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = selectedWorldIndices.contains(index);
            return GestureDetector(
              onTap: () => _toggleWorldSelection(index),
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
                            ? widget.selectedData.gradient.first
                            : Colors.grey[200],
                        border: isSelected
                            ? Border.all(
                                color: widget.selectedData.gradient.last,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Icon(
                        item.icon,
                        size: 28,
                        color: isSelected ? Colors.white : Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 11,
                        color: isSelected
                            ? widget.selectedData.gradient.first
                            : Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }),
          GestureDetector(
            onTap: () => setState(() => isAdding = true),
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
                        colors: widget.selectedData.gradient,
                      ),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  const Text('Add', style: TextStyle(fontSize: 11)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddWorldForm(
      TextTheme textTheme, ColorScheme colorScheme, List<IconData> allIcons) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomeTextField(
            controller: nameController,
            hintText: 'Add World Name...',
            fontSize: 16,
            validator: (p0) => null,
            textStyle: textTheme.titleMedium,
            animateHint: true,
            hintColor: colorScheme.outlineVariant,
            textColor: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Choose an Icon',
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: allIcons.map((icon) {
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
                        ? Border.all(color: colorScheme.onPrimaryContainer)
                        : null,
                  ),
                  child: Icon(
                    icon,
                    size: 28,
                    color: Colors.grey,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              AppPrimaryButton(
                onTap: _addWorldSymbol,
                height: 50,
                maxWidth: 50,
                minWidth: 50,
                gradientColors: widget.selectedData.gradient,
                child: const Icon(Icons.check, color: Colors.white),
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
                gradientColors: widget.selectedData.gradient,
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
