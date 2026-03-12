// lib/features/profile/presentation/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cobadulu/core/widgets/common_widgets.dart';
import 'package:cobadulu/features/profile/presentation/providers/profile_provider.dart';
import 'package:cobadulu/features/profile/presentation/widgets/profile_widget.dart';
import 'package:cobadulu/features/profile/data/models/profile_model.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), elevation: 0),
      body: profileState.when(
        loading: () => const LoadingWidget(),
        error: (err, st) => CustomErrorWidget(
          message: 'Gagal memuat profile: ${err.toString()}',
          onRetry: () => ref.read(profileNotifierProvider.notifier).refresh(),
        ),
        data: (profile) => _buildProfileView(context, profile),
      ),
    );
  }

  Widget _buildProfileView(BuildContext context, ProfileModel profile) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileCard(
            profile: profile,
            onEdit: () => _showEditDialog(context, profile),
            onLogout: () {
              // implement logout sesuai app (contoh hanya snackbar)
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logout (placeholder)')));
            },
          ),
          const SizedBox(height: 12),
          // contoh detail tambahan
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _infoRow(Icons.badge_outlined, 'ID', profile.id),
                _infoRow(Icons.phone_android, 'Nomor HP', profile.nomorHp ?? '-'),
                _infoRow(Icons.school_outlined, 'Jurusan', profile.jurusan ?? '-'),
                _infoRow(Icons.calendar_today_outlined, 'Angkatan', profile.angkatan ?? '-'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      leading: Icon(icon, size: 22, color: Colors.grey[700]),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(value),
    );
  }

  void _showEditDialog(BuildContext context, ProfileModel profile) {
    final namaCtrl = TextEditingController(text: profile.nama);
    final nomorCtrl = TextEditingController(text: profile.nomorHp ?? '');
    final jurusanCtrl = TextEditingController(text: profile.jurusan ?? '');
    final angkatanCtrl = TextEditingController(text: profile.angkatan ?? '');

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: namaCtrl, decoration: const InputDecoration(labelText: 'Nama')),
                TextField(controller: nomorCtrl, decoration: const InputDecoration(labelText: 'Nomor HP')),
                TextField(controller: jurusanCtrl, decoration: const InputDecoration(labelText: 'Jurusan')),
                TextField(controller: angkatanCtrl, decoration: const InputDecoration(labelText: 'Angkatan')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Batal')),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(ctx).pop();
                // panggil provider untuk update
                await ref.read(profileNotifierProvider.notifier).updateProfileFields(
                  nama: namaCtrl.text.trim(),
                  nomorHp: nomorCtrl.text.trim(),
                  jurusan: jurusanCtrl.text.trim(),
                  angkatan: angkatanCtrl.text.trim(),
                );
                // notifikasi sederhana
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil diperbarui')));
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }
}