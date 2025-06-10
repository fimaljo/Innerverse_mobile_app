import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CreateMemoryPage extends HookWidget {
  const CreateMemoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // State management with hooks
    final pageController = usePageController(viewportFraction: 0.5);
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
      {'emoji': '😊', 'label': 'Happy'},
      {'emoji': '😢', 'label': 'Sad'},
      {'emoji': '😡', 'label': 'Angry'},
      {'emoji': '😍', 'label': 'Love'},
      {'emoji': '😱', 'label': 'Surprised'},
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
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Top container
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE4E1),
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
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),

                // Emoji Swiper and Label
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 180,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: emojiList.length,
                          onPageChanged: onEmojiSelected,
                          itemBuilder: (context, index) {
                            final isSelected = index == selectedIndex.value;
                            return AnimatedBuilder(
                              animation: bounceAnimation,
                              builder: (context, child) {
                                final scale = isSelected
                                    ? 1.5 + (bounceAnimation.value * 0.2)
                                    : 1.0;
                                final opacity = isSelected ? 1.0 : 0.3;

                                return Opacity(
                                  opacity: opacity,
                                  child: Transform.scale(
                                    scale: scale,
                                    child: child,
                                  ),
                                );
                              },
                              child: Center(
                                child: Text(
                                  emojiList[index],
                                  style: const TextStyle(fontSize: 90),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        emojiLabels[selectedIndex.value],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom section
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black,
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  // Bottom emoji selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(emojiList.length, (index) {
                      final isActive = index == selectedIndex.value;
                      return GestureDetector(
                        onTap: () => onEmojiSelected(index, fromBottom: true),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isActive ? Colors.white : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: isActive ? 2 : 1,
                            ),
                          ),
                          child: Text(
                            emojiList[index],
                            style: TextStyle(
                              fontSize: isActive ? 32 : 26,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 40),

                  // Next Button
                  Container(
                    width: double.infinity,
                    height: 56,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 8,
                        shadowColor: Colors.white.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

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
    final textController = useTextEditingController();
    final fadeAnimation = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );

    useEffect(() {
      fadeAnimation.forward();
      return null;
    }, []);

    return Scaffold(
      backgroundColor: Colors.black,
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
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
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
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  const Text(
                    'What happened?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Text input field
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey[700]!,
                        ),
                      ),
                      child: TextField(
                        controller: textController,
                        maxLines: null,
                        expands: true,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.5,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Describe your memory...',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Save Memory Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle save memory logic
                        if (textController.text.isNotEmpty) {
                          // Show success message or navigate
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Memory saved! 😊'),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );

                          // Navigate back to home or previous screen
                          Navigator.popUntil(context, (route) => route.isFirst);
                        } else {
                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please write something about your memory',
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 8,
                        shadowColor: Colors.white.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: const Text(
                        'Save Memory',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

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
