import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // 🌟 Tambah import Firebase Core
import 'firebase_options.dart'; // 🌟 Tambah import opsi otomatis yang sukses dibuat tadi
import 'signup.dart';

void main() async {
  // 🌟 Wajib ditambahkan agar Flutter bisa berkomunikasi dengan native platform (Android/Windows)
  WidgetsFlutterBinding.ensureInitialized();

  // 🌟 Menyalakan koneksi Firebase menggunakan konfigurasi otomatis
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BaduyLearn',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Gambar Latar Belakang
          Positioned.fill(
            child: Image.asset(
              'assets/images/welcomebackground.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 64,
                    ),
                  ),
                );
              },
            ),
          ),

          // 2. Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(
                      0.2,
                    ), // Sedikit redup di atas untuk status bar
                    Colors.transparent, // Bersih di bagian tengah gambar
                    Colors.black.withOpacity(
                      0.6,
                    ), // Mulai menggelap di area teks
                    Colors.black.withOpacity(
                      0.85,
                    ), // Gelap pekat di bagian paling bawah
                  ],
                  stops: const [0.0, 0.35, 0.65, 1.0],
                ),
              ),
            ),
          ),

          // 3. Konten Teks dan Tombol Navigasi
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Judul Utama
                  const Text(
                    'Discover the Life\nof Baduy People',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 2),
                          blurRadius: 4.0,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Deskripsi Singkat
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          'Learn about traditions, lifestyle, and cultural values of the Baduy community.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                            height: 1.4,
                            shadows: const [
                              Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 2.0,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),

                      // Tombol Panah Kanan ke Sign Up
                      GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman Sign Up
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40), // Spacing dasar layar bawah
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
