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
        horizontal: size.width > 800 ? size.width * 0.1 : 20,
        vertical: 50,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _HomeContent()),
                SizedBox(width: 40),
                Expanded(child: _HomeImage()),
              ],
            );
          } else {
            return const Column(
              children: [
                _HomeImage(),
                SizedBox(height: 40),
                _HomeContent(),
              ],
            );
          }
        },
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.hello,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.5,
              ),
        ),
        const SizedBox(height: 20),
        Text(
          AppStrings.role,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.only(left: 20),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: AppColors.secondaryColor, width: 3),
            ),
          ),
          child: Text(
            AppStrings.intro,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.secondaryColor,
                  height: 1.8,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ),
        const SizedBox(height: 50),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textColor,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 10,
              ),
              child: const Text(
                AppStrings.hireMe,
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 20),
            TextButton(
              onPressed: () {},
              child: Row(
                children: const [
                  Text(
                    AppStrings.downloadCv,
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward, color: AppColors.textColor),
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
      height: 400,
      width: 400,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: AppColors.primaryColor, width: 4),
        image: const DecorationImage(
          image: NetworkImage(
            'https://media.licdn.com/dms/image/v2/D4E03AQHzs-Pu_yB94A/profile-displayphoto-scale_200_200/B4EZn7W0t0HcAY-/0/1760858707065?e=1767225600&v=beta&t=j7KqYVudt06M--GRQ9RuHjrDlzZ-c1xDF4qNTmMG-28',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
