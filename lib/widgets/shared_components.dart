import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../view/home_view.dart';
import '../view/divine_plushies_view.dart';
import '../view/summer_edit_view.dart';
import '../view/big_deals_view.dart';
import '../view/parenting_guide_view.dart';
import '../view/audio_gallery_view.dart';

class SharedNavbar extends StatelessWidget {
  final bool isScrolled;

  const SharedNavbar({super.key, this.isScrolled = false});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 900;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          height: isScrolled ? 70 : 85,
          decoration: BoxDecoration(
            color: isScrolled ? AppColors.surface.withOpacity(0.8) : AppColors.surface.withOpacity(0.55),
            border: Border(
              bottom: BorderSide(
                color: isScrolled ? AppColors.textPrimary.withOpacity(0.06) : AppColors.textPrimary.withOpacity(0.02),
                width: 1,
              ),
            ),
            boxShadow: isScrolled
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 24.0),
          alignment: Alignment.center,
          child: isMobile ? _buildMobileRow(context) : _buildDesktopRow(context),
        ),
      ),
    );
  }

  Widget _buildMobileRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Hamburger menu button
        IconButton(
          icon: const Icon(Icons.menu, color: AppColors.textPrimary, size: 26),
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
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.pets, size: 28),
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
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                    TextSpan(
                      text: "Box",
                      style: TextStyle(color: AppColors.primary),
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
          icon: const Icon(Icons.search, color: AppColors.textPrimary, size: 24),
          onPressed: () {},
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.all(6),
        ),
        IconButton(
          icon: const Icon(Icons.favorite_border, color: AppColors.textPrimary, size: 24),
          onPressed: () {},
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.all(6),
        ),
        IconButton(
          icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.textPrimary, size: 24),
          onPressed: () {},
          constraints: const BoxConstraints(),
          padding: const EdgeInsets.all(6),
        ),
      ],
    );
  }

  Widget _buildDesktopRow(BuildContext context) {
    return Row(
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
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.pets, size: 32),
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
                        style: TextStyle(color: AppColors.textPrimary),
                      ),
                      TextSpan(
                        text: "Box",
                        style: TextStyle(color: AppColors.primary),
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _HoverNavItem(
              title: 'SHOP ALL',
              hasDropdown: true,
              onTap: () => Get.to(() => const DivinePlushiesView(categoryName: 'Divine Plushies')),
            ),
            _HoverNavItem(
              title: 'SUMMER EDIT',
              onTap: () => Get.to(() => const SummerEditView()),
            ),
            _HoverNavItem(
              title: 'BIG DEALS',
              onTap: () => Get.to(() => const BigDealsView()),
            ),
            _HoverNavItem(
              title: 'GIFTING',
              hasDropdown: true,
              onTap: () => Get.to(() => const DivinePlushiesView(categoryName: 'Gifting')),
            ),
            _HoverNavItem(
              title: 'ABOUT US',
              hasDropdown: true,
              onTap: () {
                Get.offAll(() => const HomeView());
              },
            ),
            _HoverNavItem(
              title: 'PARENTING GUIDE',
              onTap: () => Get.to(() => const ParentingGuideView()),
            ),
            _HoverNavItem(
              title: 'AUDIO GALLERY',
              onTap: () => Get.to(() => const AudioGalleryView()),
            ),
            _HoverNavItem(
              title: 'TRACK ORDER',
              onTap: () {
                Get.snackbar(
                  'Track Order 📦',
                  'Tracking system simulation: Please enter order ID under Account details.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.primary,
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
            IconButton(icon: const Icon(Icons.search, color: AppColors.textPrimary), onPressed: () {}),
            IconButton(icon: const Icon(Icons.person_outline, color: AppColors.textPrimary), onPressed: () {}),
            IconButton(icon: const Icon(Icons.favorite_border, color: AppColors.textPrimary), onPressed: () {}),
            IconButton(icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.textPrimary), onPressed: () {}),
          ],
        ),
      ],
    );
  }
}

class _HoverNavItem extends StatefulWidget {
  final String title;
  final bool hasDropdown;
  final VoidCallback? onTap;

  const _HoverNavItem({
    required this.title,
    this.hasDropdown = false,
    this.onTap,
  });

  @override
  State<_HoverNavItem> createState() => _HoverNavItemState();
}

