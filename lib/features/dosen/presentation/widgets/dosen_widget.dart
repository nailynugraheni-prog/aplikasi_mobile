import 'package:flutter/material.dart';
import 'package:cobadulu/core/constants/app_constants.dart';
import 'package:cobadulu/features/dosen/data/models/dosen_model.dart';

class ModernDosenCard extends StatefulWidget {
  final DosenModel dosen;
  final VoidCallback? onTap;
  final List<Color>? gradientColors;

  const ModernDosenCard({
    Key? key,
    required this.dosen,
    this.onTap,
    this.gradientColors,
  }) : super(key: key);

  @override
  State<ModernDosenCard> createState() => _ModernDosenCardState();
}

// tambahkan setelah ModernDosenCard di file yang sama

class DosenListView extends StatelessWidget {
  final List<DosenModel> dosenList;
  final VoidCallback? onRefresh;
  final bool useModernCard;

  const DosenListView({
    Key? key,
    required this.dosenList,
    this.onRefresh,
    this.useModernCard = true,
  }) : super(key: key);

  String _titleForItem(DosenModel item) {
    final name = item.nama;
    if (name != null && name.trim().isNotEmpty) return name;
    return 'Dosen';
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // jika onRefresh null, beri fallback no-op agar RefreshIndicator tetap valid
      onRefresh: () async {
        if (onRefresh != null) {
          onRefresh!();
          // beri sedikit delay supaya efek refresh kelihatan saat dipanggil
          await Future<void>.delayed(const Duration(milliseconds: 200));
        }
      },
      child: dosenList.isEmpty
          ? ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(
              child: Text(
                'Tidak ada data dosen',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      )
          : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: dosenList.length,
        itemBuilder: (context, index) {
          final dosen = dosenList[index];

          if (useModernCard) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ModernDosenCard(
                dosen: dosen,
                onTap: () {
                  // default behavior: buka detail (kosong — sesuaikan jika perlu)
                  // Navigator.push(...);
                },
                gradientColors: AppConstants.dashboardGradients[
                index % AppConstants.dashboardGradients.length],
              ),
            );
          }

          // simple fallback list tile
          return ListTile(
            leading: CircleAvatar(
              child: Text(
                _titleForItem(dosen).isNotEmpty
                    ? _titleForItem(dosen)[0].toUpperCase()
                    : '?',
              ),
            ),
            title: Text(_titleForItem(dosen)),
            subtitle: (dosen.nip ?? '').isNotEmpty ? Text('NIP: ${dosen.nip}') : null,
            onTap: () {
              // aksi jika diperlukan
            },
          );
        },
      ),
    );
  }
}

class _ModernDosenCardState extends State<ModernDosenCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
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
    final name = widget.dosen.nama;
    if (name == null || name.trim().isEmpty) return '?';
    return name.trim().substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Color> gradientColors = widget.gradientColors ??
        [
          theme.primaryColor,
          theme.primaryColor.withOpacity(0.7),
        ];

    // safe color pickers
    final Color primaryGradient = gradientColors.isNotEmpty
        ? gradientColors[0]
        : theme.primaryColor;

    return Semantics(
      button: true,
      label: 'Kartu dosen ${widget.dosen.nama ?? 'tidak diketahui'}',
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap?.call();
        },
        onTapCancel: () => _controller.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, primaryGradient.withOpacity(0.05)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: primaryGradient.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: primaryGradient.withOpacity(0.08),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Avatar box with gradient
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: gradientColors,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: primaryGradient.withOpacity(0.28),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _initial,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.dosen.nama ?? '-',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.3,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        if ((widget.dosen.nip ?? '').isNotEmpty)
                          _buildInfoRow(
                            Icons.badge_outlined,
                            'NIP: ${widget.dosen.nip}',
                          ),
                        const SizedBox(height: 4),
                        if ((widget.dosen.email ?? '').isNotEmpty)
                          _buildInfoRow(
                            Icons.email_outlined,
                            widget.dosen.email ?? '',
                          ),
                        const SizedBox(height: 4),
                        if ((widget.dosen.jurusan ?? '').isNotEmpty)
                          _buildInfoRow(
                            Icons.school_outlined,
                            widget.dosen.jurusan ?? '',
                          ),
                      ],
                    ),
                  ),

                  // Arrow
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryGradient.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: primaryGradient,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
}