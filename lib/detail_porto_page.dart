import 'package:flutter/material.dart';
//  DETAIL PORTO PAGE - Tugas Pengembangan A
//  Konsep: Navigator.push() dari tab Portfolio
//  + Hero Animation Pengembangan D

class DetailPorto extends StatefulWidget {
  final String title;
  final String tech;
  final String description;
  final IconData icon;
  final List<String> features;

  const DetailPorto({
    super.key,
    required this.title,
    required this.tech,
    required this.description,
    required this.icon,
    required this.features,
  });

  @override
  State<DetailPorto> createState() => _DetailPortoState();
}

class _DetailPortoState extends State<DetailPorto>
    with SingleTickerProviderStateMixin {

  // AnimationController untuk animasi masuk konten
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Jalankan animasi saat halaman pertama kali muncul
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          // AppBar dengan Hero animation
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: const Color(0xFF0F172A),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  // Hero: animasi transisi icon dari list ke halaman detail
                  child: Hero(
                    tag: 'porto_icon_${widget.title}',
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B).withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.icon,
                        size: 64,
                        color: const Color(0xFFF59E0B),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Konten Detail 
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge teknologi
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color(0xFFF59E0B).withOpacity(0.4)),
                        ),
                        child: Text(
                          widget.tech,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFFB45309),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Deskripsi
                      const Text(
                        'Deskripsi Project',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF475569),
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Fitur-fitur
                      const Text(
                        'Fitur Utama',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 12),
                        ...widget.features.map((f) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            // Icon centang sebagai bullet point fitur
                            Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Icon(
                                Icons.check_rounded,
                                size: 16,
                                color: const Color(0xFFF59E0B),
                                ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                                child: Text(
                                f,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF475569),
                                    height: 1.5,
                                ),
                                ),
                            ),
                            ],
                        ),
                        )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}