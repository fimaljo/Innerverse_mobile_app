import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:innerverse/core/navigation/route_constants.dart';
import 'package:innerverse/shared/buttons/app_primary_button.dart';
import 'package:innerverse/shared/buttons/rounded_icon_button.dart'
    show GradientIconButton;
import 'package:innerverse/shared/widgets/custome_text_field.dart';
import 'package:rive/rive.dart';

class CreateMemoryPage extends HookWidget {
  const CreateMemoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    // State management with hooks
    final pageController = usePageController(viewportFraction: 0.8);
    final selectedIndex = useState(0);

    // Animation controller hook
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    // Bounce animation
    final bounceAnimation = useMemoized(
      () => CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
      ),
      [animationController],
    );

    final emojiData = <Map<String, String>>[
      {'emoji': 'positive', 'label': 'Posative'},
      {'emoji': 'neutral', 'label': 'Nuteral'},
      {'emoji': 'sad', 'label': 'Sad'},
      {'emoji': 'angry', 'label': 'Angry'},
      {'emoji': 'fearful', 'label': 'Fearful'},
    ];

    // Helper function to handle emoji selection
    void onEmojiSelected(int index, {bool fromBottom = false}) {
      if (fromBottom) {
        pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutBack,
        );
      }

      selectedIndex.value = index;
      animationController.forward(from: 0);
      HapticFeedback.lightImpact();
    }

    // Dispose controllers when widget is unmounted
    useEffect(() {
      return () {
        pageController.dispose();
        animationController.dispose();
      };
    }, []);

    final emojiList = emojiData.map((e) => e['emoji']!).toList();
    final emojiLabels = emojiData.map((e) => e['label']!).toList();

    return Scaffold(
      body: Column(
        children: [
          // Top container
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE4E1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  // Back button in top-left
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GradientIconButton(
                      icon: Icons.close,
                      onTap: () => context.pushNamed(RouteConstants.homeName),
                      size: 48,
                      gradientColors: [
                        Colors.orange.withOpacity(0.1),
                        Colors.deepOrange.withOpacity(0.1),
                      ],
                      iconColor: Colors.red,
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 0,
                    right: 0,
                    child: Text(
                      emojiLabels[selectedIndex.value],
                      textAlign: TextAlign.center,
                      style: textTheme.headlineLarge,
                    ),
                  ),
                  // Center content: Label and animation
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32), // spacing from top

                      const SizedBox(height: 20),
                      Expanded(
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: emojiList.length,
                          onPageChanged: (index) => onEmojiSelected(index),
                          itemBuilder: (context, index) {
                            final isSelected = index == selectedIndex.value;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              child: ScaleTransition(
                                scale: isSelected
                                    ? bounceAnimation
                                    : const AlwaysStoppedAnimation(1.0),
                                child: RiveAnimation.asset(
                                  'assets/rive/innerverse.riv',
                                  artboard: emojiList[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom section
          Expanded(
            child: Container(
              // padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  const SizedBox(height: 16),

                  // Bottom emoji selector
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(emojiList.length, (index) {
                        final isActive = index == selectedIndex.value;
                        return GestureDetector(
                          onTap: () => onEmojiSelected(index, fromBottom: true),
                          child: AnimatedContainer(
                            height: 50,
                            width: 50,
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Colors.white
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: isActive ? 2 : 1,
                              ),
                            ),
                            child: RiveAnimation.asset(
                              'assets/rive/innerverse.riv',
                              artboard:
                                  emojiList[index], // Replace with your actual artboard name
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      'What kind of\nmemory is this?',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colorScheme.inversePrimary,
                          ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: AppPrimaryButton(
                      onTap: () {
                        // Navigate to next page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NextMemoryPage(
                              selectedEmoji:
                                  emojiData[selectedIndex.value]['emoji']!,
                              selectedLabel:
                                  emojiData[selectedIndex.value]['label']!,
                            ),
                          ),
                        );
                      },
                      isLoading: false, // Set true to show spinner
                      height: 90,
                      minWidth: 80,
                      cornerSide: ButtonCornerSide.right,
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Next Button
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Next Page Widget
class NextMemoryPage extends HookWidget {
  const NextMemoryPage({
    super.key,
    required this.selectedEmoji,
    required this.selectedLabel,
  });
  final String selectedEmoji;
  final String selectedLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final textController = useTextEditingController();
    final fadeAnimation = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );

    useEffect(() {
      fadeAnimation.forward();
      return null;
    }, []);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top container with selected emoji
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              color: Color(0xFFE6F3FF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Stack(
              children: [
                // Back button
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: GradientIconButton(
                      icon: Icons.close,
                      onTap: () => Navigator.pop(context),
                      size: 60,
                      gradientColors: [
                        Colors.orange.withValues(alpha: 0.1),
                        Colors.deepOrange.withValues(alpha: 0.1),
                      ],
                      iconColor: Colors.red,
                    ),
                  ),
                ),

                // Selected emoji display
                Center(
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          selectedEmoji,
                          style: const TextStyle(fontSize: 100),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Feeling $selectedLabel',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Tell us more about your memory',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom section with text input
          Expanded(
            child: CustomeTextField(
              controller: textController,
              hintText: 'Enter your name',
              fontSize: 20,
              validator: (p0) {
                return null;
              },
              textStyle: textTheme.titleMedium?.copyWith(color: Colors.black),
              animateHint: true,
              hintColor: Colors.red,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
