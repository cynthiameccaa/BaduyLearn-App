import 'package:flutter/material.dart';
import 'dart:ui';
import 'quiz_page.dart';

class QuickLearnPage extends StatefulWidget {
  const QuickLearnPage({super.key});

  @override
  State<QuickLearnPage> createState() => _QuickLearnPageState();
}

class _QuickLearnPageState extends State<QuickLearnPage> {
  // Index 1 agar tab "Learn" tetap menyala hijau di navbar
  final int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9F5), // Fallback warna light terang
      // HEADER APP BAR (Konsisten Hijau Tua dengan Tulisan Putih)
      appBar: AppBar(
        automaticallyImplyLeading: true, // Memunculkan tombol panah back
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF2E6A3F),
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
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
        ],
      ),

      body: Stack(
        children: [
          // 1. BACKGROUND: Gradasi Beige / Cokelat Muda Estetik
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFEFE9DB), // Beige hangat agak pekat di atas
                    Color(0xFFF7F4EB), // Soft beige terang di tengah
                    Color(0xFFFCFAF5), // Putih gading hangat di bawah
                  ],
                ),
              ),
            ),
          ),

          // 2. KONTEN KARTU BUDAYA (Scrollable)
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                120,
              ), // Jarak bawah ekstra agar aman dari navbar
              child: Column(
                children: [
                  // CARD 1: RUMAH ADAT
                  _buildCultureCard(
                    imageAsset: 'assets/images/rumah_adat.png',
                    title: 'Rumah Adat',
                    subtitle: 'Sulah Nyanda',
                    description:
                        'Rumah yang seluruhnya berbahan kayu, bambu, dan atap rumbia. Dibuat tanpa paku dan tanpa meratakan tanah. Jika tanah miring, tiang rumahnya yang menyesuaikan tingginya.',
                    onTap: () {
                      // Tambahkan aksi navigasi atau aksi lainnya di sini jika diperlukan
                    },
                  ),
                  const SizedBox(height: 24),

                  // CARD 2: PAKAIAN ADAT
                  _buildCultureCard(
                    imageAsset: 'assets/images/pakaian_adat.png',
                    title: 'Pakaian Adat',
                    subtitle: 'Baduy Luar dan Baduy Dalam',
                    customContent: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSubTopic(
                          'Baduy Dalam',
                          'Mengenai pakaian pakaian putih bersih dan ikat kepala putih. Melambangkan pikiran yang suci dan belum terpengaruh dunia luar.',
                        ),
                        const SizedBox(height: 12),
                        _buildSubTopic(
                          'Baduy Luar',
                          'Menggunakan pakaian berwarna hitam atau biru tua (sering disebut baju kampret) dan ikat kepala biru motif batik.',
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),

                  // CARD 3: MAKANAN DAN KESEHARIAN
                  _buildCultureCard(
                    imageAsset: 'assets/images/makanan.png',
                    title: 'Makanan dan Keseharian',
                    subtitle: 'Rasa Autentik dari Alam Liar',
                    description:
                        'Masyarakat Baduy sangat mandiri. Mereka makan dari hasil Huma (ladang padi kering). Makanan khas mereka sangat natural seperti jagung bakar, umbi-umbian, dan madu hutan yang sangat terkenal kualitasnya.',
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),

                  // CARD 4: KESENIAN
                  _buildCultureCard(
                    imageAsset: 'assets/images/angklung.png',
                    title: 'Kesenian',
                    subtitle: 'Angklung Buhun',
                    description:
                        'Angklung Buhun adalah kesenian musik tertua dan paling sakral bagi masyarakat Baduy. Kata "Buhun" berarti tua atau kuno. Instrumen ini hanya dimainkan pada saat ritual penting, terutama saat upacara Ngaseuk (menanam padi), sebagai bentuk penghormatan kepada Dewi Sri (Dewi Padi) agar hasil panen melimpah.',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // 3. BOTTOM NAVIGATION BAR (Floating Glass)
          Positioned(bottom: 0, left: 0, right: 0, child: buildGlassNavBar()),
        ],
      ),
    );
  }

  // Helper Widget untuk Membuat Card dengan State Hover Internal Terpisah
  Widget _buildCultureCard({
    required String imageAsset,
    required String title,
    required String subtitle,
    String? description,
    Widget? customContent,
    required VoidCallback onTap,
  }) {
    // Menggunakan StatefulBuilder agar state hover per card bersifat independen (tidak tercampur)
    bool isHovered = false;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setCardState) {
        return MouseRegion(
          onEnter: (_) =>
              setCardState(() => isHovered = true), // Kursor masuk card
          onExit: (_) =>
              setCardState(() => isHovered = false), // Kursor keluar card
          cursor:
              SystemMouseCursors.click, // Mengubah kursor jadi pointer/tangan
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              // Transform: card bergeser naik sedikit (-6px) saat di-hover mouse
              transform: isHovered
                  ? (Matrix4.identity()..translate(0, -6, 0))
                  : Matrix4.identity(),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(24),
                // Border berubah menjadi hijau tema Baduy saat disorot kursor
                border: Border.all(
                  color: isHovered
                      ? const Color(0xFF2E6A3F).withOpacity(0.8)
                      : Colors.white.withOpacity(0.6),
                  width: isHovered ? 1.8 : 1.0,
                ),
                // Efek bayangan (shadow) menebal dan meluas saat di-hover
                boxShadow: [
                  BoxShadow(
                    color: isHovered
                        ? const Color(0xFF2E6A3F).withOpacity(0.12)
                        : Colors.black.withOpacity(0.03),
                    blurRadius: isHovered ? 20 : 12,
                    offset: isHovered ? const Offset(0, 8) : const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sisi Atas: Gambar dengan teks overlay judul
                    AspectRatio(
                      aspectRatio: 16 / 10,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              imageAsset,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(0xFFEFE9DB),
                                  child: const Center(
                                    child: Icon(
                                      Icons.image_not_supported_outlined,
                                      color: Colors.black38,
                                      size: 40,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          // Gradasi gelap di bawah foto
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            right: 20,
                            left: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  subtitle,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Sisi Bawah: Panel Kaca Putih Terang berisi deskripsi teks
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      color: Colors.white.withOpacity(0.55),
                      child:
                          customContent ??
                          Text(
                            description ?? '',
                            style: const TextStyle(
                              color: Color(0xFF1B3022),
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Helper Khusus untuk Detail Pakaian Adat
  Widget _buildSubTopic(String title, String desc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF2E6A3F),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          desc,
          style: const TextStyle(
            color: Color(0xFF1B3022),
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // Floating Glass Navbar (Senada dengan HomePage, tab Learn aktif)
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
                _navItem(Icons.home_outlined, 'Home', 0),
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
        if (index == 0) {
          Navigator.pop(context); // Kembali ke Home
        } else if (index == 2) {
          if (_currentIndex != 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QuizPage()),
            );
          }
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
