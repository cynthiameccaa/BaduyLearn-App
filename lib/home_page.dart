import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'origin_page.dart';
import 'quick_learn.dart';
import 'quiz_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  final String? username;
  final String? email;
  final String? password;

  const HomePage({super.key, this.username, this.email, this.password});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // 🌟 State untuk mencatat index elemen mana yang sedang di-hover mouse
  int _hoveredIndex = -1; // -1 berarti tidak ada yang di-hover

  // 🌟 CAROUSEL UTILITIES: Variabel pengontrol otomatisasi gerak kartu
  late PageController _pageController;
  Timer? _carouselTimer;
  int _currentPage = 0;

  // 🌟 DATA CAROUSEL: Teks dan Gambar Background dinamis per slide
  final List<Map<String, String>> _funFacts = [
    {
      'title': 'Tanpa Alas Kaki, Tetap Tangguh!',
      'desc':
          'Warga Baduy Dalam sanggup berjalan kaki puluhan kilometer dari desa mereka di Lebak sampai ke Jakarta tanpa alas kaki. Bagi mereka, menyentuh tanah secara langsung adalah bentuk koneksi dengan alam.',
      'image':
          'assets/images/newfun_fact.png', // Gambar slide 1 (pake yang lama/utama)
    },
    {
      'title': 'Baduy Luar si "Saringan" Adat',
      'desc':
          'Wilayah Baduy Luar sengaja mengitari Baduy Dalam. Mereka bertugas sebagai benteng sekaligus penyaring (filter) budaya modern agar adat di Baduy Dalam tetap terjaga kesuciannya.',
      'image': 'assets/images/funfact_3.png', // Gambar slide 2
    },
    {
      'title': 'Ponsel Boleh, Listrik No!',
      'desc':
          'Sebagian warga Baduy Luar memakai ponsel buat bisnis online madu dan kain tenun. Tapi karena desa mereka dilarang pasang listrik, mereka harus numpang ngecas HP di desa luar adat!',
      'image': 'assets/images/funfact_2.png', // Gambar slide 3
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    // 🌟 TIMER SETUP: Bergeser otomatis setiap 4 detik secara halus
    _carouselTimer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < _funFacts.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // Mengulang kembali ke kartu pertama
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    // 🌟 MEMORY CLEANUP: Menghapus timer & controller saat pindah page demi performa HP
    _carouselTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String displayName = widget.username ?? 'Explorer';

    return Scaffold(
      backgroundColor: const Color(0xFFF4F9F5),

      // ================= FIXED STICKY HEADER APP BAR =================
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF2E6A3F),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'BaduyLearn',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      username: displayName,
                      email: widget.email ?? 'belum_diatur@email.com',
                      password: widget.password ?? '******',
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white.withOpacity(0.15),
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // ======================= BODY =======================
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFEFE9DB),
                    Color(0xFFF7F4EB),
                    Color(0xFFFCFAF5),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  // WELCOME TEXT
                  Text(
                    'Hello, $displayName!',
                    style: const TextStyle(
                      color: Color(0xFF1B3022),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Let’s continue your journey into the heart of Baduy culture today.",
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  const SizedBox(height: 28),

                  // 🌟 1. CARD: THE ORIGIN OF BADUY CULTURE
                  _buildHoverWrapper(
                    index: 0,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OriginPage(),
                        ),
                      );
                    },
                    child: Center(
                      child: Container(
                        width: 331,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF2E6A3F),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                'assets/images/baduy_culture.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.1),
                                      Colors.black.withOpacity(0.75),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFF2E6A3F,
                                      ).withOpacity(0.85),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'history',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  const Text(
                                    'The Origin of Baduy Culture',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Menjaga Titipan Leluhur di Jantung Banten.',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.85),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 🌟 2. CARD: QUICK LEARN
                  _buildHoverWrapper(
                    index: 1,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuickLearnPage(),
                        ),
                      );
                    },
                    child: buildGlassCard(
                      height: 110,
                      child: Row(
                        children: [
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Quick Learn',
                                    style: TextStyle(
                                      color: Color(0xFF1B3022),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Pahami esensi budaya Baduy dalam sekali lirik.',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'assets/images/quick_learn.jpg',
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 🌟 3. CARD: QUIZ TIME
                  _buildHoverWrapper(
                    index: 2,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizPage(),
                        ),
                      );
                    },
                    child: buildGlassCard(
                      height: 90,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Quiz Time!',
                                  style: TextStyle(
                                    color: Color(0xFF1B3022),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Yuk, uji sejauh mana pengetahuanmu!',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF2E6A3F).withOpacity(0.1),
                              ),
                              child: const Icon(
                                Icons.help_outline_rounded,
                                color: Color(0xFF2E6A3F),
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 🌟 4. CARD: FUN FACT (Gambar & Teks Dinamis Ikut Slide)
                  _buildHoverWrapper(
                    index: 3,
                    onTap: () {
                      print('Pindah ke Halaman: Fun Fact Detail');
                    },
                    child: Container(
                      width: double.infinity,
                      height: 175,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // Menggunakan PageView.builder langsung di level terluar Stack
                      // Supaya saat di-swipe, gambarnya ikut tergeser (transisi halus)
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          _currentPage = index;
                        },
                        itemCount: _funFacts.length,
                        itemBuilder: (context, idx) {
                          return Stack(
                            children: [
                              // 🌟 Gambar dinamis per slide diambil dari map list
                              Positioned.fill(
                                child: Image.asset(
                                  _funFacts[idx]['image']!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Efek Gradien Gelap di atas Gambar
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.15),
                                        Colors.black.withOpacity(0.85),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Teks Konten Khusus Slide Ini
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'Fun Fact!',
                                      style: TextStyle(
                                        color: Color(0xFFE4F0A5),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _funFacts[idx]['title']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      _funFacts[idx]['desc']!,
                                      softWrap: true,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 12,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // BOTTOM NAVIGATION BAR (Floating)
          Positioned(bottom: 0, left: 0, right: 0, child: buildGlassNavBar()),
        ],
      ),
    );
  }

  // HELPER METHOD: Efek Hover & Glow
  Widget _buildHoverWrapper({
    required int index,
    required VoidCallback onTap,
    required Widget child,
  }) {
    final bool isHovered = _hoveredIndex == index;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = -1),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transform: isHovered
              ? (Matrix4.identity()..scale(1.025))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: isHovered
                    ? const Color(0xFF2E6A3F).withOpacity(0.35)
                    : Colors.black.withOpacity(0.02),
                blurRadius: isHovered ? 16 : 10,
                spreadRadius: isHovered ? 2 : 0,
                offset: isHovered ? const Offset(0, 6) : const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  // Efek Glass Card
  Widget buildGlassCard({required double height, required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.6)),
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }

  // Bottom Nav Bar Kaca Melayang
  Widget buildGlassNavBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      height: 68,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2E6A3F).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _navItem(Icons.home_filled, 'Home', 0),
                _navItem(Icons.menu_book_rounded, 'Learn', 1),
                _navItem(Icons.stars_rounded, 'Quiz', 2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final bool isActive = _currentIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QuickLearnPage()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QuizPage()),
          );
        }
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive
                  ? const Color(0xFF2E6A3F)
                  : const Color(0xFF2E6A3F).withOpacity(0.4),
              size: 26,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? const Color(0xFF2E6A3F)
                    : const Color(0xFF2E6A3F).withOpacity(0.4),
                fontSize: 11,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
