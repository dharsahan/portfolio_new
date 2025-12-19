import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.grey[200],
      child: const Center(
        child: Text("© 2025 My Portfolio. All rights reserved."),
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
