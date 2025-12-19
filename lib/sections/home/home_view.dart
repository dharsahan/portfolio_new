import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      constraints: BoxConstraints(minHeight: size.height * 0.9),
      width: double.infinity,
      color: AppColors.backgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: size.width > 800 ? size.width * 0.1 : 24,
        vertical: 64,
      ),
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 900) {
              return const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: _HomeContent()),
                  SizedBox(width: 80),
                  _HomeImage(),
                ],
              );
            } else {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _HomeImage(),
                  SizedBox(height: 60),
                  _HomeContent(textAlign: TextAlign.center),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  final TextAlign textAlign;

  const _HomeContent({this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: textAlign == TextAlign.center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.hello,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.w900,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          AppStrings.role,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 32),
        Container(
          padding: textAlign == TextAlign.start
              ? const EdgeInsets.only(left: 20)
              : const EdgeInsets.symmetric(horizontal: 20),
          decoration: textAlign == TextAlign.start
              ? const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: AppColors.secondaryColor, width: 3),
                  ),
                )
              : null,
          child: Text(
            AppStrings.intro,
            textAlign: textAlign,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.secondaryColor,
                  height: 1.8,
                  fontSize: 18,
                ),
          ),
        ),
        const SizedBox(height: 48),
        Wrap(
          alignment: textAlign == TextAlign.center ? WrapAlignment.center : WrapAlignment.start,
          spacing: 20,
          runSpacing: 20,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 4,
                shadowColor: AppColors.primaryColor.withOpacity(0.4),
              ),
              child: const Text(
                AppStrings.hireMe,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                side: const BorderSide(color: AppColors.textColor, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    AppStrings.downloadCv,
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.download, color: AppColors.textColor, size: 20),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HomeImage extends StatelessWidget {
  const _HomeImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: 350,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.2),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
        border: Border.all(color: Colors.white, width: 8),
      ),
      child: ClipOval(
        child: Image.network(
          'https://media.licdn.com/dms/image/v2/D4E03AQHzs-Pu_yB94A/profile-displayphoto-scale_200_200/B4EZn7W0t0HcAY-/0/1760858707065?e=1767225600&v=beta&t=j7KqYVudt06M--GRQ9RuHjrDlzZ-c1xDF4qNTmMG-28',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
            Container(color: Colors.grey[200], child: const Icon(Icons.person, size: 100, color: Colors.grey)),
        ),
      ),
    );
  }
}
