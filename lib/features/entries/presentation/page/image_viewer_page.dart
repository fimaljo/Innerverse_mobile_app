import 'package:flutter/material.dart';
import 'dart:io';

class EntryImageViewerPage extends StatelessWidget {
  const EntryImageViewerPage({
    super.key,
    required this.imagePath,
  });
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Center(
        child: InteractiveViewer(
          child: Image.file(
            File(imagePath),
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[900],
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image,
                        color: Colors.white,
                        size: 64,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Image not found',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
