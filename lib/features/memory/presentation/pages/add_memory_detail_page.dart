// Next Page Widget
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:innerverse/features/memory/domain/entities/emoji_option.dart';
import 'package:innerverse/shared/buttons/app_primary_button.dart';
import 'package:innerverse/shared/buttons/rounded_icon_button.dart';
import 'package:innerverse/shared/widgets/custome_text_field.dart';
import 'package:rive/rive.dart';

class AddMemoryDetailPage extends HookWidget {
  const AddMemoryDetailPage({
    required this.selectedData,
    super.key,
  });
  final EmojiOption selectedData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final textController = useTextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GradientIconButton(
                      icon: Icons.close,
                      onTap: () => Navigator.pop(context),
                      size: 48,
                      gradientColors: selectedData.gradient,
                    ),
                  ),
                  // SizedBox(
                  //   height: 200,
                  //   width: 200,
                  //   child: RiveAnimation.asset(
                  //     'assets/rive/innerverse3.riv',
                  //     artboard: selectedData.id,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CustomeTextField(
                          controller: textController,
                          hintText: 'Title...',
                          fontSize: 20,
                          validator: (p0) {
                            return null;
                          },
                          textStyle: textTheme.titleMedium,
                          animateHint: true,
                          hintColor: colorScheme.outlineVariant,
                          textColor: Colors.black,
                        ),
                        CustomeTextField(
                          controller: textController,
                          hintText: 'Add some notes...',
                          fontSize: 20,
                          validator: (p0) {
                            return null;
                          },
                          textStyle: textTheme.titleMedium,
                          animateHint: true,
                          hintColor: colorScheme.outlineVariant,
                          textColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: -10,
              right: -10,
              child: Hero(
                tag: 'next_button',
                child: AppPrimaryButton(
                  onTap: () {},
                  height: 110,
                  cornerSide: ButtonCornerSide.right,
                  gradientColors: selectedData.gradient,
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
  }
}
