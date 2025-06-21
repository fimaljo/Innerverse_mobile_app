import 'package:flutter/material.dart';

class EntryTextViewerPage extends StatelessWidget {
  const EntryTextViewerPage({
    super.key,
    this.title,
    this.description,
  });
  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null && title!.isNotEmpty) ...[
              Text(
                title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (description != null && description!.isNotEmpty)
              Text(
                description!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
