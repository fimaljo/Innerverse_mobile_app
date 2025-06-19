import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:innerverse/features/memory/data/models/memory_model.dart';
import 'package:innerverse/features/memory/domain/entities/emoji_option.dart';
import 'package:innerverse/features/memory/domain/entities/memory_creation_data.dart';
import 'package:innerverse/features/memory/presentation/blocs/memory_bloc.dart';
import 'package:innerverse/features/memory/presentation/blocs/memory_event.dart';
import 'package:innerverse/features/memory/presentation/blocs/memory_state.dart';
import 'package:innerverse/shared/buttons/app_primary_button.dart';
import 'package:innerverse/shared/widgets/custome_text_field.dart';
import 'package:uuid/uuid.dart';

class TextFieldStepWidget extends StatefulWidget {
  const TextFieldStepWidget({
    super.key,
    required this.onBack,
    required this.onSubmit,
    required this.selectedData,
    required this.memoryData,
    required this.bottomPageController,
    required this.onMemoryDataUpdated,
  });

  final VoidCallback onBack;
  final VoidCallback onSubmit;
  final EmojiOption selectedData;
  final MemoryCreationData memoryData;
  final PageController bottomPageController;
  final VoidCallback onMemoryDataUpdated;

  @override
  State<TextFieldStepWidget> createState() => _TextFieldStepWidgetState();
}

class _TextFieldStepWidgetState extends State<TextFieldStepWidget> {
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  bool isKeyboardVisible = false;
  late final StreamSubscription<bool> _keyboardSubscription;
  Timer? _debounceTimer;
  static const _debounceDuration = Duration(milliseconds: 500);
  final ImagePicker _imagePicker = ImagePicker();
  List<String> selectedImages = [];

  @override
  void initState() {
    super.initState();
    _initializeKeyboardListener();
    _initializeControllers();
    _loadDraft();
  }

  void _initializeKeyboardListener() {
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

  void _initializeControllers() {
    titleController.text = widget.memoryData.title ?? '';
    noteController.text = widget.memoryData.description ?? '';
    selectedImages = widget.memoryData.images ?? [];
  }

  Future<void> _loadDraft() async {
    final draftBox = Hive.box<MemoryModel>('draft_memories');
    final draft = draftBox.get('current_draft');
    if (draft != null) {
      setState(() {
        titleController.text = draft.title ?? '';
        noteController.text = draft.description ?? '';
        widget.memoryData.title = draft.title;
        widget.memoryData.description = draft.description;
        selectedImages = draft.images ?? [];
        widget.memoryData.images = draft.images;
        widget.memoryData.worldIcons = draft.worldIcons;
      });
    }
  }

  Future<void> _saveDraft() async {
    final draftBox = Hive.box<MemoryModel>('draft_memories');
    final memory = widget.memoryData.toMemory();
    final model = MemoryModel(
      id: memory.id,
      emojiLabel: memory.emojiLabel,
      riveAsset: memory.riveAsset,
      emotionSliderValue: memory.emotionSliderValue,
      dateTime: memory.dateTime,
      time: memory.time,
      worldIcons: widget.memoryData.worldIcons,
      title: memory.title,
      description: memory.description,
      images: memory.images,
    );
    await draftBox.put('current_draft', model);
  }

  void _debouncedSave(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounceDuration, () {
      _saveDraft();
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
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
      lastDate: today,
      helpText: 'Select Memory Date',
      cancelText: 'Cancel',
      confirmText: 'Select',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: widget.selectedData.gradient.first,
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
      widget.onMemoryDataUpdated();
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
      final isBeforeNow = time.hour < nowTime.hour ||
          (time.hour == nowTime.hour && time.minute <= nowTime.minute);

      if (widget.memoryData.dateTime != null &&
          widget.memoryData.dateTime!.isAtSameMomentAs(DateTime.now()) &&
          !isBeforeNow) {
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
      widget.onMemoryDataUpdated();
    }
  }

  Future<void> pickImages() async {
    final List<XFile>? pickedFiles = await _imagePicker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      final List<String> persistentPaths =
          await _copyImagesToPersistentStorage(pickedFiles);
      setState(() {
        selectedImages.addAll(persistentPaths);
        widget.memoryData.images = selectedImages;
      });
      widget.onMemoryDataUpdated();
    }
  }

  Future<List<String>> _copyImagesToPersistentStorage(List<XFile> files) async {
    final List<String> persistentPaths = [];
    final appDir = await getApplicationDocumentsDirectory();
    final imagesDir = Directory('${appDir.path}/memory_images');

    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }

    for (final file in files) {
      final fileName = '${const Uuid().v4()}.jpg';
      final persistentPath = '${imagesDir.path}/$fileName';
      await file.saveTo(persistentPath);
      persistentPaths.add(persistentPath);
    }

    return persistentPaths;
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      final imagePath = selectedImages[index];
      final file = File(imagePath);
      if (file.existsSync()) {
        file.deleteSync();
      }

      setState(() {
        selectedImages.removeAt(index);
        widget.memoryData.images = selectedImages;
      });
      widget.onMemoryDataUpdated();
    }
  }

  void _saveMemory() {
    widget.memoryData.title = titleController.text.trim();
    widget.memoryData.description = noteController.text.trim();
    widget.memoryData.images = selectedImages;

    widget.memoryData.toMemory();
    Hive.box<MemoryModel>('draft_memories').delete('current_draft');
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
              _buildDateTimeRow(colorScheme),
              const SizedBox(height: 16),
              _buildImagePicker(textTheme, colorScheme),
              const SizedBox(height: 16),
              _buildTitleField(textTheme, colorScheme),
              _buildNoteField(textTheme, colorScheme),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeRow(ColorScheme colorScheme) {
    return Row(
      children: [
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
                (widget.memoryData.time ?? TimeOfDay.now()).format(context),
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImagePicker(TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Images', style: textTheme.titleMedium),
        const SizedBox(height: 8),
        SizedBox(
          height: 90,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: selectedImages.length + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              if (index == selectedImages.length) {
                return GestureDetector(
                  onTap: pickImages,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colorScheme.primary),
                    ),
                    child: const Icon(Icons.add_a_photo_rounded, size: 32),
                  ),
                );
              }
              final imagePath = selectedImages[index];
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(imagePath),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 2,
                    right: 2,
                    child: GestureDetector(
                      onTap: () => removeImage(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close,
                            color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTitleField(TextTheme textTheme, ColorScheme colorScheme) {
    return CustomeTextField(
      controller: titleController,
      hintText: 'Title...',
      validator: (_) => null,
      textStyle: textTheme.titleMedium,
      animateHint: true,
      hintColor: colorScheme.outlineVariant,
      textColor: Colors.black,
      onChanged: (value) {
        widget.memoryData.title = value;
        _debouncedSave(value);
      },
    );
  }

  Widget _buildNoteField(TextTheme textTheme, ColorScheme colorScheme) {
    return CustomeTextField(
      controller: noteController,
      hintText: 'Add some notes...',
      validator: (_) => null,
      textStyle: textTheme.titleMedium,
      animateHint: true,
      hintColor: colorScheme.outlineVariant,
      textColor: Colors.black,
      onChanged: (value) {
        widget.memoryData.description = value;
        _debouncedSave(value);
      },
    );
  }
}