class _HoverNavItemState extends State<_HoverNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: _isHovered ? AppColors.primary : AppColors.textPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    if (widget.hasDropdown) ...[
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 14,
                        color: _isHovered ? AppColors.primary : AppColors.textPrimary,
                      ),
                    ]
                  ],
                ),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _isHovered ? 20 : 0,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(1),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: AppColors.secondary.withValues(alpha: 0.8),
                            blurRadius: 4,
                          )
                        ]
                      : [],
                ),
              )
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
      backgroundColor: AppColors.surface,
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
                    icon: const Icon(Icons.close, color: AppColors.textPrimary, size: 26),
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
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.pets, size: 26),
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
                                style: TextStyle(color: AppColors.textPrimary),
                              ),
                              TextSpan(
                                text: "Box",
                                style: TextStyle(color: AppColors.primary),
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
                    icon: const Icon(Icons.search, color: AppColors.textPrimary, size: 22),
                    onPressed: () {},
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(4),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite_border, color: AppColors.textPrimary, size: 22),
                    onPressed: () {},
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(4),
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.textPrimary, size: 22),
                    onPressed: () {},
                    constraints: const BoxConstraints(),
                    padding: const EdgeInsets.all(4),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),

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
                      Get.to(() => const ParentingGuideView());
                    },
                  ),
                  _drawerItem(
                    context,
                    'Audio Gallery',
                    onTap: () {
                      Navigator.of(context).pop();
                      Get.to(() => const AudioGalleryView());
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
                        backgroundColor: AppColors.primary,
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
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            if (hasArrow)
              const Icon(Icons.chevron_right, size: 20, color: AppColors.textSecondary),
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
      height: 66,
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        border: const Border(
          top: BorderSide(color: AppColors.border, width: 0.5),
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
                backgroundColor: AppColors.primary,
                colorText: Colors.white,
              );
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: currentIndex == 2 ? AppColors.primary.withValues(alpha: 0.15) : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: currentIndex == 2
                        ? Border.all(color: AppColors.secondary.withValues(alpha: 0.5), width: 1)
                        : null,
                    boxShadow: currentIndex == 2
                        ? [
                            BoxShadow(
                              color: AppColors.secondary.withValues(alpha: 0.3),
                              blurRadius: 8,
                            )
                          ]
                        : null,
                  ),
                  child: Icon(
                    Icons.person_outline,
                    size: 24,
                    color: currentIndex == 2 ? AppColors.primary : AppColors.textSecondary,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 12,
                  child: Container(
                    width: 8,
                    height: 8,
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
                backgroundColor: AppColors.warning,
                colorText: AppColors.textPrimary,
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary.withValues(alpha: 0.15) : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: isActive
                    ? Border.all(color: AppColors.secondary.withValues(alpha: 0.5), width: 1)
                    : null,
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: AppColors.secondary.withValues(alpha: 0.3),
                          blurRadius: 8,
                        )
                      ]
                    : null,
              ),
              child: Icon(
                isActive ? activeIcon : icon,
                size: 24,
                color: isActive ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: GoogleFonts.outfit(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                color: isActive ? AppColors.primary : AppColors.textSecondary,
              ),
              child: Text(label),
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
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 18),
          ...links.map((link) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _FooterLink(
              label: link,
              onTap: () {
                if (link == 'Parenting Guide') {
                  Get.to(() => const ParentingGuideView());
                } else if (link == 'About Us') {
                  Get.offAll(() => const HomeView());
                } else if (link == 'Summer Edit') {
                  Get.to(() => const SummerEditView());
                } else if (link == 'Big Deals') {
                  Get.to(() => const BigDealsView());
                } else if (link == 'Divine Plushies' || link == 'Gifting') {
                  Get.to(() => DivinePlushiesView(categoryName: link));
                }
              },
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
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Work hours:\nMonday to Saturday\n10:00 AM to 6:00 PM\n\n+918810402508\ncare@pandasbox.in',
            style: GoogleFonts.outfit(
              fontSize: 14,
              height: 1.5,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Follow Us on',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              _FooterSocialIcon(icon: Icons.facebook),
              _FooterSocialIcon(icon: Icons.camera_alt),
              _FooterSocialIcon(icon: Icons.business),
              _FooterSocialIcon(icon: Icons.play_arrow),
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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF7F2EB),
            Color(0xFFEDE4D7),
          ],
        ),
        border: Border(
          top: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: isMobile ? 40 : 60),
      child: Column(
        children: [
          buildLinksSection(),
          const SizedBox(height: 40),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 24),
          Text(
            "India's First Mantra Chanting Plushies",
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "© 2026 Panda's Box - Siddhaye Enterprises Pvt Ltd.",
            style: GoogleFonts.outfit(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterLink({required this.label, required this.onTap});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: GoogleFonts.outfit(
            fontSize: 14,
            color: _isHovered ? AppColors.primary : AppColors.textSecondary,
            fontWeight: _isHovered ? FontWeight.bold : FontWeight.w500,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class _FooterSocialIcon extends StatefulWidget {
  final IconData icon;

  const _FooterSocialIcon({required this.icon});

  @override
  State<_FooterSocialIcon> createState() => _FooterSocialIconState();
}

class _FooterSocialIconState extends State<_FooterSocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(8),
        transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.primary : AppColors.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withValues(alpha: _isHovered ? 0.4 : 0.08),
              blurRadius: _isHovered ? 12 : 4,
              offset: Offset(0, _isHovered ? 4 : 2),
            )
          ],
        ),
        child: Icon(
          widget.icon,
          size: 20,
          color: _isHovered ? Colors.white : AppColors.textPrimary,
        ),
      ),
    );
  }
}
