import 'dart:ui';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:innerverse/core/constants/emoji_options.dart';
import 'package:innerverse/core/events/app_events.dart';
import 'package:innerverse/core/services/event_bus_service.dart';
import 'package:innerverse/features/entries/domain/entities/entry.dart';
import 'package:innerverse/features/entries/presentation/blocs/entries_bloc.dart';
import 'package:innerverse/features/entries/presentation/blocs/entries_event.dart';
import 'package:innerverse/features/entries/presentation/blocs/entries_state.dart';
import 'package:innerverse/features/memory/domain/entities/emoji_option.dart';
import 'package:innerverse/features/memory/domain/entities/memory_creation_data.dart';
import 'package:innerverse/features/memory/presentation/blocs/memory_bloc.dart';
import 'package:innerverse/features/memory/presentation/blocs/memory_event.dart';
import 'package:innerverse/features/memory/presentation/blocs/memory_state.dart';
import 'package:innerverse/features/memory/presentation/widgets/memory_type_step_widget.dart';
import 'package:innerverse/features/memory/presentation/widgets/text_field_step_widget.dart';
import 'package:innerverse/features/memory/presentation/widgets/world_icons_display_widget.dart';
import 'package:innerverse/features/memory/presentation/widgets/world_type_step_widget.dart';
import 'package:innerverse/features/world/data/mappers/world_mapper.dart';
import 'package:innerverse/features/world/presentation/blocs/world_bloc.dart';
import 'package:innerverse/shared/buttons/rounded_icon_button.dart'
    show GradientIconButton;
import 'package:rive/rive.dart' as rive;

class SelectMemoryTypePage extends StatefulWidget {
  // Optional entry for editing mode

  const SelectMemoryTypePage({
    super.key,
    this.entryToEdit,
  });
  final Entry? entryToEdit;

  @override
  State<SelectMemoryTypePage> createState() => _SelectMemoryTypePageState();
}

