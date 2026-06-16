import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../widgets/shared_components.dart';

class ParentingGuideView extends StatefulWidget {
  const ParentingGuideView({super.key});

  @override
  State<ParentingGuideView> createState() => _ParentingGuideViewState();
}

class _ParentingGuideViewState extends State<ParentingGuideView> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  bool _showScrollToTop = false;
  int _currentPage = 1;

  final List<Map<String, String>> _articles = [
    {
      'title': '10 Easy Mantras Every Child Can Learn',
      'desc': 'Discover 10 simple, soothing mantras children can easily learn — from Vakratunda Mahakaya to...',
      'imageUrl': 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?q=80&w=600',
    },
    {
      'title': 'How to Remove Nazar From Kids: 7 Gentle Indian Rituals For...',
      'desc': 'How to remove Nazar from kids. Gentle Indian rituals that bring comfort, protection & calm...',
      'imageUrl': 'https://images.unsplash.com/photo-1606744824163-985d376605aa?q=80&w=600',
    },
    {
      'title': 'Why Do We Offer Water to the Sun?',
      'desc': 'A simple, meaningful ritual explained for kids. Many Indian families begin their mornings by offering...',
      'imageUrl': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=600',
    },
    {
      'title': '10 Avatars of Vishnu Ji (Dashavatara) – Stories...',
      'desc': 'Introduction in Indian culture. Vishnu is known as the protector of the universe. Whenever imbalance rises...',
      'imageUrl': 'https://images.unsplash.com/photo-1582506307185-1d48c909e701?q=80&w=600',
    },
    {
      'title': 'Akshay Tritiya 2026: Meaning, Significance & How to...',
      'desc': 'Akshaya Tritiya, also known as Akshaya Tritiya, is one of the most auspicious days in...',
      'imageUrl': 'https://images.unsplash.com/photo-1604502844222-1f4a478c9ed3?q=80&w=600',
    },
    {
      'title': 'Mahavir Jayanti for Kids: Teaching Kindness, Non-...',
      'desc': 'Mahavir Jayanti for kids is more than just a festival — it is a beautiful opportunity...',
      'imageUrl': 'https://images.unsplash.com/photo-1599839619722-39751411ea63?q=80&w=600',
    },
    {
      'title': 'How to Introduce Hindu Gods to Kids – Simple & Fun Guide',
      'desc': 'What are Hindu Gods? A simple explanation for kids. Hindu gods are divine forms that...',
      'imageUrl': 'https://images.unsplash.com/photo-1519689680058-324335c77eba?q=80&w=600',
    },
    {
      'title': 'What is a Naming Ceremony? Significance, Rituals & Moder...',
      'desc': 'A naming ceremony is one of the first meaningful celebrations in a baby\'s life. It...',
      'imageUrl': 'https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?q=80&w=600',
    },
    {
      'title': 'Republic Day in India: Meaning, Significance & Introducing...',
      'desc': 'Republic Day, celebrated every year on 26th January, marks one of the most important milestones...',
      'imageUrl': 'https://images.unsplash.com/photo-1532375811409-e16002fecbe1?q=80&w=600',
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
      bottomNavigationBar: const SharedBottomNavbar(currentIndex: 0),
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 80), // Sticky Navbar space
                _buildHeroBanner(context),
                
                // Articles Grid
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 40),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
                      double childAspectRatio = constraints.maxWidth > 900 ? 0.76 : (constraints.maxWidth > 600 ? 0.74 : 0.82);

                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _articles.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 30,
                          childAspectRatio: childAspectRatio,
                        ),
                        itemBuilder: (context, index) {
                          var article = _articles[index];
                          return _buildArticleCard(context, article);
                        },
                      );
                    },
                  ),
                ),

                // Pagination Row
                _buildPaginationRow(),

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

  Widget _buildHeroBanner(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 768;

    return Container(
      width: double.infinity,
      color: const Color(0xFFFAF8F5), // Soft warm off-white background
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left child illustration image (Hidden on small mobile for clean design)
              if (screenWidth > 600)
                Image.network(
                  'https://images.unsplash.com/photo-1542038784456-1ea8e935640e?q=80&w=300', // Mother and kid
                  height: isMobile ? 120 : 220,
                  fit: BoxFit.contain,
                )
              else
                const SizedBox.shrink(),

              // Right family illustration image
              if (screenWidth > 600)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?q=80&w=300', // Family
                      height: isMobile ? 120 : 220,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 40), // Spacing for Shark Tank badge
                  ],
                )
              else
                const SizedBox.shrink(),
            ],
          ),

          // Centered large red text "Parenting Guide"
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Parenting',
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 36 : 72,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFFC82A2E), // Crimson Red
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Guide',
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 36 : 72,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFFC82A2E), // Crimson Red
                  height: 1.0,
                ),
              ),
            ],
          ),

          // Shark Tank Badge on far right (Positioned)
          Positioned(
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF0C2340), // Dark blue
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFFD700), width: 1.5), // Gold border
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'AS SEEN ON',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'SHARK',
                    style: GoogleFonts.outfit(
                      color: const Color(0xFFFFD700), // Gold
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    'TANK',
                    style: GoogleFonts.outfit(
                      color: const Color(0xFFFFD700), // Gold
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'INDIA',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(BuildContext context, Map<String, String> article) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF8), // Extremely light warm beige tint
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Card Image with rounded corners
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                article['imageUrl']!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade100,
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
              ),
            ),
          ),

          // Info Column
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                Text(
                  article['title']!,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Snippet description
                Text(
                  article['desc']!,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black45,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 18),
                
                // Read More Button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Get.snackbar(
                        article['title']!,
                        'Opening full blog article simulation...',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: const Color(0xFFC82A2E),
                        colorText: Colors.white,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC82A2E), // Crimson Red
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Read More',
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.arrow_right_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
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
    );
  }

  Widget _buildPaginationRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPageCircle('1', isActive: _currentPage == 1),
          _buildPageCircle('2', isActive: _currentPage == 2),
          _buildPageCircle('3', isActive: _currentPage == 3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '..',
              style: GoogleFonts.outfit(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildPageCircle('5', isActive: _currentPage == 5),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentPage = (_currentPage % 5) + 1;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(8),
                child: Text(
                  '»',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageCircle(String label, {required bool isActive}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _currentPage = int.tryParse(label) ?? _currentPage;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isActive ? Colors.grey.shade300 : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.black87 : Colors.grey.shade600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
