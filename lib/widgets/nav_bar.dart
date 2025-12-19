import 'package:flutter/material.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_colors.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "DB",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                AppStrings.name,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _NavBarItem(title: AppStrings.home, onTap: () => onNavItemTap(0)),
              _NavBarItem(title: AppStrings.about, onTap: () => onNavItemTap(1)),
              _NavBarItem(title: AppStrings.projects, onTap: () => onNavItemTap(2)),
              _NavBarItem(title: AppStrings.contact, onTap: () => onNavItemTap(3), isButton: true),
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            AppStrings.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.textColor, size: 28),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool isButton;

  const _NavBarItem({
    required this.title,
    required this.onTap,
    this.isButton = false,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isButton) {
      return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: ElevatedButton(
          onPressed: widget.onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: _isHovering ? AppColors.primaryColor : AppColors.secondaryColor,
            ),
            child: Text(widget.title),
          ),
        ),
      ),
    );
  }
}
