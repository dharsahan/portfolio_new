import 'package:flutter/material.dart';
import '../core/constants/app_strings.dart';

class NavBar extends StatelessWidget {
  final Function(int) onNavItemTap;

  const NavBar({super.key, required this.onNavItemTap});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return _DesktopNavBar(onNavItemTap: onNavItemTap);
        } else {
          return const _MobileNavBar();
        }
      },
    );
  }
}

class _DesktopNavBar extends StatelessWidget {
  final Function(int) onNavItemTap;

  const _DesktopNavBar({required this.onNavItemTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            AppStrings.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              _NavBarItem(title: AppStrings.home, onTap: () => onNavItemTap(0)),
              _NavBarItem(title: AppStrings.about, onTap: () => onNavItemTap(1)),
              _NavBarItem(title: AppStrings.projects, onTap: () => onNavItemTap(2)),
              _NavBarItem(title: AppStrings.contact, onTap: () => onNavItemTap(3)),
            ],
          )
        ],
      ),
    );
  }
}

class _MobileNavBar extends StatelessWidget {
  const _MobileNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            AppStrings.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
