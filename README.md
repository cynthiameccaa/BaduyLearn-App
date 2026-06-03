
## A. Latar Belakang
Suku Baduy di Provinsi Banten memiliki kekayaan budaya dan kearifan lokal yang sangat unik. Fenomena menarik sering terlihat di ruang publik urban, di mana masyarakat Suku Baduy berjalan kaki lintas wilayah tanpa alas kaki. Kehadiran mereka di tengah modernitas ini sering kali memantik rasa penasaran masyarakat, terutama mengenai aturan adat yang membagi mereka menjadi Baduy Luar (adaptif teknologi) dan Baduy Dalam (teguh menolak modernitas).

Namun, pemenuhan rasa ingin tahu ini masih terkendala oleh minimnya platform edukasi yang kasual. Informasi mengenai Suku Baduy umumnya berupa artikel panjang yang padat atau sekadar materi hafalan kaku. Guna menjembatani hal tersebut, **BaduyLearn** dirancang untuk mengemas pengetahuan kebudayaan Suku Baduy ke dalam platform digital mobile yang interaktif melalui metode pembelajaran cepat (*Quick Learn*) yang dipadukan langsung dengan kuis interaktif.

## B. Tujuan Aplikasi
1. Menyediakan platform edukasi mobile yang berfokus pada kombinasi materi ringkas dan kuis interaktif untuk mengenalkan budaya Suku Baduy.
2. Mentransformasikan penyampaian materi kebudayaan lokal yang umumnya bersifat pasif menjadi media pembelajaran yang aktif dan partisipatif melalui fitur *Quiz Time*.
3. Memberikan pengalaman belajar yang kasual namun efektif bagi pengguna dalam memahami perbedaan dan aturan adat Suku Baduy Dalam maupun Baduy Luar.

## C. Deskripsi Umum Aplikasi
**BaduyLearn** adalah aplikasi edukasi berbasis mobile yang dirancang khusus sebagai media digital interaktif. Aplikasi ini mengkombinasikan visual yang estetik dengan elemen UI modern (seperti efek *glassmorphism* pada navigasi dan kartu informasi) untuk memberikan pengalaman belajar yang menyenangkan bagi pelajar, mahasiswa, wisatawan, serta masyarakat umum.

## D. Tools yang Digunakan
* **Framework:** Flutter SDK
* **Bahasa Pemrograman:** Dart
* **Code Editor:** Visual Studio Code
* **Backend Backend:** Firebase Authentication & Cloud Firestore
* **Design Tools:** Figma

## E. Metode Pengembangan
Proyek ini dikembangkan menggunakan **Metode Waterfall** secara sistematis dengan tahapan sebagai berikut:
1. **Requirement Analysis:** Identifikasi fitur utama aplikasi edukasi budaya, target audiens, serta fungsionalitas sistem autentikasi dan database.
2. **System and Software Design:** Menyusun cetak biru (*blueprint*) aplikasi, aset visual, palet warna, dan perancangan UI/UX design menggunakan Figma.
3. **Implementation:** Mentransformasikan hasil rancangan visual dari Figma ke dalam bentuk kode program menggunakan Flutter dan integrasi Firebase.
4. **Testing:** Uji coba fungsionalitas dan performa pada lingkungan browser (Google Chrome) guna mendeteksi serta meminimalisasi *layout bug*.
5. **Maintenance:** Evaluasi pasca-koding berupa perbaikan gangguan navigasi (*error handling*) serta penyesuaian ukuran aset visual agar tetap responsif.


## F. Arsitektur & Fungsi Sistem

### Use Case Diagram
Sistem ini memodelkan interaksi antara **dua aktor utama**:
1. **Aktor Utama (User):** Mengakses materi edukasi dan fitur kuis.
2. **Aktor Pendukung (Firebase):** Menyediakan layanan autentikasi data pendaftaran secara *real-time*.

