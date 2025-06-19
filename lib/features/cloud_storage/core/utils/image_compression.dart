import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class ImageCompressionConfig {
  const ImageCompressionConfig({
    this.quality = 85,
    this.maxWidth = 1920,
    this.maxHeight = 1080,
    this.format = CompressFormat.jpeg,
    this.keepExif = false,
  });

  final int quality;
  final int maxWidth;
  final int maxHeight;
  final CompressFormat format;
  final bool keepExif;

  static const ImageCompressionConfig highQuality = ImageCompressionConfig(
    quality: 90,
    maxWidth: 2560,
    maxHeight: 1440,
  );

  static const ImageCompressionConfig mediumQuality = ImageCompressionConfig(
    quality: 85,
    maxWidth: 1920,
    maxHeight: 1080,
  );

  static const ImageCompressionConfig lowQuality = ImageCompressionConfig(
    quality: 70,
    maxWidth: 1280,
    maxHeight: 720,
  );

  static const ImageCompressionConfig thumbnail = ImageCompressionConfig(
    quality: 60,
    maxWidth: 400,
    maxHeight: 400,
  );
}

class ImageCompressionService {
  static Future<File> compressImage(
    File imageFile, {
    ImageCompressionConfig config = ImageCompressionConfig.mediumQuality,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final compressedFile = File(
        '${tempDir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.${_getFileExtension(config.format)}',
      );

      final result = await FlutterImageCompress.compressAndGetFile(
        imageFile.path,
        compressedFile.path,
        quality: config.quality,
        minWidth: config.maxWidth,
        minHeight: config.maxHeight,
        format: config.format,
        keepExif: config.keepExif,
      );

      if (result == null) {
        throw Exception('Image compression failed');
      }
      return File(result.path);
    } catch (e) {
      throw Exception('Image compression error: $e');
    }
  }

  static Future<Uint8List> compressImageToBytes(
    File imageFile, {
    ImageCompressionConfig config = ImageCompressionConfig.mediumQuality,
  }) async {
    try {
      final result = await FlutterImageCompress.compressWithFile(
        imageFile.path,
        quality: config.quality,
        minWidth: config.maxWidth,
        minHeight: config.maxHeight,
        format: config.format,
        keepExif: config.keepExif,
      );

      if (result == null) {
        throw Exception('Image compression failed');
      }

      return result;
    } catch (e) {
      throw Exception('Image compression error: $e');
    }
  }

  static Future<File> generateThumbnail(
    File imageFile, {
    int size = 200,
    int quality = 60,
  }) async {
    return compressImage(
      imageFile,
      config: ImageCompressionConfig(
        quality: quality,
        maxWidth: size,
        maxHeight: size,
      ),
    );
  }

  static Future<List<File>> compressImages(
    List<File> imageFiles, {
    ImageCompressionConfig config = ImageCompressionConfig.mediumQuality,
  }) async {
    final compressedFiles = <File>[];

    for (final imageFile in imageFiles) {
      try {
        final compressedFile = await compressImage(imageFile, config: config);
        compressedFiles.add(compressedFile);
      } catch (e) {
        // If compression fails, use original file
        compressedFiles.add(imageFile);
      }
    }

    return compressedFiles;
  }

  static String _getFileExtension(CompressFormat format) {
    switch (format) {
      case CompressFormat.jpeg:
        return 'jpg';
      case CompressFormat.png:
        return 'png';
      case CompressFormat.webp:
        return 'webp';
      case CompressFormat.heic:
        return 'heic';
    }
  }

  static Future<int> getFileSize(File file) async {
    return file.length();
  }

  static Future<double> getCompressionRatio(
      File original, File compressed) async {
    final originalSize = await getFileSize(original);
    final compressedSize = await getFileSize(compressed);
    return originalSize / compressedSize;
  }
}