class _SelectMemoryTypePageState extends State<SelectMemoryTypePage>
    with TickerProviderStateMixin {
  late PageController pageController;
  late PageController emojiPageController;
  late AnimationController animationController;
  late PageController bottomPageController;
  late CurvedAnimation bounceAnimation;
  int selectedIndex = 0;
  int bottomPageIndex = 0;
  int selectedWorldIndex = 0;
  double speed = 5;
  late MemoryCreationData memoryData;
  bool get isEditMode => widget.entryToEdit != null;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeMemoryData();
    _setupListeners();

    // If in edit mode, ensure EntriesBloc is loaded with current entries
    if (isEditMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<EntriesBloc>().add(const LoadEntries());
      });
    }
  }

  void _initializeControllers() {
    emojiPageController = PageController();
    pageController = PageController();
    bottomPageController = PageController();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    bounceAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticOut,
    );
  }

  void _initializeMemoryData() {
    if (isEditMode) {
      // Initialize with existing entry data for editing
      final entry = widget.entryToEdit!;

      // Find the emoji index based on the emoji label
      final emojiIndex =
          emojiOptions.indexWhere((emoji) => emoji.label == entry.emojiLabel);
      selectedIndex = emojiIndex != -1 ? emojiIndex : 0;

      memoryData = MemoryCreationData(
        emojiOption: emojiOptions[selectedIndex],
        emotionSliderValue: entry.emotionSliderValue,
        dateTime: entry.dateTime,
        time: entry.time,
        worldIcons: List.from(entry.worldIcons),
        title: entry.title,
        description: entry.description,
        images: entry.images != null ? List<String>.from(entry.images!) : null,
      );

      speed = entry.emotionSliderValue;
    } else {
      // Initialize with default data for creation
      memoryData = MemoryCreationData(
        emojiOption: emojiOptions[0],
        emotionSliderValue: 5,
        dateTime: DateTime.now(),
        time: TimeOfDay.now(),
        worldIcons: [],
      );
    }

    context.read<MemoryBloc>().add(InitializeMemoryCreation(memoryData));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onEmojiSelected(selectedIndex);
    });
  }

  void _setupListeners() {
    bottomPageController.addListener(() {
      final newIndex = bottomPageController.page?.round() ?? 0;
      if (newIndex != bottomPageIndex) {
        setState(() {
          bottomPageIndex = newIndex;
        });
      }
    });

    emojiPageController.addListener(() {
      final newIndex = emojiPageController.page?.round() ?? 0;
      if (newIndex != selectedWorldIndex) {
        selectedWorldIndex = newIndex;
        if (bottomPageIndex != 2) {
          final state = context.read<WorldBloc>().state;
          if (selectedWorldIndex >= 0 &&
              selectedWorldIndex < state.worlds.length) {
            memoryData.worldIcons = [
              WorldMapper.toModel(state.worlds[selectedWorldIndex])
            ];
            _updateMemoryData();
          }
        }
      }
    });
  }

  void _updateMemoryData() {
    if (mounted) {
      setState(() {});
      context.read<MemoryBloc>().add(UpdateMemoryCreationData(memoryData));
    }
  }

  @override
  void dispose() {
    emojiPageController.dispose();
    pageController.dispose();
    bottomPageController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      syncPageControllers();
    });
  }

  void onEmojiSelected(int index, {bool fromBottom = false}) {
    if (fromBottom) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutBack,
      );
    }

    setState(() {
      selectedIndex = index;
      memoryData.emojiOption = emojiOptions[index];
    });
    _updateMemoryData();
    animationController.forward(from: 0);
    HapticFeedback.lightImpact();
  }

  void onWorldIconSelected(int index) {
    selectedWorldIndex = index;
    final state = context.read<WorldBloc>().state;
    if (index >= 0 && index < state.worlds.length) {
      memoryData.worldIcons = [WorldMapper.toModel(state.worlds[index])];
      _updateMemoryData();
    }
    emojiPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void syncPageControllers() {
    if (pageController.hasClients &&
        pageController.page?.round() != selectedIndex) {
      pageController.animateToPage(
        selectedIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    if (emojiPageController.hasClients &&
        emojiPageController.page?.round() != selectedWorldIndex) {
      emojiPageController.animateToPage(
        selectedWorldIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    final selectedEmoji = memoryData.emojiOption;
    const minSpeed = 2.0;
    const maxSpeed = 8.0;
    const particleCount = 50;

    return MultiBlocListener(
      listeners: [
        BlocListener<EntriesBloc, EntriesState>(
          listener: (context, state) {
            if (isEditMode) {
              if (state is EntriesLoaded) {
                print('✅ Entries loaded successfully for edit mode');
              } else if (state is EntryUpdated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Entry updated successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
                // Emit global event to refresh entries list
                EventBusService().emit(const RefreshEntriesEvent());
              } else if (state is EntriesError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error: ${state.message}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
        ),
        BlocListener<MemoryBloc, MemoryState>(
          listener: (context, state) {
            if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error!)),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<MemoryBloc, MemoryState>(
        builder: (context, state) {
          return _buildScaffold(state);
        },
      ),
    );
  }

  Widget _buildScaffold(MemoryState state) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final selectedEmoji = emojiOptions[selectedIndex];
    final normalized = (speed / 10).clamp(0.0, 1.0);

    final minSpeed = lerpDouble(0, 100, normalized)!;
    final maxSpeed = lerpDouble(0, 200, normalized)!;
    final particleCount = lerpDouble(0, 300, normalized)!.toInt();

    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardVisible = bottomInset > 0;

    return Scaffold(
      body: Column(
        children: [
          _buildAnimatedHeader(
            selectedEmoji,
            textTheme,
            isKeyboardVisible,
            minSpeed,
            maxSpeed,
            particleCount,
          ),
          Expanded(
            child: PageView(
              controller: bottomPageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                MemoryTypeStepWidget(
                  speed: speed,
                  selectedIndex: selectedIndex,
                  selectedEmoji: selectedEmoji,
                  onSpeedChanged: (val) {
                    setState(() {
                      speed = val;
                      memoryData.emotionSliderValue = val;
                    });
                    _updateMemoryData();
                  },
                  onNextPressed: () {
                    bottomPageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  onEmojiSelected: onEmojiSelected,
                  memoryData: memoryData,
                  bounceAnimation: bounceAnimation,
                ),
                TextFieldStepWidget(
                  onBack: () {
                    FocusScope.of(context).unfocus();
                    bottomPageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  onSubmit: () {
                    bottomPageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  selectedData: selectedEmoji,
                  memoryData: memoryData,
                  bottomPageController: bottomPageController,
                  onMemoryDataUpdated: _updateMemoryData,
                ),
                WorldTypeStepWidget(
                  onWorldIconsChanged: (data) {
                    setState(() {
                      memoryData.worldIcons = data;
                    });
                    _updateMemoryData();
                  },
                  onBack: () {
                    FocusScope.of(context).unfocus();
                    bottomPageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  onSubmit: () {
                    if (isEditMode) {
                      // Check if EntriesBloc is ready for update
                      final entriesState = context.read<EntriesBloc>().state;
                      if (entriesState is! EntriesLoaded) {
                        print(
                            '❌ Cannot update entry: EntriesBloc not in EntriesLoaded state');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please wait while entries are loading...'),
                            backgroundColor: Colors.orange,
                          ),
                        );
                        return;
                      }

                      // Update existing entry
                      final updatedEntry = Entry(
                        id: widget.entryToEdit!.id,
                        emojiLabel: memoryData.emojiOption.label,
                        riveAsset: memoryData.emojiOption.riveAsset,
                        emotionSliderValue: memoryData.emotionSliderValue,
                        dateTime: memoryData.dateTime ?? DateTime.now(),
                        time: memoryData.time ?? TimeOfDay.now(),
                        title: memoryData.title,
                        description: memoryData.description,
                        worldIcons: memoryData.worldIcons,
                        images: memoryData.images,
                      );
                      print(
                          '🔄 Submitting update for entry: ${updatedEntry.id}');
                      context
                          .read<EntriesBloc>()
                          .add(UpdateEntry(updatedEntry));
                    } else {
                      // Create new memory
                      context
                          .read<MemoryBloc>()
                          .add(const CreateMemoryFromData());
                    }
                    context.pop();
                  },
                  selectedData: selectedEmoji,
                  memoryData: memoryData,
                  isEditMode: isEditMode,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedHeader(
    EmojiOption selectedEmoji,
    TextTheme textTheme,
    bool isKeyboardVisible,
    double minSpeed,
    double maxSpeed,
    int particleCount,
  ) {
    return AnimatedOpacity(
      opacity: isKeyboardVisible ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Visibility(
        visible: !isKeyboardVisible,
        child: Container(
          height: bottomPageIndex != 2
              ? MediaQuery.of(context).size.height * 0.5
              : MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: selectedEmoji.gradient,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: AnimatedBackground(
              behaviour: RandomParticleBehaviour(
                options: ParticleOptions(
                  baseColor: selectedEmoji.particleColor,
                  maxOpacity: 0.3,
                  spawnMinSpeed: minSpeed,
                  spawnMaxSpeed: maxSpeed,
                  spawnMinRadius: 2,
                  spawnMaxRadius: 5,
                  particleCount: particleCount,
                ),
              ),
              vsync: this,
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    _buildCloseButton(selectedEmoji),
                    if (bottomPageIndex != 2) ...[
                      Text(
                        isEditMode ? 'Edit Memory' : selectedEmoji.label,
                        textAlign: TextAlign.center,
                        style: textTheme.headlineLarge,
                      ),
                      Expanded(
                        child: _buildEmojiPageView(),
                      ),
                    ] else ...[
                      Expanded(
                        child: WorldIconsDisplayWidget(
                          worldIcons: memoryData.worldIcons,
                          selectedIndex: selectedIndex,
                          emojiPageController: emojiPageController,
                          bounceAnimation: bounceAnimation,
                          textTheme: textTheme,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton(EmojiOption selectedEmoji) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: GradientIconButton(
          icon: isEditMode ? Icons.arrow_back : Icons.close,
          onTap: () => context.pop(),
          size: 48,
          gradientColors: selectedEmoji.gradient,
        ),
      ),
    );
  }

  Widget _buildEmojiPageView() {
    return PageView.builder(
      controller: pageController,
      itemCount: emojiOptions.length,
      onPageChanged: onEmojiSelected,
      itemBuilder: (context, index) {
        final isSelected = index == selectedIndex;
        return ScaleTransition(
          scale: isSelected ? bounceAnimation : const AlwaysStoppedAnimation(1),
          child: Transform.translate(
            offset: const Offset(0, -20),
            child: rive.RiveAnimation.asset(
              'assets/rive/innerverse3.riv',
              artboard: emojiOptions[index].riveAsset,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
