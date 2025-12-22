import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32),bottomRight: Radius.circular(32)),
          child: Image.network(
            imageUrl,
            height: 340,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const SizedBox(
                height: 340,
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),

        const SizedBox(height: 32),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
