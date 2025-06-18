import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:innerverse/core/constants/emoji_options.dart';
import 'package:innerverse/features/memory/data/repositories/world_icon_repository.dart';
import 'package:innerverse/features/memory/domain/entities/emoji_option.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';
import 'package:innerverse/features/memory/domain/entities/world_icon.dart';
import 'package:innerverse/features/memory/presentation/blocs/memory_bloc.dart';
import 'package:innerverse/features/memory/presentation/blocs/memory_event.dart';
import 'package:innerverse/shared/buttons/app_primary_button.dart';
import 'package:innerverse/shared/buttons/rounded_icon_button.dart'
    show GradientIconButton;
import 'package:innerverse/shared/widgets/custome_text_field.dart';
import 'package:rive/rive.dart' as rive;
import 'package:uuid/uuid.dart';

class MemoryCreationData {
  MemoryCreationData({
    required this.emojiOption,
    required this.emotionSliderValue,
    this.dateTime,
    this.time,
    this.title,
    this.description,
    this.worldIcon,
    this.worldIconTitle,
  });

  EmojiOption emojiOption;
  double emotionSliderValue;
  DateTime? dateTime;
  TimeOfDay? time;
  String? title;
  String? description;
  IconData? worldIcon;
  String? worldIconTitle;

  Memory toMemory() {
    return Memory.fromEmojiOption(
      id: const Uuid().v4(),
      emojiOption: emojiOption,
      emotionSliderValue: emotionSliderValue,
      dateTime: dateTime ?? DateTime.now(),
      time: time ?? TimeOfDay.now(),
      title: title,
      description: description,
      worldIcon: worldIcon ?? Icons.star,
      worldIconTitle: worldIconTitle ?? 'Default',
    );
  }
}

class SelectMemoryTypePage extends StatefulWidget {
  const SelectMemoryTypePage({super.key});

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
  List<WorldIcon> worldIcons = [];
  late MemoryCreationData memoryData;
  late WorldIconRepository _repository;

