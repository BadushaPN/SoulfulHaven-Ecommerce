import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../widgets/shared_components.dart';

class BigDealsView extends StatefulWidget {
  const BigDealsView({super.key});

  @override
  State<BigDealsView> createState() => _BigDealsViewState();
}

class _BigDealsViewState extends State<BigDealsView> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  bool _showScrollToTop = false;

  final List<Map<String, dynamic>> _deals = [
    {
      'title': 'Plush Mandir Set',
      'subtitle': 'Buy 1 Medium Plushie & 1 Plush Mandir',
      'price': 2399,
      'oldPrice': 3998,
      'imageUrl': 'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?q=80&w=600',
    },
    {
      'title': 'Divine Play Collection',
      'subtitle': 'Buy Any 2 Small Plushies & 1 Plush Mandir',
      'price': 2899,
      'oldPrice': 4697,
      'imageUrl': 'https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?q=80&w=600',
    },
    {
      'title': 'Small Cuddle Combo',
      'subtitle': 'Buy Any 2 Small Plushies',
      'price': 1458,
      'oldPrice': 2198,
      'imageUrl': 'https://images.unsplash.com/photo-1519689680058-324335c77eba?q=80&w=600',
    },
    {
      'title': 'Mixed Hugs Duo',
      'subtitle': 'Buy Any 2 Plushies (1 Small & 1 Medium)',
      'price': 1648,
      'oldPrice': 2598,
      'imageUrl': 'https://images.unsplash.com/photo-1515488042361-404e9250afef?q=80&w=600',
    },
    {
      'title': 'Cuddle & Charm Combo',
      'subtitle': 'Buy Any 1 Accessory & 1 Small Plushie',
      'price': 969,
      'oldPrice': 1498,
      'imageUrl': 'https://images.unsplash.com/photo-1513360371669-4adf3dd7dff8?q=80&w=600',
    },
    {
      'title': 'Cuddle Classic',
      'subtitle': 'Buy Any 1 Accessory & 1 Medium Plushie',
      'price': 1159,
      'oldPrice': 1899,
      'imageUrl': 'https://images.unsplash.com/photo-1473830394358-91588751b241?q=80&w=600',
    },
    {
      'title': 'Medium Cuddle Combo',
      'subtitle': 'Buy Any 2 Medium Plushies',
      'price': 1838,
      'oldPrice': 2998,
      'imageUrl': 'https://images.unsplash.com/photo-1602498456745-e9503b30470b?q=80&w=600',
    },
    {
      'title': 'Accessorized Book',
      'subtitle': 'Buy 1 Musical Book & 1 Accessory',
      'price': 1399,
      'oldPrice': 2998,
      'imageUrl': 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?q=80&w=600',
    },
    {
      'title': 'Birthday Gift Hamper',
      'subtitle': 'Buy 1 Musical Book, 1 Storyteller & 1 Gifting Bag',
      'price': 2099,
      'oldPrice': 3847,
      'imageUrl': 'https://images.unsplash.com/photo-1513201099705-a9746e1e201f?q=80&w=600',
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 50 && !_isScrolled) {
        setState(() => _isScrolled = true);
      } else if (_scrollController.offset <= 50 && _isScrolled) {
        setState(() => _isScrolled = false);
      }

      if (_scrollController.offset > 300 && !_showScrollToTop) {
        setState(() => _showScrollToTop = true);
      } else if (_scrollController.offset <= 300 && _showScrollToTop) {
        setState(() => _showScrollToTop = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 768;
    final double horizontalPadding = screenWidth > 900 ? 100 : 20;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const SharedDrawer(),
      bottomNavigationBar: const SharedBottomNavbar(currentIndex: 1),
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 80), // For sticky navbar
                
                // Centered SAVE BIG DEALS title
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Center(
                    child: Text(
                      'SAVE BIG DEALS',
                      style: GoogleFonts.outfit(
                        fontSize: isMobile ? 32 : 46,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),

                // Grid list of combos
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // 3 columns on desktop, 2 on tablet, 1 on mobile
                      int crossAxisCount = constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
                      double childAspectRatio = constraints.maxWidth > 900 ? 0.70 : (constraints.maxWidth > 600 ? 0.68 : 0.85);

                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _deals.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 30,
                          childAspectRatio: childAspectRatio,
                        ),
                        itemBuilder: (context, index) {
                          var deal = _deals[index];
                          return AnimatedDealCard(
                            title: deal['title'],
                            subtitle: deal['subtitle'],
                            price: deal['price'],
                            oldPrice: deal['oldPrice'],
                            imageUrl: deal['imageUrl'],
                          );
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 100),
                const SharedFooter(),
              ],
            ),
          ),

          // Sticky Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SharedNavbar(isScrolled: _isScrolled),
          ),

          // Left Bottom Floating Coin Icon
          Positioned(
            bottom: isMobile ? 94 : 30,
            left: 20,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Get.snackbar(
                    'Panda Club Rewards 🪙',
                    'Join our rewards program to earn coins on every purchase!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFFD93D3D),
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(20),
                    borderRadius: 12,
                  );
                },
                child: Hero(
                  tag: 'rupee_coin',
                  child: Container(
                    width: isMobile ? 44 : 54,
                    height: isMobile ? 44 : 54,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD93D3D), // Red background
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: const Color(0xFFFFD700), width: 2.5), // Gold border
                    ),
                    child: const Center(
                      child: Text(
                        '₹',
                        style: TextStyle(
                          color: Color(0xFFFFD700),
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Right Bottom Floating Action Buttons
          Positioned(
            bottom: isMobile ? 94 : 30,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Scroll to top button
                if (_showScrollToTop) ...[
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _scrollToTop,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD93D3D), // Red background
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
                // Panda Chat Assistant Button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Get.snackbar(
                        'Panda Assistant 🐼',
                        'Hi! Need help with your order? Click to chat with us on WhatsApp.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: const Color(0xFFFFDD67),
                        colorText: Colors.black87,
                        margin: const EdgeInsets.all(20),
                        borderRadius: 12,
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFDD67), // Yellow background
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Image.network(
                        'https://cdn-icons-png.flaticon.com/512/2654/2654518.png', // Panda face
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedDealCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final int price;
  final int oldPrice;
  final String imageUrl;

  const AnimatedDealCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.oldPrice,
    required this.imageUrl,
  });

  @override
  State<AnimatedDealCard> createState() => _AnimatedDealCardState();
}

class _AnimatedDealCardState extends State<AnimatedDealCard> {
  bool _isHovered = false;
  bool _isButtonHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.08 : 0.03),
              blurRadius: _isHovered ? 16 : 8,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image Container with Zoom effect on card hover
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  width: double.infinity,
                  color: Colors.grey.shade50,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: AnimatedScale(
                          scale: _isHovered ? 1.05 : 1.0,
                          duration: const Duration(milliseconds: 250),
                          child: Image.network(
                            widget.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.image, size: 50, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Deal Info Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.subtitle,
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  
                  // Dual Pricing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '₹${widget.price}',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '₹${widget.oldPrice}',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Build Your Box Outline Button
                  MouseRegion(
                    onEnter: (_) => setState(() => _isButtonHovered = true),
                    onExit: (_) => setState(() => _isButtonHovered = false),
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Get.snackbar(
                          'Build Your Box 🎁',
                          'Initializing custom box editor for ${widget.title}...',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.black,
                          colorText: Colors.white,
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _isButtonHovered ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        child: Center(
                          child: Text(
                            'Build Your Box',
                            style: GoogleFonts.outfit(
                              color: _isButtonHovered ? Colors.white : Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
