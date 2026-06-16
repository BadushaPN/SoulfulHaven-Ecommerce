import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../view/home_view.dart';
import '../view/divine_plushies_view.dart';
import '../view/summer_edit_view.dart';
import '../view/big_deals_view.dart';

class SharedNavbar extends StatelessWidget {
  final bool isScrolled;

  const SharedNavbar({super.key, this.isScrolled = false});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 900;

    if (isMobile) {
      return Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: isScrolled
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Hamburger menu button
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.black87, size: 26),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            const Spacer(),
            // Centered Logo
            GestureDetector(
              onTap: () {
                Get.offAll(() => const HomeView());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    'https://cdn-icons-png.flaticon.com/512/2654/2654518.png', // Panda logo face
                    height: 38,
                    width: 38,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 6),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                      children: const [
                        TextSpan(
                          text: "Panda's ",
                          style: TextStyle(color: Colors.black87),
                        ),
                        TextSpan(
                          text: "Box",
                          style: TextStyle(color: Color(0xFFE29578)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Right Icons (Search, Heart, Bag)
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black87, size: 24),
              onPressed: () {},
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(6),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.black87, size: 24),
              onPressed: () {},
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(6),
            ),
            IconButton(
              icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black87, size: 24),
              onPressed: () {},
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(6),
            ),
          ],
        ),
      );
    }

    // Desktop Navbar
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                )
              ]
            : [],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Get.offAll(() => const HomeView());
              },
              child: Row(
                children: [
                  Image.network(
                    'https://cdn-icons-png.flaticon.com/512/2654/2654518.png', // Panda logo face
                    height: 42,
                    width: 42,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.outfit(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                      children: const [
                        TextSpan(
                          text: "Panda's ",
                          style: TextStyle(color: Colors.black87),
                        ),
                        TextSpan(
                          text: "Box",
                          style: TextStyle(color: Color(0xFFE29578)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          // Nav Links
          Row(
            children: [
              _navItem(
                context,
                'SHOP ALL',
                hasDropdown: true,
                onTap: () => Get.to(() => const DivinePlushiesView(categoryName: 'Divine Plushies')),
              ),
              _navItem(
                context,
                'SUMMER EDIT',
                onTap: () => Get.to(() => const SummerEditView()),
              ),
              _navItem(
                context,
                'BIG DEALS',
                onTap: () => Get.to(() => const BigDealsView()),
              ),
              _navItem(
                context,
                'GIFTING',
                hasDropdown: true,
                onTap: () => Get.to(() => const DivinePlushiesView(categoryName: 'Gifting')),
              ),
              _navItem(
                context,
                'ABOUT US',
                hasDropdown: true,
                onTap: () {
                  Get.offAll(() => const HomeView());
                },
              ),
              _navItem(
                context,
                'PARENTING GUIDE',
                onTap: () {
                  Get.offAll(() => const HomeView());
                },
              ),
              _navItem(
                context,
                'AUDIO GALLERY',
                onTap: () => Get.to(() => const DivinePlushiesView(categoryName: 'Audio Gallery')),
              ),
              _navItem(
                context,
                'TRACK ORDER',
                onTap: () {
                  Get.snackbar(
                    'Track Order 📦',
                    'Tracking system simulation: Please enter order ID under Account details.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF006D77),
                    colorText: Colors.white,
                  );
                },
              ),
            ],
          ),
          const Spacer(),
          // Icons
          Row(
            children: [
              IconButton(icon: const Icon(Icons.search, color: Colors.black87), onPressed: () {}),
              IconButton(icon: const Icon(Icons.person_outline, color: Colors.black87), onPressed: () {}),
              IconButton(icon: const Icon(Icons.favorite_border, color: Colors.black87), onPressed: () {}),
              IconButton(icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black87), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, String title, {bool hasDropdown = false, VoidCallback? onTap}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                ),
              ),
              if (hasDropdown) ...[
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.black87),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class SharedDrawer extends StatelessWidget {
  const SharedDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width * 0.9,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black87, size: 26),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                  // Logo Centered in header
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.offAll(() => const HomeView());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                          'https://cdn-icons-png.flaticon.com/512/2654/2654518.png', // Panda logo face
                          height: 36,
                          width: 36,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 6),
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                            children: const [
                              TextSpan(
                                text: "Panda's ",
                                style: TextStyle(color: Colors.black87),
                              ),
                              TextSpan(
                                text: "Box",
                                style: TextStyle(color: Color(0xFFE29578)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Header Search, Heart, Bag
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.black87, size: 22),
                    onPressed: () {},
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(4),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border, color: Colors.black87, size: 22),
                    onPressed: () {},
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(4),
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black87, size: 22),
                    onPressed: () {},
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(4),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.black12),

            // Navigation Links
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                children: [
                  _drawerItem(
                    context,
                    'Shop All',
                    hasArrow: true,
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.to(() => const DivinePlushiesView(categoryName: 'Divine Plushies'));
                    },
                  ),
                  _drawerItem(
                    context,
                    'Summer Edit',
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.to(() => const SummerEditView());
                    },
                  ),
                  _drawerItem(
                    context,
                    'Big Deals',
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.to(() => const BigDealsView());
                    },
                  ),
                  _drawerItem(
                    context,
                    'Gifting',
                    hasArrow: true,
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.to(() => const DivinePlushiesView(categoryName: 'Gifting'));
                    },
                  ),
                  _drawerItem(
                    context,
                    'About Us',
                    hasArrow: true,
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.offAll(() => const HomeView());
                    },
                  ),
                  _drawerItem(
                    context,
                    'Parenting Guide',
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.offAll(() => const HomeView());
                    },
                  ),
                  _drawerItem(
                    context,
                    'Audio Gallery',
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.to(() => const DivinePlushiesView(categoryName: 'Audio Gallery'));
                    },
                  ),
                  _drawerItem(
                    context,
                    'Track Order',
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.snackbar(
                        'Track Order 📦',
                        'Tracking system simulation: Please enter order ID under Account details.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: const Color(0xFF006D77),
                        colorText: Colors.white,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(BuildContext context, String title, {bool hasArrow = false, VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            if (hasArrow)
              const Icon(Icons.chevron_right, size: 20, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}

class SharedBottomNavbar extends StatelessWidget {
  final int currentIndex;

  const SharedBottomNavbar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 900;

    if (!isMobile) return const SizedBox.shrink();

    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.black12, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
            isActive: currentIndex == 0,
            onTap: () {
              if (currentIndex != 0) {
                Get.offAll(() => const HomeView());
              }
            },
          ),
          _bottomNavItem(
            icon: Icons.dashboard_outlined,
            activeIcon: Icons.dashboard,
            label: 'Shop',
            isActive: currentIndex == 1,
            onTap: () {
              if (currentIndex != 1) {
                Get.to(() => const DivinePlushiesView(categoryName: 'Divine Plushies'));
              }
            },
          ),
          // Profile icon (green badge on top right, no label)
          GestureDetector(
            onTap: () {
              Get.snackbar(
                'Profile 👤',
                'Profile section simulation: Account details loaded.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF006D77),
                colorText: Colors.white,
              );
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.person_outline,
                  size: 28,
                  color: currentIndex == 2 ? const Color(0xFF006D77) : Colors.black54,
                ),
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFF25D366), // Green badge
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _bottomNavItem(
            icon: Icons.chat_bubble_outline,
            activeIcon: Icons.chat_bubble,
            label: 'Chat',
            isActive: currentIndex == 3,
            onTap: () {
              Get.snackbar(
                'Panda Assistant 🐼',
                'Hi! Need help with your order? Click to chat with us on WhatsApp.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFFFFDD67),
                colorText: Colors.black87,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _bottomNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final Color itemColor = isActive ? const Color(0xFF006D77) : Colors.black54;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              size: 24,
              color: itemColor,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                color: itemColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SharedFooter extends StatelessWidget {
  const SharedFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 900;

    Widget _buildFooterColumn(String title, List<String> links, {double? width}) {
      final content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 18),
          ...links.map((link) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  link,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )).toList(),
        ],
      );

      if (width != null) {
        return SizedBox(width: width, child: content);
      }
      return Expanded(child: content);
    }

    Widget _buildReachOutCol({double? width}) {
      final content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reach Out',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Work hours:\nMonday to Saturday\n10:00 AM to 6:00 PM\n\n+918810402508\ncare@pandasbox.in',
            style: GoogleFonts.outfit(
              fontSize: 14,
              height: 1.5,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Follow Us on',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _socialIcon(Icons.facebook),
              _socialIcon(Icons.camera_alt),
              _socialIcon(Icons.business),
              _socialIcon(Icons.play_arrow),
            ],
          ),
        ],
      );

      if (width != null) {
        return SizedBox(width: width, child: content);
      }
      return Expanded(child: content);
    }

    Widget buildLinksSection() {
      if (!isMobile) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFooterColumn('About', ['About Us', 'Media Coverage', 'FAQs', 'Parenting Guide', 'Newsletters']),
            _buildFooterColumn('Shop', ['Divine Plushies', 'Divine Decor', 'Books & Games', 'Divine Accessories', 'Storytellers', 'Bundle Offers', 'Bestsellers', 'Gifting']),
            _buildFooterColumn('Contact', ['Contact Us', 'Bulk Order Query', 'Register For Warranty', 'Careers']),
            _buildFooterColumn('Policies', ['Shipping Policy', 'Return Policy', 'Create a Return', 'Privacy Policy', 'Terms of Use']),
            _buildReachOutCol(),
          ],
        );
      } else {
        final double colWidth = screenWidth > 600 ? (screenWidth - 80) / 3 : (screenWidth - 60) / 2;
        return Wrap(
          spacing: 20,
          runSpacing: 40,
          alignment: WrapAlignment.start,
          children: [
            _buildFooterColumn('About', ['About Us', 'Media Coverage', 'FAQs', 'Parenting Guide', 'Newsletters'], width: colWidth),
            _buildFooterColumn('Shop', ['Divine Plushies', 'Divine Decor', 'Books & Games', 'Divine Accessories', 'Storytellers', 'Bundle Offers', 'Bestsellers', 'Gifting'], width: colWidth),
            _buildFooterColumn('Contact', ['Contact Us', 'Bulk Order Query', 'Register For Warranty', 'Careers'], width: colWidth),
            _buildFooterColumn('Policies', ['Shipping Policy', 'Return Policy', 'Create a Return', 'Privacy Policy', 'Terms of Use'], width: colWidth),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: _buildReachOutCol(width: double.infinity),
              ),
            ),
          ],
        );
      }
    }

    return Container(
      width: double.infinity,
      color: const Color(0xFFFFDD67),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: isMobile ? 40 : 60),
      child: Column(
        children: [
          buildLinksSection(),
          const SizedBox(height: 40),
          const Divider(color: Colors.black12, height: 1),
          const SizedBox(height: 24),
          Text(
            "India's First Mantra Chanting Plushies",
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "© 2026 Panda's Box - Siddhaye Enterprises Pvt Ltd.",
            style: GoogleFonts.outfit(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Icon(icon, size: 20, color: Colors.black87),
    );
  }
}
