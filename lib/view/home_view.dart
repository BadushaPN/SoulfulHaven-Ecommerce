import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../controller/home_controller.dart';
import '../widgets/shared_components.dart';
import 'divine_plushies_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  bool _showScrollToTop = false;

  final PageController _pageController = PageController();
  int _currentCarouselIndex = 0;
  Timer? _carouselTimer;

  final List<String> _carouselImages = [
    'https://images.unsplash.com/photo-1602498456745-e9503b30470b?q=80&w=2000&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1519689680058-324335c77eba?auto=format&fit=crop&q=80&w=2000',
    'https://images.unsplash.com/photo-1473830394358-91588751b241?q=80&w=2000&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1502086223501-7ea6ecd79368?q=80&w=2000&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1513360371669-4adf3dd7dff8?q=80&w=2000&auto=format&fit=crop',
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

    _carouselTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int nextIndex = (_currentCarouselIndex + 1) % _carouselImages.length;
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 768;

    return Scaffold(
      backgroundColor: const Color(0xFFEDF6F9), // Ice blue background
      drawer: const SharedDrawer(),
      bottomNavigationBar: const SharedBottomNavbar(currentIndex: 0),
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Space for the sticky header
                const SizedBox(height: 80),
                _buildHeroSection(context),
                _buildTrustBadgesRow(),
                const SizedBox(height: 60),
                _buildOurCollectionSection(context),
                const SizedBox(height: 80),
                _buildBestSellersSection(context),
                _buildVideoSection(),
                _buildPriceFiltersSection(context),
                const SizedBox(height: 60),
                _buildParentingGuideSection(context),
                const SizedBox(height: 80),
                const SharedFooter(),
              ],
            ),
          ),

          // Sticky Header (Navbar)
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

  Widget _buildHeroSection(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 990;
    double screenHeight =
        MediaQuery.of(context).size.height - 80; // Minus navbar
    if (screenHeight < 600) screenHeight = 600;

    return Container(
      width: double.infinity,
      height: isMobile ? null : screenHeight,
      decoration: const BoxDecoration(color: Color(0xFFEDF6F9)),
      child: Stack(
        children: [
          // Background Carousel
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) =>
                  setState(() => _currentCarouselIndex = index),
              itemCount: _carouselImages.length,
              itemBuilder: (context, index) {
                return Image.network(
                  _carouselImages[index],
                  fit: BoxFit.cover,
                  color: const Color(0xFF006D77).withOpacity(0.1),
                  colorBlendMode: BlendMode.srcOver,
                );
              },
            ),
          ),

          if (isMobile)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Introducing My First Book of',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF006D77),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        'MANTRAS',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w900,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = const Color(0xFF006D77).withOpacity(0.6),
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        'MANTRAS',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF006D77).withOpacity(0.1),
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'A BEAUTIFULLY ILLUSTRATED MUSICAL\nMANTRA BOOK FOR LITTLE LEARNERS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFE29578),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'JUST AT - ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF006D77),
                        ),
                      ),
                      Text(
                        'MRP - ',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF006D77),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        '1899/-',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF006D77),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Transform.rotate(
                    angle: -0.05,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF006D77),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Pass Down ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: 'Values,',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFE29578),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Transform.rotate(
                    angle: 0.02,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE29578),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Not Just ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: 'Toys',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF006D77),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE29578),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 36,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: const BorderSide(color: Colors.white, width: 2),
                      ),
                      elevation: 6,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'SHOP NOW',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.touch_app, color: Colors.white, size: 24),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else ...[
            // Text Overlays
            Positioned(
              left: MediaQuery.of(context).size.width * 0.05,
              top: screenHeight * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Introducing My First Book of',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF006D77),
                      letterSpacing: 1.2,
                    ),
                  ),
                  Stack(
                    children: [
                      Text(
                        'MANTRAS',
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.w900,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = const Color(0xFF006D77).withOpacity(0.6),
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        'MANTRAS',
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF006D77).withOpacity(0.1),
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'A BEAUTIFULLY ILLUSTRATED MUSICAL\nMANTRA BOOK FOR LITTLE LEARNERS',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFE29578),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Row(
                    children: [
                      Text(
                        'JUST AT - ',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF006D77),
                        ),
                      ),
                      Text(
                        'MRP - ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF006D77),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        '1899/-',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF006D77),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Right Side Banners
            Positioned(
              right: MediaQuery.of(context).size.width * 0.05,
              top: screenHeight * 0.35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Transform.rotate(
                    angle: -0.05,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF006D77),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Pass Down ',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: 'Values,',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFE29578),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Transform.rotate(
                    angle: 0.02,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE29578),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Not Just ',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: 'Toys',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF006D77),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Shop Now Button
                  Container(
                    margin: const EdgeInsets.only(right: 40),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE29578),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                          side: const BorderSide(color: Colors.white, width: 3),
                        ),
                        elevation: 8,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'SHOP NOW',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.touch_app, color: Colors.white, size: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Bottom Pagination Dots
          Positioned(bottom: 20, left: 0, right: 0, child: _buildDots()),
        ],
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_carouselImages.length, (index) {
        bool isActive = index == _currentCarouselIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: isActive ? const EdgeInsets.all(4) : EdgeInsets.zero,
          decoration: isActive
              ? BoxDecoration(
                  border: Border.all(color: const Color(0xFF006D77), width: 1),
                  shape: BoxShape.rectangle,
                )
              : const BoxDecoration(),
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF006D77),
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTrustBadgesRow() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Wrap(
        spacing: 30,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _trustBadge(
            'https://cdn-icons-png.flaticon.com/512/3233/3233483.png',
            'Loved by 2 lac+ Customers',
          ),
          _trustBadge(
            'https://cdn-icons-png.flaticon.com/512/3069/3069188.png',
            'Made of Safe Plush Fabric',
          ),
          _trustBadge(
            'https://cdn-icons-png.flaticon.com/512/833/833472.png',
            'Handcrafted in India',
          ),
          _trustBadge(
            'https://cdn-icons-png.flaticon.com/512/3409/3409419.png',
            'Screen free play',
          ),
        ],
      ),
    );
  }

  Widget _trustBadge(String iconUrl, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(
          iconUrl,
          width: 32,
          height: 32,
          color: const Color(0xFF006D77),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF006D77),
          ),
        ),
      ],
    );
  }

  Widget _buildOurCollectionSection(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    Widget buildGridContent() {
      if (screenWidth > 900) {
        // Desktop Layout: Side-by-side (Left card + Right 2x2 grid)
        return SizedBox(
          height: 600,
          child: Row(
            children: [
              // Left big card
              Expanded(
                flex: 1,
                child: AnimatedCollectionCard(
                  title: 'Mantra Chanting Baby Ganesha',
                  backgroundColor: const Color(0xFFB2DFDB), // Pastel Mint
                  imageUrl:
                      'https://cdn-icons-png.flaticon.com/512/3082/3082008.png',
                  onTap: () {
                    Get.to(
                      () => const DivinePlushiesView(
                        categoryName: 'Divine Plushies',
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 20),
              // Right 2x2 grid
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: AnimatedCollectionCard(
                              title: 'Mantra Chanting Baby Krishna',
                              backgroundColor: const Color(0xFFBBDEFB),
                              imageUrl:
                                  'https://cdn-icons-png.flaticon.com/512/3094/3094833.png',
                              onTap: () => Get.to(
                                () => const DivinePlushiesView(
                                  categoryName: 'Divine Plushies',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: AnimatedCollectionCard(
                              title: 'Mantra Chanting Baby Hanuman',
                              backgroundColor: const Color(0xFFE1BEE7),
                              imageUrl:
                                  'https://cdn-icons-png.flaticon.com/512/2922/2922572.png',
                              onTap: () => Get.to(
                                () => const DivinePlushiesView(
                                  categoryName: 'Divine Plushies',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: AnimatedCollectionCard(
                              title: 'Mantra Chanting Baby Shiva',
                              backgroundColor: const Color(0xFFFFCCBC),
                              imageUrl:
                                  'https://cdn-icons-png.flaticon.com/512/3069/3069188.png',
                              onTap: () => Get.to(
                                () => const DivinePlushiesView(
                                  categoryName: 'Divine Plushies',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: AnimatedCollectionCard(
                              title: 'Mandir for Kids (DIY)',
                              backgroundColor: const Color(0xFFFFF9C4),
                              imageUrl:
                                  'https://cdn-icons-png.flaticon.com/512/3094/3094848.png',
                              onTap: () => Get.to(
                                () => const DivinePlushiesView(
                                  categoryName: 'Divine Plushies',
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
            ],
          ),
        );
      } else if (screenWidth > 600) {
        // Tablet Layout: Left card full width on top, Right 4 cards in a 2x2 grid below
        return Column(
          children: [
            SizedBox(
              height: 280,
              width: double.infinity,
              child: AnimatedCollectionCard(
                title: 'Mantra Chanting Baby Ganesha',
                backgroundColor: const Color(0xFFB2DFDB),
                imageUrl:
                    'https://cdn-icons-png.flaticon.com/512/3082/3082008.png',
                onTap: () {
                  Get.to(
                    () => const DivinePlushiesView(
                      categoryName: 'Divine Plushies',
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 220,
                    child: AnimatedCollectionCard(
                      title: 'Mantra Chanting Baby Krishna',
                      backgroundColor: const Color(0xFFBBDEFB),
                      imageUrl:
                          'https://cdn-icons-png.flaticon.com/512/3094/3094833.png',
                      onTap: () => Get.to(
                        () => const DivinePlushiesView(
                          categoryName: 'Divine Plushies',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 220,
                    child: AnimatedCollectionCard(
                      title: 'Mantra Chanting Baby Hanuman',
                      backgroundColor: const Color(0xFFE1BEE7),
                      imageUrl:
                          'https://cdn-icons-png.flaticon.com/512/2922/2922572.png',
                      onTap: () => Get.to(
                        () => const DivinePlushiesView(
                          categoryName: 'Divine Plushies',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 220,
                    child: AnimatedCollectionCard(
                      title: 'Mantra Chanting Baby Shiva',
                      backgroundColor: const Color(0xFFFFCCBC),
                      imageUrl:
                          'https://cdn-icons-png.flaticon.com/512/3069/3069188.png',
                      onTap: () => Get.to(
                        () => const DivinePlushiesView(
                          categoryName: 'Divine Plushies',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 220,
                    child: AnimatedCollectionCard(
                      title: 'Mandir for Kids (DIY)',
                      backgroundColor: const Color(0xFFFFF9C4),
                      imageUrl:
                          'https://cdn-icons-png.flaticon.com/512/3094/3094848.png',
                      onTap: () => Get.to(
                        () => const DivinePlushiesView(
                          categoryName: 'Divine Plushies',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      } else {
        // Mobile Layout: Stack all 5 cards vertically
        return Column(
          children: [
            SizedBox(
              height: 220,
              width: double.infinity,
              child: AnimatedCollectionCard(
                title: 'Mantra Chanting Baby Ganesha',
                backgroundColor: const Color(0xFFB2DFDB),
                imageUrl:
                    'https://cdn-icons-png.flaticon.com/512/3082/3082008.png',
                onTap: () {
                  Get.to(
                    () => const DivinePlushiesView(
                      categoryName: 'Divine Plushies',
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 220,
              width: double.infinity,
              child: AnimatedCollectionCard(
                title: 'Mantra Chanting Baby Krishna',
                backgroundColor: const Color(0xFFBBDEFB),
                imageUrl:
                    'https://cdn-icons-png.flaticon.com/512/3094/3094833.png',
                onTap: () => Get.to(
                  () =>
                      const DivinePlushiesView(categoryName: 'Divine Plushies'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 220,
              width: double.infinity,
              child: AnimatedCollectionCard(
                title: 'Mantra Chanting Baby Hanuman',
                backgroundColor: const Color(0xFFE1BEE7),
                imageUrl:
                    'https://cdn-icons-png.flaticon.com/512/2922/2922572.png',
                onTap: () => Get.to(
                  () =>
                      const DivinePlushiesView(categoryName: 'Divine Plushies'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 220,
              width: double.infinity,
              child: AnimatedCollectionCard(
                title: 'Mantra Chanting Baby Shiva',
                backgroundColor: const Color(0xFFFFCCBC),
                imageUrl:
                    'https://cdn-icons-png.flaticon.com/512/3069/3069188.png',
                onTap: () => Get.to(
                  () =>
                      const DivinePlushiesView(categoryName: 'Divine Plushies'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 220,
              width: double.infinity,
              child: AnimatedCollectionCard(
                title: 'Mandir for Kids (DIY)',
                backgroundColor: const Color(0xFFFFF9C4),
                imageUrl:
                    'https://cdn-icons-png.flaticon.com/512/3094/3094848.png',
                onTap: () => Get.to(
                  () =>
                      const DivinePlushiesView(categoryName: 'Divine Plushies'),
                ),
              ),
            ),
          ],
        );
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth > 600 ? 40 : 20),
      child: Column(
        children: [
          // Title
          Text(
            'Our Collection',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth > 600 ? 60 : 40,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF006D77),
              shadows: [
                Shadow(
                  offset: const Offset(2, 2),
                  color: const Color(0xFF006D77).withOpacity(0.3),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          SizedBox(height: screenWidth > 600 ? 40 : 20),
          buildGridContent(),
        ],
      ),
    );
  }

  Widget _buildBestSellersSection(BuildContext context) {
    return Column(
      children: [
        // Title Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(
              0xFF83C5BE,
            ).withOpacity(0.3), // Soft Sage/Mint pill
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            'Best Sellers',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Color(0xFF006D77), // Deep Teal text
            ),
          ),
        ),
        const SizedBox(height: 40),
        // YouTube Shorts Carousel
        SizedBox(
          height: 450,
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return _buildShortCard(index);
                }),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Pagination Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: index == 0 ? Colors.black : Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
        const SizedBox(height: 60),
        // Bottom Features Bar
        _buildFeaturesBar(context),
      ],
    );
  }

  Widget _buildShortCard(int index) {
    List<String> videoThumbnails = [
      'https://picsum.photos/400/800?random=1',
      'https://picsum.photos/400/800?random=2',
      'https://picsum.photos/400/800?random=3',
      'https://picsum.photos/400/800?random=4',
      'https://picsum.photos/400/800?random=5',
    ];

    List<String> titles = [
      'Mantra Chanting Baby Hanuman (Medium - 2...',
      'Mantra Chanting Baby Krishna (Small - 22 cm)',
      'Plush Mandir for Kids (Foldable & DIY - 53 cm...',
      'Mantra Chanting Baby Hanuman (Small - 22 c...',
      'Divine Play Mat for Toddlers',
    ];

    return Container(
      width: 280,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Thumbnail
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    videoThumbnails[index % 5],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                // Play Icon overlay mimicking YouTube Shorts
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Info Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Small overlay icon
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/3069/3069188.png',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titles[index % 5],
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xFF006D77),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Text(
                            '₹1,499',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '₹969',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesBar(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 768) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _featureIcon(
              'https://cdn-icons-png.flaticon.com/512/287/287226.png',
              'Gift Wrapping available',
            ),
            _featureIcon(
              'https://cdn-icons-png.flaticon.com/512/411/411763.png',
              'Express Shipping Available',
            ),
            _featureIcon(
              'https://cdn-icons-png.flaticon.com/512/1008/1008013.png',
              '7 Days Exchange/Return',
            ),
            _featureIcon(
              'https://cdn-icons-png.flaticon.com/512/679/679720.png',
              'COD Available',
            ),
          ],
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: [
            _mobileFeatureRow(
              'https://cdn-icons-png.flaticon.com/512/287/287226.png',
              'Gift Wrapping available',
            ),
            const SizedBox(height: 20),
            _mobileFeatureRow(
              'https://cdn-icons-png.flaticon.com/512/411/411763.png',
              'Express Shipping Available',
            ),
            const SizedBox(height: 20),
            _mobileFeatureRow(
              'https://cdn-icons-png.flaticon.com/512/1008/1008013.png',
              '7 Days Exchange/Return',
            ),
            const SizedBox(height: 20),
            _mobileFeatureRow(
              'https://cdn-icons-png.flaticon.com/512/679/679720.png',
              'COD Available',
            ),
          ],
        ),
      );
    }
  }

  Widget _mobileFeatureRow(String url, String text) {
    return Row(
      children: [
        Image.network(url, width: 36, height: 36),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _featureIcon(String url, String text) {
    return Expanded(
      child: Column(
        children: [
          Image.network(url, width: 48, height: 48),
          const SizedBox(height: 16),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoSection() {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      color: const Color(0xFFEDF6F9), // Scaffold background color
      padding: EdgeInsets.symmetric(
        vertical: screenWidth > 600 ? 60 : 30,
        horizontal: screenWidth > 900
            ? 100
            : screenWidth > 600
            ? 40
            : 20,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?q=80&w=1200&auto=format&fit=crop',
                  ), // Happy kid playing
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Dark gradient overlay top
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: screenWidth > 600 ? 100 : 60,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Top Left Info
                  Positioned(
                    top: screenWidth > 600 ? 20 : 12,
                    left: screenWidth > 600 ? 20 : 12,
                    right: screenWidth > 600 ? 20 : 12,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: screenWidth > 600 ? 20 : 12,
                          child: Padding(
                            padding: EdgeInsets.all(
                              screenWidth > 600 ? 4.0 : 2.0,
                            ),
                            child: Image.network(
                              'https://cdn-icons-png.flaticon.com/512/3069/3069188.png',
                              width: screenWidth > 600 ? 24 : 14,
                              height: screenWidth > 600 ? 24 : 14,
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth > 600 ? 12 : 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Raising Children Rooted in Values 💜 | Soulful Haven",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth > 600 ? 18 : 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Soulful Haven",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: screenWidth > 600 ? 14 : 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Play Button
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth > 600 ? 32 : 20,
                        vertical: screenWidth > 600 ? 20 : 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE29578), // Terracotta/Peach
                        borderRadius: BorderRadius.circular(
                          screenWidth > 600 ? 16 : 10,
                        ),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: screenWidth > 600 ? 48 : 32,
                      ),
                    ),
                  ),
                  // Bottom Right Watch on YouTube
                  Positioned(
                    bottom: screenWidth > 600 ? 20 : 12,
                    right: screenWidth > 600 ? 20 : 12,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth > 600 ? 16 : 10,
                        vertical: screenWidth > 600 ? 8 : 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Watch on ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: screenWidth > 600 ? 14 : 10,
                            ),
                          ),
                          Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: screenWidth > 600 ? 20 : 14,
                          ),
                          Text(
                            ' YouTube',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth > 600 ? 14 : 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceFiltersSection(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth > 800) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Cartoon Character Placeholder
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/2922/2922572.png', // Happy kid icon
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 60),
            // Price Bubbles
            _priceBubble('399'),
            const SizedBox(width: 40),
            _priceBubble('999'),
            const SizedBox(width: 40),
            _priceBubble('1599'),
          ],
        ),
      );
    } else {
      // Mobile Layout: Image on top, bubbles in a Wrap below
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        color: Colors.white,
        child: Column(
          children: [
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/2922/2922572.png', // Happy kid icon
              height: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _priceBubble('399'),
                _priceBubble('999'),
                _priceBubble('1599'),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget _priceBubble(String price) {
    return Container(
      width: 180,
      height: 180,
      decoration: const BoxDecoration(
        color: Color(0xFFEDF6F9), // Scaffold background color
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            const TextSpan(
              text: 'Under\n',
              style: TextStyle(
                color: Color(0xFF006D77),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: '₹$price/-',
              style: TextStyle(
                color: Color(0xFFE29578),
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParentingGuideSection(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final cards = [
      _buildGuideCard(
        imageUrl: 'https://picsum.photos/400/250?random=11',
        date: 'MAY 11, 2026',
        title: 'Why Do We Offer Water to the Sun?',
        snippet:
            'A Meaningful Ritual Explained for Kids. Many Indian families begin their mornings by offering...',
      ),
      _buildGuideCard(
        imageUrl: 'https://picsum.photos/400/250?random=12',
        date: 'APRIL 24, 2026',
        title:
            '10 Avatars of Vishnu Ji (Dashavatara) – Stories, Meaning & Why Kids Should Know...',
        snippet:
            'Introduction In Indian culture, Vishnu is known as the protector of the universe. Whenever imbalance rises...',
      ),
      _buildGuideCard(
        imageUrl: 'https://picsum.photos/400/250?random=13',
        date: 'APRIL 07, 2026',
        title:
            'Akshaya Tritiya 2026: Meaning, Significance & How to Celebrate with Kids',
        snippet:
            'Akshaya Tritiya, also known as Akha Teej, is one of the most auspicious days in...',
      ),
      _buildGuideCard(
        imageUrl: 'https://picsum.photos/400/250?random=14',
        date: 'MARCH 26, 2026',
        title:
            'Mahavir Jayanti for Kids: Teaching Kindness, Non-Violence & Values Through...',
        snippet:
            'Mahavir Jayanti for kids is more than just a festival — it\'s a beautiful opportunity...',
      ),
    ];

    Widget buildCardsLayout() {
      if (screenWidth > 1100) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: cards
              .map(
                (card) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: card,
                  ),
                ),
              )
              .toList(),
        );
      } else {
        // Horizontal scroll view for tablet and mobile
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: cards
                .map(
                  (card) => Container(
                    width: 280,
                    margin: const EdgeInsets.only(right: 20),
                    child: card,
                  ),
                )
                .toList(),
          ),
        );
      }
    }

    return Column(
      children: [
        // Title Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(
              0xFF83C5BE,
            ).withOpacity(0.3), // Soft Sage/Mint pill
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            'Parenting Guide',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Color(0xFF006D77), // Deep Teal text
            ),
          ),
        ),
        const SizedBox(height: 40),
        // Blog Cards Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: buildCardsLayout(),
        ),
      ],
    );
  }

  Widget _buildGuideCard({
    required String imageUrl,
    required String date,
    required String title,
    required String snippet,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEDF6F9), // Scaffold background color
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(imageUrl, height: 180, fit: BoxFit.cover),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  snippet,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF006D77,
                    ), // Deep Teal button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Read More',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
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

class AnimatedCollectionCard extends StatefulWidget {
  final String title;
  final Color backgroundColor;
  final String imageUrl;
  final VoidCallback? onTap;

  const AnimatedCollectionCard({
    Key? key,
    required this.title,
    required this.backgroundColor,
    required this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  State<AnimatedCollectionCard> createState() => _AnimatedCollectionCardState();
}

class _AnimatedCollectionCardState extends State<AnimatedCollectionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
          transformAlignment: Alignment.center,
          child: ClipPath(
            clipper: WavyClipper(),
            child: Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Image Placeholder
                  Positioned.fill(
                    top: 40,
                    bottom: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: AnimatedScale(
                        scale: _isHovered ? 1.15 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  // Pill Button
                  Positioned(
                    bottom: 20,
                    left: 16,
                    right: 16,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width > 900
                            ? 20
                            : 12,
                        vertical: MediaQuery.of(context).size.width > 900
                            ? 12
                            : 8,
                      ),
                      decoration: BoxDecoration(
                        color: _isHovered
                            ? const Color(0xFFE29578)
                            : const Color(0xFF006D77), // Terracotta on hover
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: MediaQuery.of(context).size.width > 900
                              ? 16
                              : 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double waveHeight = 15;
    path.lineTo(0, waveHeight);

    int waveCount = 8;
    double waveWidth = size.width / waveCount;

    for (int i = 0; i < waveCount; i++) {
      path.quadraticBezierTo(
        waveWidth * i + waveWidth / 2,
        0,
        waveWidth * (i + 1),
        waveHeight,
      );
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
