import 'package:flutter/material.dart';
import 'dart:ui';

class ProfilePage extends StatefulWidget {
  final String username;
  final String email;
  final String password;

  const ProfilePage({
    super.key,
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // 1. Variabel Penampung Data Baru & Status Aplikasi
  bool _isEditing =
      false; // Menandakan apakah sedang dalam mode edit atau tidak
  bool _obscurePassword = true;

  // 2. Controller untuk menangkap ketikan user di TextField
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan data awal yang dilempar dari HomePage
    _usernameController = TextEditingController(text: widget.username);
    _emailController = TextEditingController(text: widget.email);
    _passwordController = TextEditingController(text: widget.password);
  }

  @override
  void dispose() {
    // Jangan lupa di-dispose biar tidak memakan memori RAM HP
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9F5),
      body: Stack(
        children: [
          // Background Gradasi Aesthetic
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // Custom Header / Row Tombol Back
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF2E6A3F).withOpacity(0.1),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Color(0xFF2E6A3F),
                            size: 20,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'My Profile',
                            style: TextStyle(
                              color: Color(0xFF1B3022),
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // Avatar Profil Keren dengan Ring Hijau Tua
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 108,
                          height: 108,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF2E6A3F).withOpacity(0.2),
                              width: 3,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: const Color(
                            0xFF2E6A3F,
                          ).withOpacity(0.9),
                          child: const Icon(
                            Icons.person_rounded,
                            size: 55,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Teks Nama Dinamis (Berubah live saat diketik jika disimpan)
                  Text(
                    _usernameController.text,
                    style: const TextStyle(
                      color: Color(0xFF1B3022),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "BaduyLearn Member",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // ================= KUMPULAN FIELD DATA (Bisa Berubah Mode) =================
                  _buildEditableGlassTile(
                    label: 'Username',
                    controller: _usernameController,
                    icon: Icons.badge_outlined,
                  ),
                  const SizedBox(height: 16),
                  _buildEditableGlassTile(
                    label: 'Email Address',
                    controller: _emailController,
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Field Password Khusus (Ada toggle ikon mata peek)
                  _buildEditablePasswordTile(),

                  const SizedBox(height: 40),

                  // ================= TOMBOL EDIT / SAVE ACTION =================
                  // ================= TOMBOL EDIT / SAVE ACTION =================
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        if (_isEditing) {
                          // JIKA sedang mode edit, lalu ditekan, artinya USER MAU SAVE DATA
                          _isEditing = false;

                          // 🌟 LOGIKA UNTUK RE-REFRESH DAN MENYIMPAN DATA LIVE KE LAYAR
                          // Ini memastikan teks nama besar di atas dan field statis langsung update nilainya
                          _usernameController.text = _usernameController.text;
                          _emailController.text = _emailController.text;
                          _passwordController.text = _passwordController.text;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Perubahan data profil berhasil disimpan! 🎉',
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Color(0xFF2E6A3F),
                            ),
                          );
                        } else {
                          // JIKA sedang mode view biasa, diganti ke MODE EDIT
                          _isEditing = true;
                        }
                      });
                    },
                    icon: Icon(
                      _isEditing
                          ? Icons.check_circle_outline_rounded
                          : Icons.edit_note_rounded,
                      color: const Color(0xFF2E6A3F),
                      size: 24,
                    ),
                    label: Text(
                      _isEditing ? 'Save Changes' : 'Edit Account Details',
                      style: const TextStyle(
                        color: Color(0xFF2E6A3F),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
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

  // Widget Flexible: Bisa jadi Text Biasa atau Input Lapangan Ketik (Username & Email)
  Widget _buildEditableGlassTile({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.55),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.6)),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: const Color(0xFF2E6A3F).withOpacity(0.7),
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),

                      // LOGIKA TOGGLE TAMPILAN
                      _isEditing
                          ? TextField(
                              controller: controller,
                              keyboardType: keyboardType,
                              style: const TextStyle(
                                color: Color(0xFF1B3022),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 6,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF2E6A3F),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF2E6A3F),
                                    width: 2,
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                controller.text,
                                style: const TextStyle(
                                  color: Color(0xFF1B3022),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
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
    );
  }

  // Widget Flexible Khusus Password (Bisa diketik ulang + disembunyikan teksnya)
  Widget _buildEditablePasswordTile() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.55),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.6)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lock_open_rounded,
                  color: const Color(0xFF2E6A3F).withOpacity(0.7),
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),

                      // LOGIKA TOGGLE TAMPILAN PASSWORD
                      _isEditing
                          ? TextField(
                              controller: _passwordController,
                              obscureText:
                                  _obscurePassword, // Sesuai mata ditutup/dibuka
                              style: const TextStyle(
                                color: Color(0xFF1B3022),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 6,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF2E6A3F),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF2E6A3F),
                                    width: 2,
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                _obscurePassword
                                    ? '•' * _passwordController.text.length
                                    : _passwordController.text,
                                style: const TextStyle(
                                  color: Color(0xFF1B3022),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                // Tombol Mata Peek tetap berfungsi di kedua mode (view/edit)
                IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFF2E6A3F).withOpacity(0.6),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
