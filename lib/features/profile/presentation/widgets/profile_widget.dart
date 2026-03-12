// lib/features/profile/presentation/widgets/profile_widget.dart
import 'package:flutter/material.dart';
import 'package:cobadulu/core/constants/app_constants.dart';
import 'package:cobadulu/features/profile/data/models/profile_model.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.profile,
    this.onEdit,
    this.onLogout,
  });

  final ProfileModel profile;
  final VoidCallback? onEdit;
  final VoidCallback? onLogout;

  String get initials {
    final parts = profile.nama.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // dashboardGradients biasanya List<List<Color>> — ambil list pertama,
    // lalu pilih primary color (index 0) sebagai warna utama.
    final List<Color> gradientColors = AppConstants.dashboardGradients.isNotEmpty
        ? AppConstants.dashboardGradients[0]
        : [theme.primaryColor, theme.primaryColor.withOpacity(0.7)];
    final Color primary = gradientColors.isNotEmpty ? gradientColors[0] : theme.primaryColor;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, primary.withOpacity(0.04)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primary.withOpacity(0.06)),
        boxShadow: [BoxShadow(color: primary.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor: primary,
            child: profile.avatarUrl == null
                ? Text(initials, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
                : ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: Image.network(profile.avatarUrl!, fit: BoxFit.cover, width: 72, height: 72),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(profile.nama, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 6),
              Text(profile.email, style: TextStyle(color: Colors.grey[700])),
              const SizedBox(height: 6),
              Row(children: [
                if (profile.role.isNotEmpty) Chip(label: Text(profile.role.toUpperCase())),
                if ((profile.jurusan ?? '').isNotEmpty) const SizedBox(width: 8),
                if ((profile.jurusan ?? '').isNotEmpty) Text(profile.jurusan!, style: TextStyle(color: Colors.grey[700])),
              ]),
            ]),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
              const SizedBox(height: 4),
              IconButton(icon: const Icon(Icons.logout), onPressed: onLogout),
            ],
          ),
        ],
      ),
    );
  }
}