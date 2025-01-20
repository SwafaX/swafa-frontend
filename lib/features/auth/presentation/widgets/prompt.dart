import 'package:flutter/material.dart';

class Prompt extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const Prompt({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            text: title,
            style: const TextStyle(color: Colors.black),
            children: [
              TextSpan(
                text: subtitle,
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
