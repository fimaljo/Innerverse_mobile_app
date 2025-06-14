import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart'
    as FlutterIconPicker;
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:innerverse/core/constants/emoji_options.dart';
import 'package:innerverse/core/navigation/route_constants.dart';
import 'package:innerverse/features/memory/domain/entities/emoji_option.dart';
import 'package:innerverse/shared/buttons/app_primary_button.dart';
import 'package:innerverse/shared/buttons/rounded_icon_button.dart'
    show GradientIconButton;
import 'package:innerverse/shared/widgets/custome_text_field.dart';
import 'package:rive/rive.dart' as rive;

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
  double speed = 5;
  List<WorldIcon> worldIcons = [
    WorldIcon(name: 'Family', icon: Icons.family_restroom),
    WorldIcon(name: 'Relation Ship', icon: Icons.heat_pump_rounded),
  ];

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
  }

  @override
  void dispose() {
    emojiPageController.dispose();
    pageController.dispose();
    bottomPageController.dispose();
    animationController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

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
                    ? MediaQuery.of(context).size.height * 0.6
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
                                onTap: () => context.pushNamed(
                                  RouteConstants.homeName,
                                ),
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
                                    child: rive.RiveAnimation.asset(
                                      'assets/rive/innerverse3.riv',
                                      artboard: emojiOptions[index].id,
                                      fit: BoxFit.cover,
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
                                onPageChanged: onEmojiSelected,
                                itemBuilder: (context, index) {
                                  final isSelected = index == selectedIndex;
                                  return ScaleTransition(
                                    scale: isSelected
                                        ? bounceAnimation
                                        : const AlwaysStoppedAnimation(1),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          worldIcons[index].name,
                                          textAlign: TextAlign.center,
                                          style: textTheme.headlineLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Icon(
                                          worldIcons[index].icon,
                                          size: 50,
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
                ),
                _TextFieldStep(
                  onBack: () {
                    FocusScope.of(context).unfocus();
                    bottomPageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  selectedData: selectedEmoji,
                  onSubmit: () {
                    bottomPageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
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
                  selectedData: selectedEmoji,
                  onSubmit: () {
                    bottomPageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WorldIcon {
  final String name;
  final IconData icon;

  WorldIcon({
    required this.name,
    required this.icon,
  });
}

class _WorldTypeStep extends StatefulWidget {
  const _WorldTypeStep({
    required this.onBack,
    required this.onSubmit,
    required this.selectedData,
    required this.onWorldIconsChanged,
  });

  final VoidCallback onBack;
  final VoidCallback onSubmit;
  final EmojiOption selectedData;
  final ValueChanged<List<WorldIcon>> onWorldIconsChanged;

  @override
  State<_WorldTypeStep> createState() => _WorldTypeStepState();
}

class _WorldTypeStepState extends State<_WorldTypeStep> {
  final List<WorldIcon> worldIcons = [
    WorldIcon(name: 'Family', icon: Icons.family_restroom),
    WorldIcon(name: 'Relation Ship', icon: Icons.heat_pump_rounded),
  ];

  bool isAdding = false;
  IconData? pickedIcon;
  final TextEditingController nameController = TextEditingController();

  void _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(
      context,
      iconPackModes: [IconPack.material],
    );
    if (icon != null) {
      setState(() {
        pickedIcon = icon;
      });
    }
  }

  void _addWorldSymbol() {
    final name = nameController.text.trim();
    if (name.isNotEmpty && pickedIcon != null) {
      setState(() {
        worldIcons.add(WorldIcon(name: name, icon: pickedIcon!));
        nameController.clear();
        pickedIcon = null;
        isAdding = false;
      });
      widget.onWorldIconsChanged(worldIcons);
    }
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
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    widget.onSubmit();
                  },
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
                    ...worldIcons.map((item) {
                      return SizedBox(
                        width:
                            MediaQuery.of(context).size.width / 4 -
                            24, // 4 per row with spacing
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[200],
                              ),
                              child: Icon(
                                item.icon,
                                size: 28,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item.name,
                              style: const TextStyle(fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
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
  });

  final VoidCallback onBack;
  final VoidCallback onSubmit;
  final EmojiOption selectedData;

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
      setState(() => selectedDate = date);
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

      if (selectedDate != null &&
          selectedDate!.isAtSameMomentAs(DateTime.now()) &&
          !isBeforeNow) {
        // Show warning or ignore
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Future time not allowed')),
        );
        return;
      }

      setState(() => selectedTime = time);
    }
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
              widget.onSubmit();
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
                          selectedDate != null
                              ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
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
                          selectedTime != null
                              ? selectedTime!.format(context)
                              : 'Pick a time',
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
  });

  final double speed;
  final int selectedIndex;
  final EmojiOption selectedEmoji;
  final void Function(double) onSpeedChanged;
  final VoidCallback onNextPressed;
  final void Function(int index, {bool fromBottom}) onEmojiSelected;

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
                    onTap: () => onEmojiSelected(index, fromBottom: true),
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
            onChanged: onSpeedChanged,
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
    final colorScheme = theme.colorScheme;
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
      ..drawShadow(thumbPath, Colors.black.withOpacity(0.4), 4, true)
      ..drawCircle(thumbCenter, thumbRadius, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
