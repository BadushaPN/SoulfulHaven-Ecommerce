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

    return Scaffold(
      backgroundColor: const Color(0xFFF4F9F9), // Light minty background
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
                _buildBestSellersSection(),
                _buildVideoSection(),
                _buildPriceFiltersSection(),
                const SizedBox(height: 60),
                _buildParentingGuideSection(),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF009688), // Teal
        elevation: 4,
        shape: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            'https://cdn-icons-png.flaticon.com/512/3069/3069188.png', // Floral logo placeholder
            fit: BoxFit.contain,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildNavbar(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: _isScrolled
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
          Row(
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

  Widget _buildHeroSection(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height - 80; // Minus navbar
    if (screenHeight < 600) screenHeight = 600;

    return Container(
      width: double.infinity,
      height: screenHeight,
      decoration: const BoxDecoration(color: Color(0xFFF4F9F9)),
      child: Stack(
        children: [
          // Background Carousel
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentCarouselIndex = index),
              itemCount: _carouselImages.length,
              itemBuilder: (context, index) {
                return Image.network(
                  _carouselImages[index],
                  fit: BoxFit.cover,
                  color: const Color(0xFF009688).withOpacity(0.1),
                  colorBlendMode: BlendMode.srcOver,
                );
              },
            ),
          ),
          
          // Text Overlays
          Positioned(
            left: MediaQuery.of(context).size.width * 0.05,
            top: screenHeight * 0.25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Introducing My First Book of',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF004D40), letterSpacing: 1.2),
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
                          ..color = const Color(0xFF009688).withOpacity(0.6),
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      'MANTRAS',
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF009688).withOpacity(0.1),
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'A BEAUTIFULLY ILLUSTRATED MUSICAL\nMANTRA BOOK FOR LITTLE LEARNERS',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFFFF6B6B), height: 1.5),
                ),
                const SizedBox(height: 40),
                const Row(
                  children: [
                    Text('JUST AT - ', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF004D40))),
                    Text('MRP - ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF004D40), decoration: TextDecoration.lineThrough)),
                    Text('1899/-', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF004D40))),
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
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    decoration: BoxDecoration(color: const Color(0xFF009688), borderRadius: BorderRadius.circular(40)),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(text: 'Pass Down ', style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900, color: Colors.white)),
                          TextSpan(text: 'Values,', style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900, color: Color(0xFFFF6B6B))),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Transform.rotate(
                  angle: 0.02,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    decoration: BoxDecoration(color: const Color(0xFFFF6B6B), borderRadius: BorderRadius.circular(40)),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(text: 'Not Just ', style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900, color: Colors.white)),
                          TextSpan(text: 'Toys', style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900, color: Color(0xFF004D40))),
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
                      backgroundColor: const Color(0xFFFF6B6B),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: const BorderSide(color: Colors.white, width: 3),
                      ),
                      elevation: 8,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('SHOP NOW', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1.5)),
                        SizedBox(width: 10),
                        Icon(Icons.touch_app, color: Colors.white, size: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Pagination Dots
          Positioned(bottom: 20, left: 0, right: 0, child: _buildDots()),
          
          // Left bottom coin icon
          Positioned(
            bottom: 40,
            left: 20,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B6B),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF009688), width: 3),
              ),
              child: const Center(
                child: Text('₹', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
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
              ? BoxDecoration(border: Border.all(color: const Color(0xFF004D40), width: 1), shape: BoxShape.rectangle)
              : const BoxDecoration(),
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(color: Color(0xFF004D40), shape: BoxShape.circle),
          ),
        );
      }),
    );
  }

  Widget _buildTrustBadgesRow() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _trustBadge('https://cdn-icons-png.flaticon.com/512/3233/3233483.png', 'Loved by 2 lac+ Customers'),
          _trustBadge('https://cdn-icons-png.flaticon.com/512/3069/3069188.png', 'Made of Safe Plush Fabric'),
          _trustBadge('https://cdn-icons-png.flaticon.com/512/833/833472.png', 'Handcrafted in India'),
          _trustBadge('https://cdn-icons-png.flaticon.com/512/3409/3409419.png', 'Screen free play'),
        ],
      ),
    );
  }

  Widget _trustBadge(String iconUrl, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(iconUrl, width: 32, height: 32, color: const Color(0xFF009688)),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF004D40)),
        ),
      ],
    );
  }

  Widget _buildOurCollectionSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          // Title
          Text(
            'Our Collection',
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF004D40),
              shadows: [
                Shadow(offset: const Offset(2, 2), color: const Color(0xFF009688).withOpacity(0.3), blurRadius: 2),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Grid
          SizedBox(
            height: 600,
            child: Row(
              children: [
                // Left big card
                Expanded(
                  flex: 1,
                  child: AnimatedCollectionCard(
                    title: 'Mantra Chanting Baby Ganesha',
                    backgroundColor: const Color(0xFFB2DFDB), // Pastel Mint
                    imageUrl: 'https://cdn-icons-png.flaticon.com/512/3082/3082008.png',
                    onTap: () {
                      Get.to(() => const DivinePlushiesView(categoryName: 'Divine Plushies'));
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
                            Expanded(child: AnimatedCollectionCard(
                              title: 'Mantra Chanting Baby Krishna',
                              backgroundColor: const Color(0xFFBBDEFB),
                              imageUrl: 'https://cdn-icons-png.flaticon.com/512/3094/3094833.png',
                              onTap: () => Get.to(() => const DivinePlushiesView(categoryName: 'Divine Plushies')),
                            )),
                            const SizedBox(width: 20),
                            Expanded(child: AnimatedCollectionCard(
                              title: 'Mantra Chanting Baby Hanuman',
                              backgroundColor: const Color(0xFFE1BEE7),
                              imageUrl: 'https://cdn-icons-png.flaticon.com/512/2922/2922572.png',
                              onTap: () => Get.to(() => const DivinePlushiesView(categoryName: 'Divine Plushies')),
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(child: AnimatedCollectionCard(
                              title: 'Mantra Chanting Baby Shiva',
                              backgroundColor: const Color(0xFFFFCCBC),
                              imageUrl: 'https://cdn-icons-png.flaticon.com/512/3069/3069188.png',
                              onTap: () => Get.to(() => const DivinePlushiesView(categoryName: 'Divine Plushies')),
                            )),
                            const SizedBox(width: 20),
                            Expanded(child: AnimatedCollectionCard(
                              title: 'Mandir for Kids (DIY)',
                              backgroundColor: const Color(0xFFFFF9C4),
                              imageUrl: 'https://cdn-icons-png.flaticon.com/512/3094/3094848.png',
                              onTap: () => Get.to(() => const DivinePlushiesView(categoryName: 'Divine Plushies')),
                            )),
                          ],
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
  }

  Widget _buildBestSellersSection() {
    return Column(
      children: [
        // Title Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFCCBC), // Peach/yellow pill
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            'Best Sellers',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Color(0xFFD32F2F), // Red text
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
        _buildFeaturesBar(),
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
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Thumbnail
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
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
                    child: const Icon(Icons.play_arrow, color: Colors.white, size: 32),
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
                    child: Image.network('https://cdn-icons-png.flaticon.com/512/3069/3069188.png'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titles[index % 5],
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF004D40)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Text('₹1,499', style: TextStyle(fontSize: 12, color: Colors.grey, decoration: TextDecoration.lineThrough)),
                          SizedBox(width: 8),
                          Text('₹969', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
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

  Widget _buildFeaturesBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _featureIcon('https://cdn-icons-png.flaticon.com/512/287/287226.png', 'Gift Wrapping available'),
          _featureIcon('https://cdn-icons-png.flaticon.com/512/411/411763.png', 'Express Shipping Available'),
          _featureIcon('https://cdn-icons-png.flaticon.com/512/1008/1008013.png', '7 Days Exchange/Return'),
          _featureIcon('https://cdn-icons-png.flaticon.com/512/679/679720.png', 'COD Available'),
        ],
      ),
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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoSection() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFDF5E6), // Cream background matching the image
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 100),
      child: Center(
        child: Container(
          width: 1000,
          height: 562, // 16:9 aspect ratio approx
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))],
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?q=80&w=1200&auto=format&fit=crop'), // Happy kid playing
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // Dark gradient overlay top
              Positioned(
                top: 0, left: 0, right: 0,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                    ),
                  ),
                ),
              ),
              // Top Left Info
              Positioned(
                top: 20, left: 20,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.network('https://cdn-icons-png.flaticon.com/512/3069/3069188.png', width: 24, height: 24),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Raising Children Rooted in Values 💜 | Soulful Haven", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("Soulful Haven", style: TextStyle(color: Colors.white70, fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
              // Play Button
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(16)),
                  child: const Icon(Icons.play_arrow, color: Colors.white, size: 48),
                ),
              ),
              // Bottom Right Watch on YouTube
              Positioned(
                bottom: 20, right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(20)),
                  child: const Row(
                    children: [
                      Text('Watch on ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                      Icon(Icons.play_circle_fill, color: Colors.white, size: 20),
                      Text(' YouTube', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceFiltersSection() {
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
  }

  Widget _priceBubble(String price) {
    return Container(
      width: 180,
      height: 180,
      decoration: const BoxDecoration(
        color: Color(0xFFFFF9EC), // Light cream
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            const TextSpan(text: 'Under\n', style: TextStyle(color: Color(0xFFD32F2F), fontSize: 24, fontWeight: FontWeight.bold)),
            TextSpan(text: '₹$price/-', style: TextStyle(color: Color(0xFFFBC02D), fontSize: 32, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }

  Widget _buildParentingGuideSection() {
    return Column(
      children: [
        // Title Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFCCBC), // Peach/yellow pill
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            'Parenting Guide',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Color(0xFFD32F2F), // Red text
            ),
          ),
        ),
        const SizedBox(height: 40),
        // Blog Cards Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildGuideCard(
                imageUrl: 'https://picsum.photos/400/250?random=11',
                date: 'MAY 11, 2026',
                title: 'Why Do We Offer Water to the Sun?',
                snippet: 'A Meaningful Ritual Explained for Kids. Many Indian families begin their mornings by offering...',
              ),
              const SizedBox(width: 20),
              _buildGuideCard(
                imageUrl: 'https://picsum.photos/400/250?random=12',
                date: 'APRIL 24, 2026',
                title: '10 Avatars of Vishnu Ji (Dashavatara) – Stories, Meaning & Why Kids Should Know...',
                snippet: 'Introduction In Indian culture, Vishnu is known as the protector of the universe. Whenever imbalance rises...',
              ),
              const SizedBox(width: 20),
              _buildGuideCard(
                imageUrl: 'https://picsum.photos/400/250?random=13',
                date: 'APRIL 07, 2026',
                title: 'Akshaya Tritiya 2026: Meaning, Significance & How to Celebrate with Kids',
                snippet: 'Akshaya Tritiya, also known as Akha Teej, is one of the most auspicious days in...',
              ),
              const SizedBox(width: 20),
              _buildGuideCard(
                imageUrl: 'https://picsum.photos/400/250?random=14',
                date: 'MARCH 26, 2026',
                title: 'Mahavir Jayanti for Kids: Teaching Kindness, Non-Violence & Values Through...',
                snippet: 'Mahavir Jayanti for kids is more than just a festival — it\'s a beautiful opportunity...',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGuideCard({required String imageUrl, required String date, required String title, required String snippet}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFF9EC), // Light cream card background
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                imageUrl,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(date, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
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
                      backgroundColor: const Color(0xFFD32F2F), // Red button
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Read More', style: TextStyle(color: Colors.white, fontSize: 14)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_circle_right_outlined, color: Colors.white, size: 16),
                      ],
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

  Widget _buildFooterSection() {
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
                      child: Image.network(widget.imageUrl, fit: BoxFit.contain),
                    ),
                  ),
                ),
                // Pill Button
                Positioned(
                  bottom: 20,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: _isHovered ? const Color(0xFFFF6B6B) : const Color(0xFF009688), // Coral on hover
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                    ),
                    child: Text(
                      widget.title,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18),
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
        waveWidth * i + waveWidth / 2, 0,
        waveWidth * (i + 1), waveHeight,
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
