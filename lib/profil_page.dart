import 'package:flutter/material.dart';
import 'package:praktikum/new_form.dart';
import 'package:praktikum/detail_porto_page.dart';
//  PROFIL PAGE - Tugas Praktikum Flutter
//  Pengembangan: A (Detail Porto), C (Tema Warna), D (Animasi)
class ProfilPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilPage();
}

class _ProfilPage extends State<ProfilPage>
    with SingleTickerProviderStateMixin {

  int _activePage = 0;

  // Data
  final String _name = "Raka Adrian H";
  final String _role = "Mahasiswa Teknik Informatika";
  final String _avatarAsset = "assets/raka.jpg";

  // AnimationController untuk animasi tab
  late AnimationController _tabController;
  late Animation<double> _tabFadeAnim;

  @override
  void initState() {
    super.initState();
    _tabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _tabFadeAnim = CurvedAnimation(
      parent: _tabController,
      curve: Curves.easeInOut,
    );
    _tabController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Dipanggil setiap ganti tab — reset & jalankan ulang animasi
  void _switchTab(int index) {
    setState(() => _activePage = index);
    _tabController.reset();
    _tabController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewForm()),
          );
        },
        backgroundColor: const Color(0xFFF59E0B),
        icon: const Icon(Icons.add, color: Color(0xFF0F172A)),
        label: const Text(
          "Tambah",
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(screenHeight, screenWidth),
                const SizedBox(height: 60),
                // Animasi fade + slide saat ganti tab (Pengembangan D)
                FadeTransition(
                  opacity: _tabFadeAnim,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.06),
                      end: Offset.zero,
                    ).animate(_tabFadeAnim),
                    child: _activePage == 0
                        ? _aboutPage()
                        : (_activePage == 1 ? _portoPage() : _contactPage()),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
            Positioned(
              top: screenHeight * 0.29,
              left: 16,
              right: 16,
              child: _buildTabBar(),
            ),
          ],
        ),
      ),
    );
  }
  //  HEADER
  Widget _buildHeader(double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.33,
      width: screenWidth,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Foto profil dengan border gold
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFF59E0B), width: 3),
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(_avatarAsset),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            _name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: const Color(0xFFF59E0B).withOpacity(0.5)),
            ),
            child: Text(
              _role,
              style: const TextStyle(fontSize: 13, color: Color(0xFFF59E0B)),
            ),
          ),
        ],
      ),
    );
  }
  //  TAB BAR
  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(child: _tabButton("About Me", 0, Icons.account_circle_outlined)),
          Expanded(child: _tabButton("Porto", 1, Icons.folder_open_outlined)),
          Expanded(child: _tabButton("Contact", 2, Icons.contact_page_outlined)),
        ],
      ),
    );
  }

  Widget _tabButton(String label, int index, IconData icon) {
    final bool isActive = _activePage == index;
    return GestureDetector(
      onTap: () => _switchTab(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF0F172A) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? const Color(0xFFF59E0B) : Colors.grey,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
  //  TAB 1: About Me
  Widget _aboutPage() {
    return Container(
      key: const ValueKey("about"),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("Tentang Saya"),
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Data Porto
                  _infoRow(Icons.badge_outlined, "Nama", "Raka Adrian H"),
                  const Divider(height: 20),
                  _infoRow(Icons.numbers, "NIM", "123103015"),
                  const Divider(height: 20),
                  _infoRow(Icons.place_outlined, "Asal Daerah", "Jakarta"),
                  const Divider(height: 20),
                  _infoRow(Icons.school_outlined, "Jurusan", "Teknik Informatika"),
                  const Divider(height: 20),
                  _infoRow(Icons.calendar_today_outlined, "Angkatan", "2023"),
                  const Divider(height: 20),
                  _infoRow(Icons.interests_outlined, "Hobi", "Coding, DJ"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _sectionTitle("Keahlian"),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              // Tech Stack
              _skillChip("Flutter"),
              _skillChip("Dart"),
              _skillChip("Python"),
              _skillChip("UI/UX"),
              _skillChip("Figma"),
              _skillChip("TypeScript"),
              _skillChip("Docker"),
              _skillChip("Postman"),
              _skillChip("Laravel"),
              _skillChip("Git"),
              _skillChip("Adobe"),
            ],
          ),
        ],
      ),
    );
  }
  //  TAB 2: Portfolio — dengan navigasi ke DetailPorto (Pengembangan A)
  Widget _portoPage() {
    // Data portfolio
    final List<Map<String, dynamic>> projects = [
      {
        'title': 'Aplikasi Absensi',
        'tech': 'Flutter + Firebase',
         'icon': Icons.how_to_reg_outlined,
        'description':
            'Aplikasi mobile untuk sistem absensi digital berbasis QR Code. '
                'Memudahkan dosen dan mahasiswa dalam proses pencatatan kehadiran secara real-time.',
        'features': [
          'Login dengan autentikasi Firebase',
          'Scan QR Code untuk absensi',
          'Riwayat kehadiran per mahasiswa',
          'Dashboard rekapitulasi untuk dosen',
          'Notifikasi push saat absensi dibuka',
        ],
      },
      {
        'title': 'Website Toko Online',
        'tech': 'HTML, CSS, JavaScript',
        'icon': Icons.storefront_outlined,
        'description':
            'Website e-commerce sederhana dengan fitur katalog produk, '
                'keranjang belanja, dan halaman checkout yang responsif.',
        'features': [
          'Tampilan responsif untuk mobile dan desktop',
          'Filter dan pencarian produk',
          'Keranjang belanja dengan local storage',
          'Halaman detail produk',
          'Form checkout dengan validasi',
        ],
      },
      {
        'title': 'Analisis Data Nilai',
        'tech': 'Python + Pandas',
         'icon': Icons.query_stats,
        'description':
            'Program analisis data nilai mahasiswa menggunakan Python. '
                'Menghasilkan visualisasi statistik dan laporan performa kelas.',
        'features': [
          'Import data dari file Excel/CSV',
          'Perhitungan statistik deskriptif',
          'Visualisasi grafik dengan Matplotlib',
          'Export laporan ke PDF',
          'Deteksi outlier nilai',
        ],
      },
    ];

    return Container(
      key: const ValueKey("porto"),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("Portfolio"),
          ...projects.map((p) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _portoCard(
                  title: p['title'],
                  tech: p['tech'],
                  icon: p['icon'],
                  description: p['description'],
                  features: List<String>.from(p['features']),
                ),
              )),
        ],
      ),
    );
  }

  //  TAB 3: Contact
  Widget _contactPage() {
    return Container(
      key: const ValueKey("contact"),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("Hubungi Saya"),
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Ganti dengan kontak kamu
                 _infoRow(Icons.alternate_email, "Email", "rakaadrian707@gmail.com"),
                  const Divider(height: 20),
                  _infoRow(Icons.phone_outlined, "WhatsApp", "+62 813 6876 0893"),
                  const Divider(height: 20),
                  _infoRow(Icons.terminal, "GitHub", "github.com/Raka444"),
                  const Divider(height: 20),
                  _infoRow(Icons.work_outline_outlined, "LinkedIn", "linkedin.com/in/username"),
                  const Divider(height: 20),
                  _infoRow(Icons.photo_camera_outlined, "Instagram", "@rka__adrian"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  //  HELPER WIDGETS
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 4),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF59E0B).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF0F172A)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style:
                      const TextStyle(fontSize: 11, color: Colors.grey)),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _skillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF59E0B).withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF59E0B).withOpacity(0.5)),
      ),
      child: Text(
        skill,
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFF92400E),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // Porto card → NavigatoR.push ke DetailPorto
  Widget _portoCard({
    required String title,
    required String tech,
    required IconData icon,
    required String description,
    required List<String> features,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailPorto(
              title: title,
              tech: tech,
              icon: icon,
              description: description,
              features: features,
            ),
          ),
        );
      },
      child: Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Hero(
            tag: 'porto_icon_$title',
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF0F172A)),
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          subtitle: Text(
            tech,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          trailing: const Icon(Icons.arrow_forward_ios,
              size: 14, color: Colors.grey),
        ),
      ),
    );
  }
}