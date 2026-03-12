// lib/features/profile/data/repositories/profile_repository.dart
import 'package:cobadulu/features/profile/data/models/profile_model.dart';

class ProfileRepository {
  /// Simulasi ambil profile (misalnya dari local storage / api)
  Future<ProfileModel> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 700));
    // Dummy profile — ganti dengan panggilan API / storage nyata
    return ProfileModel(
      id: 'u-1001',
      nama: 'Naila Nugraheni',
      email: 'naila.n@example.com',
      role: 'mahasiswa',
      nomorHp: '081234567890',
      jurusan: 'Teknik Informatika',
      angkatan: '2020',
      avatarUrl: null,
    );
  }

  /// Simulasi update profile (kirim ke API lalu kembalikan versi terbaru)
  Future<ProfileModel> updateProfile(ProfileModel updated) async {
    await Future.delayed(const Duration(milliseconds: 700));
    // Dalam implementasi nyata terima respons dari server
    // di sini kita hanya kembalikan input sebagai bukti update berhasil
    return updated;
  }
}