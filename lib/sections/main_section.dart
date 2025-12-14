import 'package:flutter/material.dart';
import '../core/constants/app_strings.dart';
import '../widgets/nav_bar.dart';
import '../widgets/footer.dart';
import 'home/home_view.dart';
import 'about/about_view.dart';
import 'projects/projects_view.dart';
import 'contact/contact_view.dart';

class MainSection extends StatefulWidget {
  const MainSection({super.key});

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();

  void scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void onNavTap(int index) {
    switch (index) {
      case 0:
        scrollToSection(homeKey);
        break;
      case 1:
        scrollToSection(aboutKey);
        break;
      case 2:
        scrollToSection(projectsKey);
        break;
      case 3:
        scrollToSection(contactKey);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  AppStrings.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(AppStrings.home),
              onTap: () {
                Navigator.pop(context);
                scrollToSection(homeKey);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(AppStrings.about),
              onTap: () {
                Navigator.pop(context);
                scrollToSection(aboutKey);
              },
            ),
            ListTile(
              leading: const Icon(Icons.code),
              title: const Text(AppStrings.projects),
              onTap: () {
                Navigator.pop(context);
                scrollToSection(projectsKey);
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text(AppStrings.contact),
              onTap: () {
                Navigator.pop(context);
                scrollToSection(contactKey);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NavBar(onNavItemTap: onNavTap),
            Container(key: homeKey, child: const HomeView()),
            Container(key: aboutKey, child: const AboutView()),
            Container(key: projectsKey, child: const LeetCodeView()),
            Container(key: contactKey, child: const ContactView()),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
