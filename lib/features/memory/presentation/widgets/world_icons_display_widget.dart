import 'package:flutter/material.dart';
import 'package:innerverse/core/constants/emoji_options.dart';
import 'package:innerverse/features/world/data/models/world_icon_model.dart';

class WorldIconsDisplayWidget extends StatefulWidget {
  const WorldIconsDisplayWidget({
    required this.worldIcons,
    required this.selectedIndex,
    required this.emojiPageController,
    required this.bounceAnimation,
    required this.textTheme,
    super.key,
  });

  final List<WorldIconModel> worldIcons;
  final int selectedIndex;
  final PageController emojiPageController;
  final CurvedAnimation bounceAnimation;
  final TextTheme textTheme;

  @override
  State<WorldIconsDisplayWidget> createState() =>
      _WorldIconsDisplayWidgetState();
}

class _WorldIconsDisplayWidgetState extends State<WorldIconsDisplayWidget> {
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    widget.emojiPageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    widget.emojiPageController.removeListener(_onPageChanged);
    super.dispose();
  }

  void _onPageChanged() {
    final page = widget.emojiPageController.page?.round() ?? 0;
    if (page != currentPage) {
      setState(() {
        currentPage = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.worldIcons.isNotEmpty
        ? Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: widget.emojiPageController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.worldIcons.length,
                  itemBuilder: (context, index) {
                    final worldIcon = widget.worldIcons[index];
                    return ScaleTransition(
                      scale: index == widget.selectedIndex
                          ? widget.bounceAnimation
                          : const AlwaysStoppedAnimation(1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors:
                                    emojiOptions[widget.selectedIndex].gradient,
                              ),
                            ),
                            child: Icon(
                              worldIcon.icon,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${worldIcon.name} (${index + 1}/${widget.worldIcons.length})',
                            textAlign: TextAlign.center,
                            style: widget.textTheme.headlineLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (widget.worldIcons.length > 1)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.worldIcons.length,
                      (index) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == currentPage
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: emojiOptions[widget.selectedIndex].gradient,
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Select World Symbols',
                textAlign: TextAlign.center,
                style: widget.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          );
  }
}
