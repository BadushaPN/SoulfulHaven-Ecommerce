import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../widgets/shared_components.dart';

class AudioGalleryView extends StatefulWidget {
  const AudioGalleryView({super.key});

  @override
  State<AudioGalleryView> createState() => _AudioGalleryViewState();
}

class _AudioGalleryViewState extends State<AudioGalleryView> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  bool _showScrollToTop = false;

  // Audio Player State
  String? _currentTrackTitle;
  String? _currentTrackIcon;
  bool _isPlaying = false;
  double _progress = 0.0;
  int _currentTime = 0;
  final int _trackDuration = 120; // 2 minutes (120 seconds)
  Timer? _audioTimer;
  double _volume = 0.8;
  bool _isMuted = false;
  bool _isLooping = false;

  // Wave Visualizer Animation
  late AnimationController _waveController;
  final List<double> _waveHeights = [0.2, 0.5, 0.8, 0.4, 0.6, 0.9, 0.3, 0.7, 0.5, 0.8];

  final List<Map<String, String>> _audioTracks = [
    {
      'title': 'Devi Lakshmi Mantras',
      'icon': 'https://cdn-icons-png.flaticon.com/512/833/833472.png',
      'bg': '0xFFFFFDF8',
    },
    {
      'title': 'Jain Swami Mantras',
      'icon': 'https://cdn-icons-png.flaticon.com/512/2922/2922572.png',
      'bg': '0xFFFFFDF8',
    },
    {
      'title': 'Bharat Mata Audio',
      'icon': 'https://cdn-icons-png.flaticon.com/512/3233/3233483.png',
      'bg': '0xFFFFFDF8',
    },
    {
      'title': 'Gautam Buddha Mantras',
      'icon': 'https://cdn-icons-png.flaticon.com/512/3069/3069188.png',
      'bg': '0xFFFFFDF8',
    },
    {
      'title': 'Lord Shiv Mantras',
      'icon': 'https://cdn-icons-png.flaticon.com/512/3409/3409419.png',
      'bg': '0xFFFFFDF8',
    },
    {
      'title': 'Devi Saraswati Mantras',
      'icon': 'https://cdn-icons-png.flaticon.com/512/833/833472.png',
      'bg': '0xFFFFFDF8',
    },
    {
      'title': 'Lord Ganesh Mantras',
      'icon': 'https://cdn-icons-png.flaticon.com/512/3094/3094833.png',
      'bg': '0xFFFFFDF8',
    },
    {
      'title': 'Lord Krishna Mantras',
      'icon': 'https://cdn-icons-png.flaticon.com/512/3094/3094848.png',
      'bg': '0xFFFFFDF8',
    },
    {
      'title': 'Lord Hanuman Mantras',
      'icon': 'https://cdn-icons-png.flaticon.com/512/2922/2922572.png',
      'bg': '0xFFFFFDF8',
    },
    {
      'title': 'Lord Rama Mantras',
      'icon': 'https://cdn-icons-png.flaticon.com/512/3082/3082008.png',
      'bg': '0xFFFFFDF8',
    },
    {
      'title': 'Devi Durga Mantras',
      'icon': 'https://cdn-icons-png.flaticon.com/512/679/679720.png',
      'bg': '0xFFFFFDF8',
    },
    {
      'title': 'Vishnu Mantras',
      'icon': 'https://cdn-icons-png.flaticon.com/512/3069/3069188.png',
      'bg': '0xFFFFFDF8',
    },
    {
      'title': 'Little Sardarji',
      'icon': 'https://cdn-icons-png.flaticon.com/512/2922/2922572.png',
      'bg': '0xFFFFFDF8',
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

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _waveController.dispose();
    _audioTimer?.cancel();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _selectTrack(Map<String, String> track) {
    setState(() {
      _currentTrackTitle = track['title'];
      _currentTrackIcon = track['icon'];
      _isPlaying = true;
      _currentTime = 0;
      _progress = 0.0;
    });

    _startTimer();
    
    Get.snackbar(
      'Playing Mantra 🎵',
      'Now playing ${_currentTrackTitle}...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF4C4A70),
      colorText: Colors.white,
      margin: const EdgeInsets.all(20),
      duration: const Duration(seconds: 2),
    );
  }

  void _startTimer() {
    _audioTimer?.cancel();
    _audioTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPlaying) {
        setState(() {
          if (_currentTime < _trackDuration) {
            _currentTime++;
            _progress = _currentTime / _trackDuration;
          } else {
            if (_isLooping) {
              _currentTime = 0;
              _progress = 0.0;
            } else {
              _isPlaying = false;
              _audioTimer?.cancel();
            }
          }
        });
      }
    });
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _startTimer();
      } else {
        _audioTimer?.cancel();
      }
    });
  }

  void _seek(double value) {
    setState(() {
      _progress = value;
      _currentTime = (value * _trackDuration).round();
    });
  }

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, "0")}';
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
                const SizedBox(height: 80), // Sticky Navbar space
                _buildHeroBanner(context),
                
                const SizedBox(height: 40),
                
                // Centered Title
                Text(
                  'Audio Gallery',
                  style: GoogleFonts.outfit(
                    fontSize: isMobile ? 32 : 44,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF4C4A70), // Deep Purple/Indigo
                  ),
                ),
                
                // Grid section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 40),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = constraints.maxWidth > 1000 
                          ? 5 
                          : (constraints.maxWidth > 768 ? 3 : 2);
                      double childAspectRatio = constraints.maxWidth > 1000 
                          ? 0.9 
                          : (constraints.maxWidth > 768 ? 0.95 : 0.88);

                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _audioTracks.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 24,
                          crossAxisSpacing: 24,
                          childAspectRatio: childAspectRatio,
                        ),
                        itemBuilder: (context, index) {
                          var track = _audioTracks[index];
                          return _buildAudioCard(context, track);
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 120),
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

          Positioned(
            bottom: isMobile
                ? (_currentTrackTitle != null ? 200 : 94)
                : (_currentTrackTitle != null ? 140 : 30),
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
                child: Container(
                  width: isMobile ? 44 : 54,
                  height: isMobile ? 44 : 54,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD93D3D),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: const Color(0xFFFFD700), width: 2.5),
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

          Positioned(
            bottom: isMobile
                ? (_currentTrackTitle != null ? 200 : 94)
                : (_currentTrackTitle != null ? 140 : 30),
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_showScrollToTop) ...[
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: _scrollToTop,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD93D3D),
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
                        color: const Color(0xFFFFDD67),
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
                        'https://cdn-icons-png.flaticon.com/512/2654/2654518.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.pets, size: 24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Interactive Premium Audio Player Bar (Sticky at bottom)
          if (_currentTrackTitle != null)
            Positioned(
              bottom: isMobile ? 64 : 0, // Above bottom navbar on mobile, at bottom on web
              left: 0,
              right: 0,
              child: _buildAudioPlayerBar(screenWidth, isMobile),
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
      height: isMobile ? 180 : 340,
      decoration: const BoxDecoration(
        color: Color(0xFF4C5E48), // Meadow green grass fallback color
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1500382017468-9049fed747ef?q=80&w=1600'), // Meadow green grass
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Semi-transparent overlay to enhance text readability
          Container(color: Colors.black.withOpacity(0.15)),

          // Left side: child image playing in the grass
          if (screenWidth > 600)
            Positioned(
              left: isMobile ? 10 : 40,
              bottom: 0,
              child: Image.network(
                'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?q=80&w=300', // Toddler girl
                height: isMobile ? 140 : 280,
                width: isMobile ? 140 : 280,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
              ),
            ),

          // Right side: Krishna plushie + floating music notes
          if (screenWidth > 600)
            Positioned(
              right: isMobile ? 10 : 60,
              bottom: 10,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1582506307185-1d48c909e701?auto=format&fit=crop&q=80&w=300', // Krishna Plushie vibe
                    height: isMobile ? 130 : 250,
                    width: isMobile ? 130 : 250,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                  ),
                  // Floating music notes
                  Positioned(
                    top: -10,
                    left: -10,
                    child: Icon(Icons.music_note, color: Colors.pinkAccent.shade200, size: isMobile ? 24 : 40),
                  ),
                  Positioned(
                    top: 20,
                    right: -20,
                    child: Icon(Icons.music_note, color: Colors.greenAccent.shade400, size: isMobile ? 20 : 34),
                  ),
                  Positioned(
                    bottom: 40,
                    left: -24,
                    child: Icon(Icons.audiotrack, color: Colors.cyanAccent.shade200, size: isMobile ? 22 : 36),
                  ),
                ],
              ),
            ),

          // Center: Large yellow text "Listen to the Divine"
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Listen to the Divine',
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 28 : 58,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFFFFDD67), // Bold yellow color
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioCard(BuildContext context, Map<String, String> track) {
    final bool isSelected = _currentTrackTitle == track['title'];

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _selectTrack(track),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDF8), // Soft yellow/beige background tint
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected ? const Color(0xFF4C4A70) : Colors.grey.shade100,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected 
                    ? const Color(0xFF4C4A70).withOpacity(0.1) 
                    : Colors.black.withOpacity(0.02),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular white avatar with logo/illustration inside
              Container(
                width: 76,
                height: 76,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Image.network(
                  track['icon']!,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.music_note, color: Colors.grey, size: 30),
                ),
              ),
              const SizedBox(height: 16),
              // Mantra title text
              Text(
                track['title']!,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF4C4A70),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAudioPlayerBar(double screenWidth, bool isMobile) {
    return Container(
      height: isMobile ? 120 : 112,
      decoration: BoxDecoration(
        color: const Color(0xFF4C4A70), // Deep Purple/Indigo
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 24, vertical: 8),
      child: isMobile 
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top controls & metadata
                Row(
                  children: [
                    // Avatar icon
                    Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Image.network(
                        _currentTrackIcon!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.music_note, size: 14),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Metadata text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentTrackTitle!,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            _isPlaying ? 'Playing...' : 'Paused',
                            style: GoogleFonts.outfit(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Playing controls
                    IconButton(
                      icon: Icon(_isPlaying ? Icons.pause_circle : Icons.play_circle, color: Colors.white, size: 30),
                      onPressed: _togglePlayPause,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70, size: 20),
                      onPressed: () {
                        setState(() {
                          _currentTrackTitle = null;
                          _isPlaying = false;
                          _audioTimer?.cancel();
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                // Bottom timeline slider
                Row(
                  children: [
                    Text(
                      _formatTime(_currentTime),
                      style: GoogleFonts.outfit(color: Colors.white70, fontSize: 9),
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 2,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
                          activeTrackColor: const Color(0xFFFFDD67),
                          inactiveTrackColor: Colors.white24,
                          thumbColor: const Color(0xFFFFDD67),
                        ),
                        child: Slider(
                          value: _progress,
                          onChanged: _seek,
                        ),
                      ),
                    ),
                    Text(
                      _formatTime(_trackDuration),
                      style: GoogleFonts.outfit(color: Colors.white70, fontSize: 9),
                    ),
                  ],
                ),
              ],
            )
          : Row(
              children: [
                // 1. Metadata
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Image.network(
                    _currentTrackIcon!,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.music_note, size: 18),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentTrackTitle!,
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        _isPlaying ? 'Playing...' : 'Paused',
                        style: GoogleFonts.outfit(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // 2. Center controls & Timeline slider
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            _isLooping ? Icons.repeat_one : Icons.repeat,
                            color: _isLooping ? const Color(0xFFFFDD67) : Colors.white70,
                            size: 18,
                          ),
                          onPressed: () {
                            setState(() {
                              _isLooping = !_isLooping;
                            });
                          },
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(6),
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_previous, color: Colors.white, size: 24),
                          onPressed: () {
                            setState(() {
                              _currentTime = 0;
                              _progress = 0.0;
                            });
                          },
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(6),
                        ),
                        IconButton(
                          icon: Icon(
                            _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                            color: const Color(0xFFFFDD67),
                            size: 38,
                          ),
                          onPressed: _togglePlayPause,
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_next, color: Colors.white, size: 24),
                          onPressed: () {
                            setState(() {
                              _currentTime = _trackDuration;
                              _progress = 1.0;
                            });
                          },
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(6),
                        ),
                        // Animated music wave visualizer
                        const SizedBox(width: 12),
                        _buildAnimatedWave(),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          _formatTime(_currentTime),
                          style: GoogleFonts.outfit(color: Colors.white70, fontSize: 10),
                        ),
                        SizedBox(
                          width: 400,
                          child: SliderTheme(
                            data: SliderThemeData(
                              trackHeight: 3,
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                              activeTrackColor: const Color(0xFFFFDD67),
                              inactiveTrackColor: Colors.white24,
                              thumbColor: const Color(0xFFFFDD67),
                            ),
                            child: Slider(
                              value: _progress,
                              onChanged: _seek,
                            ),
                          ),
                        ),
                        Text(
                          _formatTime(_trackDuration),
                          style: GoogleFonts.outfit(color: Colors.white70, fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

                // 3. Right Volume & Close button
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        _isMuted || _volume == 0
                            ? Icons.volume_off
                            : (_volume < 0.4 ? Icons.volume_down : Icons.volume_up),
                        color: Colors.white70,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isMuted = !_isMuted;
                        });
                      },
                    ),
                    SizedBox(
                      width: 80,
                      child: SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 2,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: Colors.white24,
                          thumbColor: Colors.white,
                        ),
                        child: Slider(
                          value: _isMuted ? 0.0 : _volume,
                          onChanged: (val) {
                            setState(() {
                              _volume = val;
                              _isMuted = val == 0.0;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70, size: 22),
                      onPressed: () {
                        setState(() {
                          _currentTrackTitle = null;
                          _isPlaying = false;
                          _audioTimer?.cancel();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildAnimatedWave() {
    return SizedBox(
      height: 20,
      width: 40,
      child: AnimatedBuilder(
        animation: _waveController,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(_waveHeights.length, (index) {
              double multiplier = _isPlaying ? _waveController.value : 0.15;
              double height = 2 + (16 * _waveHeights[index] * multiplier);
              return Container(
                width: 2,
                height: height,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDD67),
                  borderRadius: BorderRadius.circular(1),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