### 5 Fungsi Utama Aplikasi:
* **Melakukan Registrasi Akun:** Pengguna menginput *username*, *email*, dan *password* yang langsung tervalidasi serta tersimpan aman di database Firebase secara *real-time*.
* **Mengakses Halaman Utama:** Melihat ringkasan menu dan navigasi *dashboard* aplikasi setelah akun terverifikasi.
* **Mengakses Materi Sejarah Suku Baduy:** Mempelajari latar belakang, teori asal-usul, serta aturan adat (*Pikukuh*) secara komprehensif.
* **Mengakses Fitur Quick Learn:** Menyajikan ringkasan informasi kebudayaan esensial (Rumah Adat, Pakaian Adat, Makanan, Kesenian) secara cepat berbasis visual.
* **Mengerjakan Quiz:** Sarana evaluasi interaktif mandiri untuk mengukur tingkat pemahaman setelah membaca materi.

---

## G. Fitur Utama Aplikasi & Deskripsi Kuis

### Fitur Utama
* **Halaman Home:** Ucapan selamat datang, kartu materi utama (*The Origin of Baduy Culture*), pintasan menu, dan cuplikan fakta unik (*Fun Fact*).
* **Halaman Materi (Quick Learn & History Page):** Artikel terstruktur mengenai asal-usul, perbedaan pakaian adat Baduy Dalam & Baduy Luar, serta aturan adat yang berlaku.
* **Navigasi Antar Halaman:** Menggunakan *Floating Glass Bottom Navigation Bar* modern untuk perpindahan menu instan (Home, Learn, Quiz).
* **Tampilan Responsif:** Desain adaptif agar tetap presisi di berbagai ukuran layar perangkat.

### Detail Mekanisme Kuis (*Quiz Time*)
* **Jenis Soal:** Pilihan ganda (*Multiple Choice*) dengan opsi jawaban terstruktur.
* **Mekanisme Penilaian:** Sistem menghitung jumlah jawaban benar secara otomatis di akhir sesi kuis untuk memunculkan skor akhir.
* **Feedback Pengguna:** Respon visual langsung saat kuis selesai, menunjukkan pencapaian, serta menyediakan opsi mengulang kuis untuk memperbaiki nilai.
* **Navigasi Soal:** Berpindah dari satu soal ke soal berikutnya secara runut melalui tombol navigasi yang intuitif.

---

## H. Analisis Kelebihan & Kekurangan Aplikasi

### Kelebihan
1. **Desain Visual Modern (Glassmorphic Interface):** Menerapkan efek transparansi kaca terkini yang memberikan kesan estetis, premium, dan interaktif.
2. **Manajemen Autentikasi yang Aman (Firebase Auth):** Sistem pendaftaran dan masuk akun yang terenkripsi optimal untuk melindungi privasi data.
3. **Penyimpanan Data Terintegrasi Real-Time (Cloud Firestore):** Database berbasis NoSQL cloud yang memproses perubahan data instan tanpa perlu memuat ulang aplikasi.
4. **Performa Responsif & Navigasi Instan:** Perpindahan halaman mulus dan adaptif multiplatform berkat optimasi komponen bawaan Flutter.
5. **Konten Interaktif & Edukatif:** Materi disajikan secara ringkas dan didukung visual relevan untuk meningkatkan retensi pembaca.

### Kekurangan
1. **Ketergantungan Penuh Jaringan Internet:** Autentikasi dan sinkronisasi Cloud Firestore tidak dapat berjalan secara *offline*.
2. **Optimalisasi Terbatas pada Platform Tertentu:** Saat ini baru dioptimalisasikan dengan baik untuk lingkungan browser (Google Chrome) dan perangkat mobile.
3. **Penyimpanan Aset Bersifat Statis (Hardcoded):** File teks dan visual disimpan lokal di direktori `assets/images/`, sehingga pembaruan materi memerlukan proses koding ulang (*re-build*).
4. **Sistem Validasi Formulir Masih Standar:** Mekanisme pengecekan format input data masih mengandalkan validasi bawaan standar (*default*) dari Firebase Authentication.