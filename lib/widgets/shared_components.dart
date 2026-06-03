import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/home_view.dart';

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
                    'https://cdn-icons-png.flaticon.com/512/3069/3069188.png', // Floral logo placeholder
                    height: 40,
                    width: 40,
                    color: const Color(0xFF009688), // Themed icon
                  ),
                  const SizedBox(width: 8),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Soulful",
                        style: TextStyle(
                          color: Color(0xFF009688), // Teal
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Text(
                        "Haven®",
                        style: TextStyle(
                          color: Color(0xFFFF6B6B), // Coral
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          height: 0.8,
                        ),
                      ),
                    ],
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
                _navItem('SHOP ALL', hasDropdown: true),
                _navItem('SUMMER EDIT'),
                _navItem('BIG DEALS'),
                _navItem('GIFTING', hasDropdown: true),
                _navItem('ABOUT US', hasDropdown: true),
                _navItem('PARENTING GUIDE'),
                _navItem('AUDIO GALLERY'),
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

  Widget _navItem(String title, {bool hasDropdown = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
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
    );
  }
}

class SharedFooter extends StatelessWidget {
  const SharedFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // White text block above footer
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 40),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nurturing Young Minds for a Better Tomorrow", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              SizedBox(height: 12),
              Text(
                "We believe that every child deserves to grow up in an environment that fosters creativity, kindness, and emotional intelligence.\n"
                "Through interactive play and thoughtful design, our mission is to bring joy and learning into everyday moments.\n"
                "When children play, they learn how to navigate the world. Let's make that journey magical.",
                style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
              ),
            ],
          ),
        ),
        // Yellow Footer Main
        Container(
          width: double.infinity,
          color: const Color(0xFFFFD54F), // Bright Yellow matching screenshot
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
          child: Column(
            children: [
              // Top Links Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _footerColumn('Explore', ['Our Story', 'Press & Media', 'Help Center', 'Blog', 'Updates']),
                  _footerColumn('Categories', ['Soft Toys', 'Room Decor', 'Educational Books', 'Accessories', 'Gift Sets', 'Top Rated', 'Clearance']),
                  _footerColumn('Support', ['Get in Touch', 'Wholesale', 'Product Warranty', 'Join Our Team']),
                  _footerColumn('Legal', ['Delivery Info', 'Returns & Refunds', 'Privacy Notice', 'Terms of Service']),
                  // Contact Col
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Connect With Us', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 20),
                        const Text('Business Hours:\nMon - Sat: 10:00 AM to 6:00 PM\n\n+91 98765 43210\nhello@soulfulhaven.com', style: TextStyle(fontSize: 14, height: 1.5)),
                        const SizedBox(height: 20),
                        const Text('Follow Us on', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _socialIcon(Icons.facebook),
                            _socialIcon(Icons.camera_alt), // Instagram mockup
                            _socialIcon(Icons.business), // LinkedIn mockup
                            _socialIcon(Icons.play_arrow), // YouTube mockup
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              // Bottom Brand & Newsletter Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo Placeholder
                  Image.network('https://cdn-icons-png.flaticon.com/512/3069/3069188.png', height: 80),
                  const SizedBox(width: 40),
                  // Description
                  const Expanded(
                    child: Text(
                      "Soulful Haven is a modern brand dedicated to early childhood development.\n"
                      "We design toys and accessories that inspire imagination, promote well-being, and support parents in raising happy, healthy kids.",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 1.5),
                    ),
                  ),
                  const SizedBox(width: 40),
                  // Newsletter/WhatsApp
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Join Our Community ✨', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFD32F2F))),
                      const SizedBox(height: 8),
                      const Text('Get exclusive parenting tips & early access to sales.', style: TextStyle(fontSize: 14)),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.chat_bubble, color: Colors.white),
                        label: const Text('Join on WhatsApp', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF25D366), // WhatsApp Green
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 60),
              // Very bottom text
              const Divider(color: Colors.black12),
              const SizedBox(height: 20),
              const Text("Crafting Joyful Childhoods Since 2026", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("© 2026 Soulful Haven - All Rights Reserved.", style: TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _footerColumn(String title, List<String> links) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 20),
          ...links.map((link) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(link, style: const TextStyle(fontSize: 14, color: Colors.black87)),
          )).toList(),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Icon(icon, size: 20, color: Colors.black87),
    );
  }
}
