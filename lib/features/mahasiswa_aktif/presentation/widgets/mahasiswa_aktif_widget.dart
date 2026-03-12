// lib/features/mahasiswa_aktif/presentation/widgets/mahasiswa_aktif_widget.dart
import 'package:flutter/material.dart';
import 'package:cobadulu/core/constants/app_constants.dart';
import 'package:cobadulu/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

/// Kartu modern untuk MahasiswaAktifModel (dengan badge AKTIF)
class ModernMahasiswaAktifCard extends StatefulWidget {
  final MahasiswaAktifModel mahasiswa;
  final VoidCallback? onTap;
  final List<Color>? gradientColors;

  const ModernMahasiswaAktifCard({
    Key? key,
    required this.mahasiswa,
    this.onTap,
    this.gradientColors,
  }) : super(key: key);

  @override
  State<ModernMahasiswaAktifCard> createState() => _ModernMahasiswaAktifCardState();
}

class _ModernMahasiswaAktifCardState extends State<ModernMahasiswaAktifCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get _initial {
    final name = widget.mahasiswa.nama;
    if (name.trim().isEmpty) return '?';
    return name.trim().substring(0, 1).toUpperCase();
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Color> gradientColors = widget.gradientColors ??
        [theme.primaryColor, theme.primaryColor.withOpacity(0.7)];
    final primaryGradient = gradientColors.isNotEmpty ? gradientColors[0] : theme.primaryColor;

    return Semantics(
      button: true,
      label: 'Kartu mahasiswa aktif ${widget.mahasiswa.nama}',
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap?.call();
        },
        onTapCancel: () => _controller.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.white, primaryGradient.withOpacity(0.04)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: primaryGradient.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 4)),
                  ],
                  border: Border.all(color: primaryGradient.withOpacity(0.06), width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: gradientColors),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: primaryGradient.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 3))],
                        ),
                        child: Center(
                          child: Text(_initial, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.mahasiswa.nama,
                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: -0.3),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            if (widget.mahasiswa.nim.isNotEmpty) _buildInfoRow(Icons.badge_outlined, 'NIM: ${widget.mahasiswa.nim}'),
                            const SizedBox(height: 4),
                            if (widget.mahasiswa.jurusan.isNotEmpty) _buildInfoRow(Icons.school_outlined, widget.mahasiswa.jurusan),
                            const SizedBox(height: 4),
                            if ((widget.mahasiswa.angkatan ?? '').isNotEmpty) _buildInfoRow(Icons.calendar_today_outlined, 'Angkatan: ${widget.mahasiswa.angkatan}'),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: primaryGradient.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                        child: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: primaryGradient),
                      ),
                    ],
                  ),
                ),
              ),

              // badge AKTIF
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.green[700], borderRadius: BorderRadius.circular(12)),
                  child: const Text('AKTIF', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ListView khusus untuk MahasiswaAktifModel
class MahasiswaAktifListView extends StatelessWidget {
  final List<MahasiswaAktifModel> list;
  final VoidCallback? onRefresh;

  const MahasiswaAktifListView({Key? key, required this.list, this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (onRefresh != null) {
          onRefresh!();
          await Future<void>.delayed(const Duration(milliseconds: 200));
        }
      },
      child: list.isEmpty
          ? ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(child: Text('Tidak ada mahasiswa aktif', style: Theme.of(context).textTheme.bodyMedium)),
          ),
        ],
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final m = list[index];
          final gradient = AppConstants.dashboardGradients[index % AppConstants.dashboardGradients.length];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ModernMahasiswaAktifCard(mahasiswa: m, gradientColors: gradient, onTap: () {
              // default: open detail jika mau
            }),
          );
        },
      ),
    );
  }
}