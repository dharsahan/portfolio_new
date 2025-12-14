import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: size.width > 800 ? size.width * 0.1 : 20,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            AppStrings.aboutMe,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 4,
            width: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _AboutImage()),
                    SizedBox(width: 60),
                    Expanded(child: _AboutContent()),
                  ],
                );
              } else {
                return const Column(
                  children: [
                    _AboutImage(),
                    SizedBox(height: 40),
                    _AboutContent(),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _AboutImage extends StatelessWidget {
  const _AboutImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          'https://picsum.photos/400/400',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.person, size: 100, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Who am I?",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.aboutDesc,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.8,
                color: AppColors.secondaryColor,
                fontSize: 16,
              ),
        ),
        const SizedBox(height: 30),
        Text(
          AppStrings.skills,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: AppStrings.skillList.map((skill) {
            return Chip(
              label: Text(skill),
              backgroundColor: AppColors.backgroundColor,
              side: const BorderSide(color: AppColors.primaryColor),
              labelStyle: const TextStyle(color: AppColors.primaryColor),
            );
          }).toList(),
        ),
      ],
    );
  }
}
