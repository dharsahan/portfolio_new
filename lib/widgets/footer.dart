import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      color: Colors.white,
      child: Column(
        children: [
          const Divider(color: AppColors.backgroundColor),
          const SizedBox(height: 30),
          const Text(
            "Designed and Built by Dharshan Balaji",
            style: TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "© 2025 My Portfolio. All rights reserved.",
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _FooterIcon(Icons.code),
              const SizedBox(width: 15),
              _FooterIcon(Icons.coffee),
              const SizedBox(width: 15),
              _FooterIcon(Icons.favorite),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterIcon extends StatelessWidget {
  final IconData icon;

  const _FooterIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColors.secondaryColor, size: 20),
    );
  }
}
