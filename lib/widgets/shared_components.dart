import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../view/home_view.dart';
import '../view/divine_plushies_view.dart';
import '../view/summer_edit_view.dart';

class SharedNavbar extends StatelessWidget {
  final bool isScrolled;

  const SharedNavbar({super.key, this.isScrolled = false});

  @override
  Widget build(BuildContext context) {
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
                // Navigate to home page, clearing the navigation stack
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
                          style: TextStyle(color: Color(0xFFE29578)), // Terracotta Orange/Coral
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
          if (MediaQuery.of(context).size.width > 900)
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
                  onTap: () => Get.to(() => const DivinePlushiesView(categoryName: 'Big Deals')),
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
        // Mobile layout: Wrap link columns and display contact col below
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
      color: const Color(0xFFFFDD67), // Pastel yellow matching web UI
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
