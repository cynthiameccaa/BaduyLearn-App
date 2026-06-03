import 'package:baduylearn/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'quick_learn.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final int _currentIndex = 2; // Index aktif untuk tab "Quiz"

  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex; // Menyimpan jawaban pilihan user
  bool _isAnswered = false; // Menandai apakah soal sudah dijawab atau belum

  // Variabel untuk menghitung poin/skor
  int _totalScore = 0;
  bool _isQuizFinished = false; // Flag untuk menandai kuis sudah selesai

  // ✅ Ambil data user yang sedang login di Firebase
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  final List<Map<String, dynamic>> _questions = [
    {
      'question':
          'Apa prinsip hidup utama masyarakat Baduy yang berarti hidup harus apa adanya sesuai kehendak alam?',
      'options': ['Urbanisasi', 'Pikukuh', 'Modernisasi', 'Industrialisasi'],
      'correctIndex': 1,
      'explanations': [
        'Urbanisasi adalah perpindahan penduduk ke kota, bertolak belakang dengan prinsip hidup selaras alam.',
        'Benar! Pikukuh adalah ajaran adat mutlak untuk hidup apa adanya tanpa mengubah tatanan alam.',
        'Modernisasi mengacu pada adopsi teknologi baru yang justru sangat dihindari oleh adat Baduy.',
        'Industrialisasi melibatkan pembangunan pabrik dan mesin yang dilarang dalam hukum adat mereka.',
      ],
    },
    {
      'question':
          'Masyarakat Suku Baduy sering juga menyebut diri mereka sebagai kelompok masyarakat adat...',
      'options': [
        'Orang Kanekes',
        'Orang Pajajaran',
        'Orang Kendeng',
        'Orang Banten',
      ],
      'correctIndex': 0,
      'explanations': [
        'Benar! Secara lokal, masyarakat Baduy lebih sering menyebut identitas kelompok mereka sebagai Orang Kanekes sesuai wilayahnya.',
        'Orang Pajajaran merujuk pada asal usul sejarah kerajaan mereka, bukan sebutan sehari-hari kelompok adatnya.',
        'Gunung Kendeng adalah nama pegunungan tempat mereka tinggal, namun bukan nama resmi kelompok adat mereka.',
        'Orang Banten adalah sebutan umum untuk warga provinsi Banten, kurang spesifik untuk merujuk masyarakat adat ini.',
      ],
    },
    {
      'question':
          'Menurut Teori Pelarian Kerajaan, Suku Baduy dipercaya merupakan keturunan punggawa dari kerajaan mana?',
      'options': [
        'Kerajaan Majapahit',
        'Kerajaan Tarumanegara',
        'Kerajaan Pajajaran',
        'Kerajaan Sriwijaya',
      ],
      'correctIndex': 2,
      'explanations': [
        'Kerajaan Majapahit berpusat di Jawa Timur, bukan merupakan asal usul pelarian hulu sungai di Banten.',
        'Kerajaan Tarumanegara adalah kerajaan bercorak Hindu tertua di Jawa Barat, namun tidak terkait langsung dengan pelarian abad ke-16.',
        'Benar! Teori populer menyebutkan leluhur Baduy mengasingkan diri ke Gunung Kendeng setelah runtuhnya Kerajaan Pajajaran.',
        'Kerajaan Sriwijaya berpusat di Sumatra dan berbasis maritim, tidak berhubungan dengan asal-usul warga Kanekes.',
      ],
    },
    {
      'question':
          'Berdasarkan Teori Penduduk Asli, leluhur ditugaskan tinggal di hulu sungai untuk menjaga tempat suci yang bernama...',
      'options': [
        'Sulah Nyanda',
        'Archa Domas',
        'Angklung Buhun',
        'Baju Kampret',
      ],
      'correctIndex': 1,
      'explanations': [
        'Sulah Nyanda adalah sebutan untuk bentuk rumah adat panggung khas suku Baduy.',
        'Benar! Archa Domas adalah kompleks batu berundak keramat peninggalan megalitikum yang dijaga ketat oleh mereka.',
        'Angklung Buhun adalah kesenian musik tradisional sakral yang dimainkan saat ritual menanam padi.',
        'Baju Kampret adalah nama pakaian adat yang umum dikenakan oleh masyarakat Baduy Luar.',
      ],
    },
    {
      'question':
          'Apa karakteristik utama dari pakaian adat masyarakat Baduy Dalam?',
      'options': [
        'Menggunakan pakaian berwarna biru tua bermotif batik',
        'Mengenakan pakaian putih bersih dan ikat kepala putih',
        'Menggunakan baju kampret hitam dengan ikat kepala biru',
        'Menggunakan kain tenun modern dengan benang emas',
      ],
      'correctIndex': 1,
      'explanations': [
        'Pakaian biru tua dengan motif batik khas (khombong) merupakan ciri khas pakaian milik warga Baduy Luar.',
        'Benar! Warna putih alami tanpa jahitan mesin melambangkan kesucian pikiran dan keteguhan adat Baduy Dalam.',
        'Baju kampret hitam atau hitam kebiruan dipadukan ikat kepala biru bermotif adalah pakaian resmi Baduy Luar.',
        'Masyarakat Baduy melarang penggunaan benang sintetis modern atau hiasan mewah yang dinilai melanggar kesederhanaan.',
      ],
    },
  ];

  // LOGIKA PINDAH SOAL & VALIDASI AKHIR KUIS
  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
        _isAnswered = false;
      } else {
        _isQuizFinished = true;
      }
    });
  }

  // LOGIKA RETAKE / RESET KUIS
  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _selectedOptionIndex = null;
      _isAnswered = false;
      _totalScore = 0;
      _isQuizFinished = false;
    });
  }

  // ✅ REVISI NAVIGASI BACK: Membersihkan tumpukan rute agar HomePage mendeteksi ulang database secara utuh
  void _backToHomePage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
      (route) =>
          false, // Menghapus seluruh riwayat page sebelumnya agar data aman ter-load ulang
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentQuestionIndex + 1) / _questions.length;
    int correctIndex = _questions[_currentQuestionIndex]['correctIndex'];

    return Scaffold(
      backgroundColor: const Color(0xFFEFE9DB),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFF2E6A3F),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: _backToHomePage,
        ),
        titleSpacing: 0,
        title: const Text(
          'BaduyLearn Quiz',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Cokelat/Beige
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

          // Konten Utama
          SafeArea(
            child: _isQuizFinished
                ? _buildScoreScreen()
                : _buildQuizContent(progress, correctIndex),
          ),

          // Bottom Nav Bar Kaca Melayang
          Positioned(bottom: 0, left: 0, right: 0, child: buildGlassNavBar()),
        ],
      ),
    );
  }

  // ================= TAMPILAN HALAMAN SKOR AKHIR =================
  Widget _buildScoreScreen() {
    int finalScore = ((_totalScore / _questions.length) * 100).round();
    String displayName = _currentUser?.displayName ?? "Sahabat Baduy";

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.stars_rounded,
                size: 80,
                color: Color(0xFF2E6A3F),
              ),
              const SizedBox(height: 16),
              Text(
                'Keren, $displayName!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B3022),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Kuis Selesai!',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              Text(
                'Kamu berhasil menjawab $_totalScore dari ${_questions.length} soal dengan benar.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Colors.black54),
              ),
              const SizedBox(height: 32),

              // Badge Nilai / Skor Utama
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E6A3F),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'SKOR KAMU',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      '$finalScore',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Tombol Ulangi Kuis (Retake Quiz)
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: _resetQuiz,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text(
                    'Retake Quiz',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2E6A3F),
                    side: const BorderSide(color: Color(0xFF2E6A3F), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= TAMPILAN AREA PERTANYAAN KUIS =================
  Widget _buildQuizContent(double progress, int correctIndex) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
                style: const TextStyle(
                  color: Color(0xFF1B3022),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 120,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E6A3F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Kotak Pertanyaan
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _questions[_currentQuestionIndex]['question'],
              style: const TextStyle(
                color: Color(0xFF1B3022),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // List Pilihan Jawaban
          Column(
            children: List.generate(4, (index) {
              String label = String.fromCharCode(65 + index);
              return _buildOptionCard(
                index,
                label,
                _questions[_currentQuestionIndex]['options'][index],
                correctIndex,
              );
            }),
          ),
          const SizedBox(height: 10),

          // Logika Box Penjelasan setelah menjawab
          if (_isAnswered) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _selectedOptionIndex == correctIndex
                    ? const Color(0xFFE8F5E9)
                    : const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _selectedOptionIndex == correctIndex
                      ? Colors.green.shade300
                      : Colors.red.shade300,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _selectedOptionIndex == correctIndex
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: _selectedOptionIndex == correctIndex
                            ? Colors.green
                            : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _selectedOptionIndex == correctIndex
                            ? 'Jawaban Benar! (+1 Poin)'
                            : 'Jawaban Kurang Tepat!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: _selectedOptionIndex == correctIndex
                              ? Colors.green.shade900
                              : Colors.red.shade900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _questions[_currentQuestionIndex]['explanations'][_selectedOptionIndex!],
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Tombol Next Question
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E6A3F),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _nextQuestion,
                      child: Text(
                        _currentQuestionIndex == _questions.length - 1
                            ? 'Lihat Hasil Skor'
                            : 'Pertanyaan Selanjutnya',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ================= LOGIKA CHECK JAWABAN PADA CARD =================
  Widget _buildOptionCard(
    int index,
    String label,
    String text,
    int correctIndex,
  ) {
    bool isSelected = _selectedOptionIndex == index;

    Color cardColor = Colors.white;
    Color borderCardColor = Colors.white;
    Color textColor = const Color(0xFF1B3022);
    Color circleColor = const Color(0xFF2E6A3F).withOpacity(0.1);
    Color labelColor = const Color(0xFF2E6A3F);

    if (_isAnswered) {
      if (index == correctIndex) {
        cardColor = const Color(0xFF2E6A3F);
        borderCardColor = const Color(0xFF2E6A3F);
        textColor = Colors.white;
        circleColor = Colors.white.withOpacity(0.2);
        labelColor = Colors.white;
      } else if (isSelected && _selectedOptionIndex != correctIndex) {
        cardColor = Colors.red.shade600;
        borderCardColor = Colors.red.shade600;
        textColor = Colors.white;
        circleColor = Colors.white.withOpacity(0.2);
        labelColor = Colors.white;
      }
    } else if (isSelected) {
      cardColor = const Color(0xFF2E6A3F).withOpacity(0.2);
      borderCardColor = const Color(0xFF2E6A3F);
    }

    return GestureDetector(
      onTap: _isAnswered
          ? null
          : () {
              setState(() {
                _selectedOptionIndex = index;
                _isAnswered = true;

                if (index == correctIndex) {
                  _totalScore++;
                }
              });
            },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderCardColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: labelColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
                _navItem(Icons.menu_book_outlined, 'Learn', 1),
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
          if (_currentIndex != 0) _backToHomePage();
        } else if (index == 1) {
          if (_currentIndex != 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const QuickLearnPage()),
            );
          }
        } else if (index == 2) {
          if (_currentIndex != 2) {
            Navigator.pushReplacement(
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
