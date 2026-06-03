import 'package:flutter/material.dart';
import 'dart:ui';

class OriginPage extends StatefulWidget {
  const OriginPage({super.key});

  @override
  State<OriginPage> createState() => _OriginPageState();
}

class _OriginPageState extends State<OriginPage> {
  // Set index ke 1 agar tab "Learn" yang menyala di navbar
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFE9DB),

      // HEADER APP BAR (Sama dengan HomePage)
      appBar: AppBar(
        automaticallyImplyLeading: true, // Biar ada tombol back ke Home
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Tombol back jadi putih
        backgroundColor: const Color(0xFF2E6A3F),
        elevation: 0,
        centerTitle: false,
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
          // 1. Background Gradient Beige
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

          // 2. Konten Teks (Scrollable)
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                24,
                20,
                24,
                120,
              ), // Padding bawah dilebihkan agar tidak tertutup navbar
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul Halaman
                  const Text(
                    'The Origin of Baduy Culture',
                    style: TextStyle(
                      color: Color(0xFF2E6A3F),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Menjaga Titipan Leluhur di Jantung Banten.',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  const SizedBox(height: 25),

                  // Paragraf Pembuka
                  const Text(
                    'Suku Baduy, atau yang menyebut diri mereka Orang Kanekes, adalah kelompok masyarakat adat Sunda di wilayah Kabupaten Lebak, Banten. Sejarah mereka penuh dengan kemandirian.',
                    style: TextStyle(
                      color: Color(0xFF1B3022),
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Ada 2 teori populer mengenai asal-usul mereka:',
                    style: TextStyle(
                      color: Color(0xFF1B3022),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Teori 1
                  _buildSectionTitle('Teori Pelarian Kerajaan'),
                  _buildBodyText(
                    'Beberapa sejarawan menyebut bahwa mereka adalah keturunan punggawa Kerajaan Pajajaran yang mengasingkan diri ke pegunungan Kendeng pada abad ke-16 untuk mempertahankan kepercayaan asli mereka dari pengaruh luar.',
                  ),

                  const SizedBox(height: 20),

                  // Teori 2
                  _buildSectionTitle('Teori Penduduk Asli'),
                  _buildBodyText(
                    'Berdasarkan kepercayaan lokal, mereka adalah penduduk asli yang memang ditugaskan oleh leluhur untuk menjaga Archa Domas (tempat suci) dan memelihara keseimbangan alam di hulu sungai.',
                  ),

                  const SizedBox(height: 30),

                  // Bagian Pikukuh
                  const Text(
                    'Bagi mereka, hidup adalah tentang "Pikukuh", sebuah aturan adat yang mutlak.',
                    style: TextStyle(
                      color: Color(0xFF2E6A3F),
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 25),

                  // Kotak Prinsip (Quote)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E6A3F).withOpacity(0.05),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(0xFF2E6A3F).withOpacity(0.1),
                        ),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            '"Lojor teu meunang dipotong,\npondo teu meunang disambung"',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1B3022),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Artinya, hidup harus apa adanya sesuai kehendak alam.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF2E6A3F),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
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

          // 3. BOTTOM NAVIGATION BAR (Floating Glass)
          Positioned(bottom: 0, left: 0, right: 0, child: buildGlassNavBar()),
        ],
      ),
    );
  }

  // Helper Widget untuk Sub-Judul Materi
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF2E6A3F),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper Widget untuk Teks Materi
  Widget _buildBodyText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF1B3022),
        fontSize: 15,
        height: 1.5,
      ),
    );
  }

  // Bottom Nav Bar Kaca (Sama dengan HomePage tapi index Learn aktif)
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
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
        if (index == 0)
          Navigator.pop(context); // Kembali ke Home jika klik Home
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