  @override
  void initState() {
    super.initState();
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

    memoryData = MemoryCreationData(
      emojiOption: emojiOptions[0],
      emotionSliderValue: 5,
      dateTime: DateTime.now(),
      time: TimeOfDay.now(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onEmojiSelected(0);
    });

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
        setState(() {
          selectedWorldIndex = newIndex;
          if (selectedWorldIndex >= 0 &&
              selectedWorldIndex < worldIcons.length) {
            memoryData.worldIcon = worldIcons[selectedWorldIndex].icon;
            memoryData.worldIconTitle = worldIcons[selectedWorldIndex].name;
          }
        });
      }
    });

    _initializeRepository();
  }

  @override
  void dispose() {
    emojiPageController.dispose();
    pageController.dispose();
    bottomPageController.dispose();
    animationController.dispose();
    super.dispose();
  }

  Future<void> _initializeRepository() async {
    _repository = WorldIconRepository();
    await _repository.init();
    await _repository.initializeDefaultIcons();
    setState(() {
      worldIcons = _repository.getAllWorldIcons();
    });
  }

  void _handleWorldIconsChanged(List<WorldIcon> data) {
    setState(() {
      worldIcons = data;
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

    setState(() => selectedIndex = index);
    animationController.forward(from: 0);
    HapticFeedback.lightImpact();
  }

  void onWorldIconSelected(int index) {
    setState(() {
      selectedWorldIndex = index;
      memoryData.worldIcon = worldIcons[index].icon;
      memoryData.worldIconTitle = worldIcons[index].name;
    });
    emojiPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
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
          AnimatedOpacity(
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
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: GradientIconButton(
                                icon: Icons.close,
                                onTap: () => context.pop(),
                                size: 48,
                                gradientColors: selectedEmoji.gradient,
                              ),
                            ),
                          ),
                          if (bottomPageIndex != 2) ...[
                            Text(
                              selectedEmoji.label,
                              textAlign: TextAlign.center,
                              style: textTheme.headlineLarge,
                            ),
                            Expanded(
                              child: PageView.builder(
                                controller: pageController,
                                itemCount: emojiOptions.length,
                                onPageChanged: onEmojiSelected,
                                itemBuilder: (context, index) {
                                  final isSelected = index == selectedIndex;
                                  return ScaleTransition(
                                    scale: isSelected
                                        ? bounceAnimation
                                        : const AlwaysStoppedAnimation(1),
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
                              ),
                            ),
                          ] else ...[
                            Expanded(
                              child: PageView.builder(
                                controller: emojiPageController,
                                itemCount: worldIcons.length,
                                itemBuilder: (context, index) {
                                  final isSelected =
                                      index == selectedWorldIndex;
                                  return ScaleTransition(
                                    scale: isSelected
                                        ? bounceAnimation
                                        : const AlwaysStoppedAnimation(1),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              colors:
                                                  emojiOptions[selectedIndex]
                                                      .gradient,
                                            ),
                                          ),
                                          child: Icon(
                                            worldIcons[index].icon,
                                            size: 60,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          worldIcons[index].name,
                                          textAlign: TextAlign.center,
                                          style: textTheme.headlineLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
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
          ),
          Expanded(
            child: PageView(
              controller: bottomPageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _MemoryTypeStep(
                  speed: speed,
                  selectedIndex: selectedIndex,
                  selectedEmoji: selectedEmoji,
                  onSpeedChanged: (val) {
                    setState(() {
                      speed = val;
                    });
                  },
                  onNextPressed: () {
                    bottomPageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  onEmojiSelected: onEmojiSelected,
                  memoryData: memoryData,
                ),
                _TextFieldStep(
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
                ),
                _WorldTypeStep(
                  onWorldIconsChanged: _handleWorldIconsChanged,
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
                  onWorldIconSelected: onWorldIconSelected,
                  selectedWorldIndex: selectedWorldIndex,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WorldTypeStep extends StatefulWidget {
  const _WorldTypeStep({
    required this.onBack,
    required this.onSubmit,
    required this.selectedData,
    required this.onWorldIconsChanged,
    required this.memoryData,
    required this.onWorldIconSelected,
    required this.selectedWorldIndex,
  });

  final VoidCallback onBack;
  final VoidCallback onSubmit;
  final EmojiOption selectedData;
  final ValueChanged<List<WorldIcon>> onWorldIconsChanged;
  final MemoryCreationData memoryData;
  final ValueChanged<int> onWorldIconSelected;
  final int selectedWorldIndex;

  @override
  State<_WorldTypeStep> createState() => _WorldTypeStepState();
}

class _WorldTypeStepState extends State<_WorldTypeStep> {
  late WorldIconRepository _repository;
  List<WorldIcon> worldIcons = [];
  bool isAdding = false;
  IconData? pickedIcon;
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeRepository();
  }

  Future<void> _initializeRepository() async {
    _repository = WorldIconRepository();
    await _repository.init();
    await _repository.initializeDefaultIcons();
    setState(() {
      worldIcons = _repository.getAllWorldIcons();
    });
  }

  void _addWorldSymbol() {
    final name = nameController.text.trim();
    if (name.isNotEmpty && pickedIcon != null) {
      final newIcon = WorldIcon(name: name, icon: pickedIcon!);
      _repository.addWorldIcon(newIcon);
      setState(() {
        worldIcons = _repository.getAllWorldIcons();
        widget.memoryData.worldIcon = pickedIcon;
        widget.memoryData.worldIconTitle = name;
        nameController.clear();
        pickedIcon = null;
        isAdding = false;
      });
      widget.onWorldIconsChanged(worldIcons);
    }
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
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
              child: Text(
                isAdding
                    ? 'Create Your World Symbol'
                    : 'Pick Your World Symbols',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            if (!isAdding) ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ...worldIcons.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      final isSelected = index == widget.selectedWorldIndex;
                      return GestureDetector(
                        onTap: () => widget.onWorldIconSelected(index),
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
                                          color:
                                              widget.selectedData.gradient.last,
                                          width: 2,
                                        )
                                      : null,
                                ),
                                child: Icon(
                                  item.icon,
                                  size: 28,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey[800],
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
              ),
            ],

            if (isAdding) ...[
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomeTextField(
                  controller: nameController,
                  hintText: 'Add World Name...',
                  fontSize: 16,
                  validator: (p0) {
                    return null;
                  },
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
                  style: theme.textTheme.bodyLarge?.copyWith(
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
                          // color: isSelected
                          //     ? widget.selectedData.gradient.last
                          //     : Colors.grey[200],
                          color: Colors.grey[200],
                          border: isSelected
                              ? Border.all(
                                  color: colorScheme.onPrimaryContainer,
                                )
                              : null,
                        ),
                        child: Icon(
                          icon,
                          size: 28,
                          // color: isSelected
                          //     ? widget.selectedData.gradient.first
                          //     : Colors.grey,
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
                      //  cornerSide: ButtonCornerSide.left,
                      gradientColors: widget.selectedData.gradient,
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
                      // cornerSide: ButtonCornerSide.left,
                      gradientColors: widget.selectedData.gradient,
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
      ),
    );
  }
}

class _TextFieldStep extends StatefulWidget {
  const _TextFieldStep({
    required this.onBack,
    required this.onSubmit,
    required this.selectedData,
    required this.memoryData,
    required this.bottomPageController,
  });

  final VoidCallback onBack;
  final VoidCallback onSubmit;
  final EmojiOption selectedData;
  final MemoryCreationData memoryData;
  final PageController bottomPageController;

  @override
  State<_TextFieldStep> createState() => _TextFieldStepState();
}

class _TextFieldStepState extends State<_TextFieldStep> {
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  bool isKeyboardVisible = false;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  late final StreamSubscription<bool> _keyboardSubscription;

  @override
  void initState() {
    super.initState();
    final keyboardVisibilityController = KeyboardVisibilityController();

    isKeyboardVisible = keyboardVisibilityController.isVisible;

    _keyboardSubscription = keyboardVisibilityController.onChange.listen((
      bool visible,
    ) {
      setState(() {
        isKeyboardVisible = visible;
      });
    });
  }

  @override
  void dispose() {
    _keyboardSubscription.cancel();
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final today = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(today.year - 5),
      lastDate: today, // 👈 prevent future dates
      helpText: 'Select Memory Date',
      cancelText: 'Cancel',
      confirmText: 'Select',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: widget.selectedData.gradient.first, // Header & buttons
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        widget.memoryData.dateTime = date;
      });
    }
  }

  Future<void> pickTime() async {
    final now = TimeOfDay.now();

    final time = await showTimePicker(
      context: context,
      initialTime: now,
      helpText: 'Select Memory Time',
      cancelText: 'Cancel',
      confirmText: 'Select',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: widget.selectedData.gradient.first,
              secondary: widget.selectedData.gradient.first,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      final nowTime = TimeOfDay.now();
      final isBeforeNow =
          time.hour < nowTime.hour ||
          (time.hour == nowTime.hour && time.minute <= nowTime.minute);

      if (widget.memoryData.dateTime != null &&
          widget.memoryData.dateTime!.isAtSameMomentAs(DateTime.now()) &&
          !isBeforeNow) {
        // Show warning or ignore
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Future time not allowed')),
          );
        }
        return;
      }

      setState(() {
        widget.memoryData.time = time;
      });
    }
  }

  void _saveMemory() {
    widget.memoryData.title = titleController.text.trim();
    widget.memoryData.description = noteController.text.trim();

    widget.memoryData.toMemory();
    widget.bottomPageController.nextPage(
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
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: !isKeyboardVisible,
            child: AppPrimaryButton(
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
          ),
          AppPrimaryButton(
            onTap: () {
              FocusScope.of(context).unfocus();
              _saveMemory();
            },
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: isKeyboardVisible ? 60 : 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Describe your memory', style: textTheme.titleMedium),
              const SizedBox(height: 20),
              Row(
                children: [
                  // 🗓 Date Picker
                  InkWell(
                    onTap: pickDate,
                    borderRadius: BorderRadius.circular(12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          (widget.memoryData.dateTime ?? DateTime.now()) != null
                              ? '${(widget.memoryData.dateTime ?? DateTime.now()).day}/${(widget.memoryData.dateTime ?? DateTime.now()).month}/${(widget.memoryData.dateTime ?? DateTime.now()).year}'
                              : 'Pick a date',
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // ⏰ Time Picker
                  InkWell(
                    onTap: pickTime,
                    borderRadius: BorderRadius.circular(12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          (widget.memoryData.time ?? TimeOfDay.now()).format(
                            context,
                          ),
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Title Field
              CustomeTextField(
                controller: titleController,
                hintText: 'Title...',
                validator: (_) => null,
                textStyle: textTheme.titleMedium,
                animateHint: true,
                hintColor: colorScheme.outlineVariant,
                textColor: Colors.black,
              ),

              // Note Field
              CustomeTextField(
                controller: noteController,
                hintText: 'Add some notes...',
                validator: (_) => null,
                textStyle: textTheme.titleMedium,
                animateHint: true,
                hintColor: colorScheme.outlineVariant,
                textColor: Colors.black,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _MemoryTypeStep extends StatelessWidget {
  const _MemoryTypeStep({
    required this.speed,
    required this.selectedIndex,
    required this.selectedEmoji,
    required this.onSpeedChanged,
    required this.onNextPressed,
    required this.onEmojiSelected,
    required this.memoryData,
  });

  final double speed;
  final int selectedIndex;
  final EmojiOption selectedEmoji;
  final void Function(double) onSpeedChanged;
  final VoidCallback onNextPressed;
  final void Function(int index, {bool fromBottom}) onEmojiSelected;
  final MemoryCreationData memoryData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(emojiOptions.length, (index) {
                  final isActive = index == selectedIndex;
                  return GestureDetector(
                    onTap: () {
                      onEmojiSelected(index, fromBottom: true);
                      memoryData.emojiOption = emojiOptions[index];
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (isActive)
                            Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(),
                              ),
                            ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: emojiOptions[index].gradient,
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              border: Border.all(
                                width: isActive ? 1 : 0.5,
                              ),
                            ),
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              Text(
                'How does \nthis memory feel?',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: HalfCircleSliderWithAppButton(
            selectedData: selectedEmoji,
            gradientColors: selectedEmoji.gradient,
            onChanged: (value) {
              onSpeedChanged(value);
              memoryData.emotionSliderValue = value;
            },
            onNextPressed: onNextPressed,
          ),
        ),
      ],
    );
  }
}

class HalfCircleSliderWithAppButton extends StatefulWidget {
  const HalfCircleSliderWithAppButton({
    required this.gradientColors,
    required this.onChanged,
    required this.selectedData,
    required this.onNextPressed,
    super.key,
  });
  final List<Color> gradientColors;
  final void Function(double value) onChanged;
  final EmojiOption selectedData;
  final VoidCallback onNextPressed;

  @override
  State<HalfCircleSliderWithAppButton> createState() =>
      _HalfCircleSliderWithAppButtonState();
}

class _HalfCircleSliderWithAppButtonState
    extends State<HalfCircleSliderWithAppButton> {
  double sliderValue = 5;

  void _updateSlider(Offset localPosition, Size size) {
    final center = Offset(size.width / 2, size.height);
    final dx = localPosition.dx - center.dx;
    final dy = localPosition.dy - center.dy;
    final angle = atan2(dy, dx);

    if (angle >= -pi && angle <= 0) {
      final normalized = 1 - (angle.abs() / pi); // 0 (left) to 1 (right)
      final rawValue = normalized * 10; // 0 to 10
      final snappedValue = rawValue.round().clamp(0, 10).toDouble();

      if (snappedValue != sliderValue) {
        HapticFeedback.lightImpact(); // Trigger vibration only if value changes
        setState(() => sliderValue = snappedValue);
        widget.onChanged(sliderValue);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        // Limit max size based on available space (esp. height)
        final maxAvailableWidth = constraints.maxWidth;
        final maxAvailableHeight = constraints.maxHeight;

        // Pick the smallest to avoid overflow
        final double size = min(maxAvailableWidth, maxAvailableHeight * 0.7);
        final radius = size / 2;
        final strokeWidth = size / 7;

        return GestureDetector(
          onPanUpdate: (details) {
            final box = context.findRenderObject()! as RenderBox;
            _updateSlider(box.globalToLocal(details.globalPosition), box.size);
          },
          child: SizedBox(
            width: size,
            height: radius + 60, // reduced from +70 to +60
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomPaint(
                  size: Size(size, radius),
                  painter: GradientArcPainter(
                    value: sliderValue,
                    colors: widget.gradientColors,
                    strokeWidth: strokeWidth,
                  ),
                ),
                Positioned(
                  bottom: size * 0.26,
                  child: Text(
                    sliderValue.toInt().toString(),
                    style: textTheme.bodyLarge,
                  ),
                ),

                Positioned(
                  bottom: 10,
                  child: Hero(
                    tag: 'next_button',
                    child: AppPrimaryButton(
                      onTap: widget.onNextPressed,
                      height: size * 0.2,
                      minWidth: size * 0.2,
                      maxWidth: size * 0.3,
                      gradientColors: widget.gradientColors,
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GradientArcPainter extends CustomPainter {
  GradientArcPainter({
    required this.value,
    required this.colors,
    required this.strokeWidth,
  });

  final double value;
  final List<Color> colors;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final bgPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final gradient = SweepGradient(
      startAngle: pi,
      colors: colors,
    );

    final fgPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progress = value / 10;
    final sweepAngle = pi * progress;

    // Arc drawing
    canvas
      ..drawArc(rect, pi, pi, false, bgPaint)
      ..drawArc(rect, pi, sweepAngle, false, fgPaint);

    // Thumb (with shadow)
    final thumbAngle = pi + sweepAngle;
    final thumbRadius = strokeWidth * 0.6;
    final thumbX = center.dx + radius * cos(thumbAngle);
    final thumbY = center.dy + radius * sin(thumbAngle);

    final thumbCenter = Offset(thumbX, thumbY);
    final thumbPath = Path()
      ..addOval(Rect.fromCircle(center: thumbCenter, radius: thumbRadius));

    canvas
      ..drawShadow(thumbPath, Colors.black..withValues(alpha: 0.4), 4, true)
      ..drawCircle(thumbCenter, thumbRadius, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
