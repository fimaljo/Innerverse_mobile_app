import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProgressiveImage extends StatefulWidget {
  const ProgressiveImage({
    super.key,
    required this.imageUrl,
    this.placeholder,
    this.errorWidget,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.loadingColor,
    this.errorColor,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.fadeOutDuration = const Duration(milliseconds: 300),
    this.placeholderFadeInDuration = const Duration(milliseconds: 300),
    this.progressIndicatorBuilder,
    this.memCacheWidth,
    this.memCacheHeight,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
  });

  final String imageUrl;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Color? loadingColor;
  final Color? errorColor;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  final Duration placeholderFadeInDuration;
  final Widget Function(BuildContext, String, double?)?
      progressIndicatorBuilder;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;

  @override
  State<ProgressiveImage> createState() => _ProgressiveImageState();
}

class _ProgressiveImageState extends State<ProgressiveImage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _placeholderController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _placeholderAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: widget.fadeInDuration,
      vsync: this,
    );
    _placeholderController = AnimationController(
      duration: widget.placeholderFadeInDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    _placeholderAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _placeholderController,
      curve: Curves.easeIn,
    ));

    _placeholderController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _placeholderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: Stack(
          children: [
            // Placeholder
            if (widget.placeholder != null)
              FadeTransition(
                opacity: _placeholderAnimation,
                child: widget.placeholder!,
              )
            else
              Container(
                color: widget.loadingColor ?? Colors.grey[300],
                child: Center(
                  child: CircularProgressIndicator(
                    color: widget.loadingColor ?? Colors.grey[600],
                  ),
                ),
              ),

            // Main image
            FadeTransition(
              opacity: _fadeAnimation,
              child: _buildImage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (widget.imageUrl.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: widget.imageUrl,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        placeholder: (context, url) => const SizedBox.shrink(),
        errorWidget: (context, url, error) => _buildErrorWidget(),
        progressIndicatorBuilder: widget.progressIndicatorBuilder != null
            ? (context, url, progress) => widget.progressIndicatorBuilder!(
                context, url, progress.progress ?? 0.0)
            : null,
        memCacheWidth: widget.memCacheWidth,
        memCacheHeight: widget.memCacheHeight,
        maxWidthDiskCache: widget.maxWidthDiskCache,
        maxHeightDiskCache: widget.maxHeightDiskCache,
        fadeInDuration: Duration.zero,
        fadeOutDuration: Duration.zero,
        imageBuilder: (context, imageProvider) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _fadeController.forward();
            _placeholderController.reverse();
          });
          return Image(
            image: imageProvider,
            fit: widget.fit,
            width: widget.width,
            height: widget.height,
          );
        },
      );
    } else {
      // Local file
      return Image.file(
        File(widget.imageUrl),
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            _fadeController.forward();
            _placeholderController.reverse();
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _fadeController.forward();
              _placeholderController.reverse();
            });
          }
          return child;
        },
      );
    }
  }

  Widget _buildErrorWidget() {
    if (widget.errorWidget != null) {
      return widget.errorWidget!;
    }

    return Container(
      color: widget.errorColor ?? Colors.grey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: widget.errorColor ?? Colors.grey[600],
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'Failed to load image',
              style: TextStyle(
                color: widget.errorColor ?? Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressiveImageWithThumbnail extends StatelessWidget {
  const ProgressiveImageWithThumbnail({
    super.key,
    required this.imageUrl,
    this.thumbnailUrl,
    this.placeholder,
    this.errorWidget,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.loadingColor,
    this.errorColor,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.thumbnailFadeOutDuration = const Duration(milliseconds: 200),
  });

  final String imageUrl;
  final String? thumbnailUrl;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Color? loadingColor;
  final Color? errorColor;
  final Duration fadeInDuration;
  final Duration thumbnailFadeOutDuration;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Stack(
          children: [
            // Placeholder
            if (placeholder != null) placeholder!,

            // Thumbnail (if available)
            if (thumbnailUrl != null)
              ProgressiveImage(
                imageUrl: thumbnailUrl!,
                width: width,
                height: height,
                fit: fit,
                fadeInDuration: fadeInDuration,
              ),

            // Main image
            ProgressiveImage(
              imageUrl: imageUrl,
              width: width,
              height: height,
              fit: fit,
              placeholder: const SizedBox.shrink(),
              errorWidget: errorWidget,
              loadingColor: loadingColor,
              errorColor: errorColor,
              fadeInDuration: fadeInDuration,
            ),
          ],
        ),
      ),
    );
  }
}
