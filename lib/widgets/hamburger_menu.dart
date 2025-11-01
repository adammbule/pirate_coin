import 'package:flutter/material.dart';
import 'package:Piratecoin/widgets/theme_widget.dart'; // for colors and gradients

class HamburgerMenu extends StatefulWidget {
  const HamburgerMenu({super.key});

  @override
  State<HamburgerMenu> createState() => _HamburgerMenuState();
}

class _HamburgerMenuState extends State<HamburgerMenu> {
  // Keep track of the hovered item
  String? hoveredItem;

  // Navigation items
  final List<_NavItem> _items = [
    const _NavItem(icon: Icons.home, label: 'Home', route: '/home'),
    const _NavItem(icon: Icons.movie, label: 'Movies', route: '/movies'),
    const _NavItem(icon: Icons.tv, label: 'Shows', route: '/shows'),
    const _NavItem(icon: Icons.video_file, label: 'Others', route: '/others'),
    const _NavItem(icon: Icons.shop, label: 'Marketplace', route: '/marketplace'),
    const _NavItem(icon: Icons.currency_bitcoin, label: 'Mint', route: '/mint'),
    const _NavItem(
        icon: Icons.account_balance_wallet, label: 'Wallet', route: '/wallet'),
    const _NavItem(icon: Icons.logout, label: 'Logout', route: '/logout'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      color: kCardColor,
      child: Column(
        children: [
          // Header Logo
          Container(
            height: 70,
            width: double.infinity,
            decoration: const BoxDecoration(gradient: kPirateGradient),
            child: const Center(
              child: Icon(Icons.shop, color: Colors.black, size: 36),
            ),
          ),

          const SizedBox(height: 20),

          // Navigation icons
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                final bool isHovered = hoveredItem == item.label;

                return MouseRegion(
                  onEnter: (_) => setState(() => hoveredItem = item.label),
                  onExit: (_) => setState(() => hoveredItem = null),
                  child: Tooltip(
                    message: item.label,
                    waitDuration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: Colors.cyanAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(color: Colors.white),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, item.route);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                          color: isHovered
                              ? Colors.cyanAccent.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 50,
                        width: 50,
                        child: Icon(
                          item.icon,
                          color: isHovered ? Colors.cyanAccent : Colors.white70,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String route;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}
