import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/shared_components.dart';

class DivinePlushiesView extends StatefulWidget {
  final String categoryName;

  const DivinePlushiesView({super.key, required this.categoryName});

  @override
  State<DivinePlushiesView> createState() => _DivinePlushiesViewState();
}

class _DivinePlushiesViewState extends State<DivinePlushiesView> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  bool _showScrollToTop = false;

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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 768;

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
                _buildBanner(context),
                _buildFiltersRow(context),
                _buildProductGrid(context),
                const SizedBox(height: 80),
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
                      border: Border.all(
                        color: const Color(0xFFFFD700),
                        width: 2.5,
                      ), // Gold border
                    ),
                    child: Center(
                      child: Text(
                        '₹',
                        style: TextStyle(
                          color: const Color(0xFFFFD700),
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
                      onTap: () {
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeInOut,
                        );
                      },
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
                        child: const Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.white,
                          size: 24,
                        ),
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

  Widget _buildBanner(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 600;

    String firstWord = "DIVINE";
    String restWords = "COLLECTION";

    if (widget.categoryName.contains(' ')) {
      List<String> parts = widget.categoryName.split(' ');
      firstWord = parts[0].toUpperCase();
      restWords = parts.sublist(1).join(' ').toUpperCase();
    } else {
      firstWord = widget.categoryName.toUpperCase();
      restWords = "COLLECTION";
    }

    return Container(
      width: double.infinity,
      height: isMobile ? 250 : 400,
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F6),
        image: DecorationImage(
          image: const NetworkImage(
            'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?q=80&w=2000&auto=format&fit=crop',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            const Color(0xFF006D77).withOpacity(0.08),
            BlendMode.srcOver,
          ),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "OUR LATEST $firstWord",
              style: TextStyle(
                fontSize: isMobile ? 32 : 60,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF006D77), // Deep Teal
                letterSpacing: 2.0,
                shadows: [
                  Shadow(
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              restWords,
              style: TextStyle(
                fontSize: isMobile ? 32 : 60,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF006D77), // Deep Teal
                letterSpacing: 2.0,
                shadows: [
                  Shadow(
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltersRow(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 900 ? 100 : 20,
        vertical: screenWidth > 600 ? 30 : 20,
      ),
      child: Row(
        children: [
          _filterDropdown("FILTER"),
          const SizedBox(width: 30),
          _filterDropdown("Featured"),
        ],
      ),
    );
  }

  Widget _filterDropdown(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black87),
      ],
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 900 ? 40 : 16,
        vertical: 20,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Up to 7 columns for large screens to make cards smaller
          int crossAxisCount = constraints.maxWidth > 1400
              ? 7
              : (constraints.maxWidth > 1000
                    ? 5
                    : (constraints.maxWidth > 600 ? 3 : 2));
          double childAspectRatio = constraints.maxWidth > 600 ? 0.45 : 0.41;

          // Generate 14 items to ensure the page is scrollable
          List<Widget> products = List.generate(14, (index) {
            List<Map<String, dynamic>> dummyData = [];

            if (widget.categoryName == 'Divine Plushies') {
              dummyData = [
                {
                  'img':
                      'https://cdn-icons-png.flaticon.com/512/3082/3082008.png',
                  'title': 'Mantra Chanting Baby Ganesha',
                },
                {
                  'img':
                      'https://cdn-icons-png.flaticon.com/512/3094/3094833.png',
                  'title': 'Mantra Chanting Baby Krishna',
                },
                {
                  'img':
                      'https://cdn-icons-png.flaticon.com/512/2922/2922572.png',
                  'title': 'Mantra Chanting Baby Hanuman',
                },
                {
                  'img':
                      'https://cdn-icons-png.flaticon.com/512/3069/3069188.png',
                  'title': 'Mantra Chanting Baby Shiva',
                },
              ];
            } else if (widget.categoryName == 'Divine Decor') {
              dummyData = [
                {
                  'img':
                      'https://cdn-icons-png.flaticon.com/512/3069/3069188.png',
                  'title': 'Mandir for Kids (DIY)',
                },
                {
                  'img':
                      'https://cdn-icons-png.flaticon.com/512/3082/3082008.png',
                  'title': 'Wall Hangings & Torans',
                },
                {
                  'img':
                      'https://cdn-icons-png.flaticon.com/512/2922/2922572.png',
                  'title': 'Play Mats with Patterns',
                },
              ];
            } else if (widget.categoryName == 'Story Tellers') {
              dummyData = [
                {
                  'img':
                      'https://cdn-icons-png.flaticon.com/512/3094/3094833.png',
                  'title': 'Interactive Audio Books',
                },
                {
                  'img':
                      'https://cdn-icons-png.flaticon.com/512/3082/3082008.png',
                  'title': 'Ramayana Flash Cards',
                },
                {
                  'img':
                      'https://cdn-icons-png.flaticon.com/512/2922/2922572.png',
                  'title': 'Mythology Story Cubes',
                },
              ];
            } else if (widget.categoryName == 'Books & Games') {
              dummyData = [
                {
                  'img':
                      'https://cdn-icons-png.flaticon.com/512/3094/3094848.png',
                  'title': 'My First Book of Mantras',
                },
                {
                  'img':
                      'https://cdn-icons-png.flaticon.com/512/3094/3094833.png',
                  'title': 'Gods & Goddesses Puzzle',
                },
                {
                  'img':
                      'https://cdn-icons-png.flaticon.com/512/3069/3069188.png',
                  'title': 'Festival Activity Kit',
                },
              ];
            } else {
              dummyData = [
                {
                  'img':
                      'https://cdn-icons-png.flaticon.com/512/3094/3094844.png',
                  'title': 'Kids Prayer Beads',
                },
                {
                  'img':
                      'https://cdn-icons-png.flaticon.com/512/3082/3082008.png',
                  'title': 'Traditional Wear for Plushies',
                },
                {
                  'img':
                      'https://cdn-icons-png.flaticon.com/512/2922/2922572.png',
                  'title': 'traditional wear',
                },
              ];
            }
            var data = dummyData[index % dummyData.length];

            return AnimatedProductCard(
              imageUrl: data['img'],
              title: data['title'],
              sizeInfo: '(Medium-28 cm)',
              rating: 4.8 + (index % 3) * 0.02,
              price: 999,
              oldPrice: 1499,
              discount: 33,
            );
          });

          return GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: childAspectRatio,
            children: products,
          );
        },
      ),
    );
  }
}

class AnimatedProductCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String sizeInfo;
  final double rating;
  final int price;
  final int oldPrice;
  final int discount;

  const AnimatedProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.sizeInfo,
    required this.rating,
    required this.price,
    required this.oldPrice,
    required this.discount,
  });

  @override
  State<AnimatedProductCard> createState() => _AnimatedProductCardState();
}

class _AnimatedProductCardState extends State<AnimatedProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.04 : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: const Color(0xFF006D77).withOpacity(0.12),
                blurRadius: 16,
                offset: const Offset(0, 8),
              )
            else
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
          border: Border.all(
            color: _isHovered ? const Color(0xFF006D77).withOpacity(0.15) : Colors.grey.shade100,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image Area
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(
                        10.0,
                      ), // Reduced padding for smaller card
                      child: AnimatedScale(
                        scale: _isHovered ? 1.06 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  // Wishlist Icon Bottom Right
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(6), // Reduced padding
                      decoration: BoxDecoration(
                        color: _isHovered
                            ? const Color(0xFFE29578)
                            : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        size: 16, // Smaller icon
                        color: _isHovered
                            ? Colors.white
                            : const Color(0xFF006D77),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Info Area
            Padding(
              padding: const EdgeInsets.all(12.0), // Reduced padding
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 12, // Smaller font
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2, // Allow 2 lines if needed due to smaller width
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.sizeInfo,
                    style: const TextStyle(
                      fontSize: 10, // Smaller font
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  // Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            size: 10,
                            color: Color(0xFFFFC107),
                          ),
                        ), // Smaller stars
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.rating.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Pricing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '₹${widget.price}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ), // Smaller font
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '₹${widget.oldPrice}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE29578), Color(0xFFFFB300)],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${widget.discount}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Add to Cart Button
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: double.infinity,
                    height: 38,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _isHovered
                            ? [const Color(0xFFE29578), const Color(0xFFFFB300)]
                            : [const Color(0xFF006D77), const Color(0xFF83C5BE)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: _isHovered
                          ? [
                              BoxShadow(
                                color: const Color(0xFFE29578).withOpacity(0.35),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              )
                            ]
                          : [],
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 14,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Add to Cart',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
