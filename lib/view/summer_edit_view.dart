import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../widgets/shared_components.dart';

class SummerEditView extends StatefulWidget {
  const SummerEditView({super.key});

  @override
  State<SummerEditView> createState() => _SummerEditViewState();
}

class _SummerEditViewState extends State<SummerEditView> {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80), // Sticky Navbar Space
                _buildCollageBanner(context),
                _buildFiltersRow(context),
                _buildEmptyState(context),
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
                      border: Border.all(
                        color: const Color(0xFFFFD700),
                        width: 2.5,
                      ), // Gold border
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

  Widget _buildCollageBanner(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 768;

    // List of placeholder kids images holding soft toys
    final List<String> kidImages = [
      'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?q=80&w=600', // Toddler with Ganesha vibe
      'https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?q=80&w=600', // Playing kid
      'https://images.unsplash.com/photo-1519689680058-324335c77eba?q=80&w=600', // Happy kids
      'https://images.unsplash.com/photo-1515488042361-404e9250afef?q=80&w=600', // Playing child
      'https://images.unsplash.com/photo-1513360371669-4adf3dd7dff8?q=80&w=600', // Creative kid
      'https://images.unsplash.com/photo-1473830394358-91588751b241?q=80&w=600', // Smiling toddler
    ];

    // Build Polaroid widget
    Widget buildPolaroid(
      String url,
      double rotation, {
      double width = 160,
      double height = 180,
    }) {
      return Transform.rotate(
        angle: rotation,
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 6,
                offset: const Offset(2, 4),
              ),
            ],
            border: Border.all(color: Colors.grey.shade100, width: 0.5),
          ),
          child: Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey.shade200,
              child: const Icon(Icons.image, color: Colors.grey),
            ),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      color: const Color(0xFFE4E1D5), // Soft sand watercolor texture color
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPolaroid(kidImages[0], -0.06),
              const SizedBox(width: 12),
              buildPolaroid(kidImages[1], 0.05),
              const SizedBox(width: 12),
              buildPolaroid(kidImages[2], -0.04),
              const SizedBox(width: 24),

              // Center "Happy Toddlers" Polaroid title
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'Happy Toddlers',
                  style: GoogleFonts.outfit(
                    fontSize: isMobile ? 32 : 46,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF5D5950),
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const SizedBox(width: 24),
              buildPolaroid(kidImages[3], 0.04),
              const SizedBox(width: 12),
              buildPolaroid(kidImages[4], -0.05),
              const SizedBox(width: 12),
              buildPolaroid(kidImages[5], 0.06),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFiltersRow(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double paddingHorizontal = screenWidth > 900 ? 100 : 24;

    return Padding(
      padding: EdgeInsets.only(
        left: paddingHorizontal,
        right: paddingHorizontal,
        top: 30,
        bottom: 20,
      ),
      child: Row(
        children: [
          _buildDropdownButton('FILTER'),
          const SizedBox(width: 30),
          _buildDropdownButton('Most relevant'),
        ],
      ),
    );
  }

  Widget _buildDropdownButton(String label) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 15,
                fontWeight: label == 'FILTER'
                    ? FontWeight.w800
                    : FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Sorry, there are no products in this collection',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
