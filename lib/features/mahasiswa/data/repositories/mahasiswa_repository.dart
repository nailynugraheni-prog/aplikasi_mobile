// lib/features/mahasiswa/data/repositories/mahasiswa_repositories.dart
import 'package:cobadulu/features/mahasiswa/data/models/mahasiswa_model.dart';

class MahasiswaRepository {
  /// Mendapatkan daftar mahasiswa (dummy data)
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    // Simulasi network delay
    await Future.delayed(const Duration(seconds: 1));

    return [
      MahasiswaModel(
        nama: 'Siti Nurhaliza',
        nim: '2001001',
        email: 'siti.n@example.com',
        jurusan: 'Teknik Informatika',
        angkatan: '2020',
      ),
      MahasiswaModel(
        nama: 'Budi Santoso',
        nim: '2001002',
        email: 'budi.s@example.com',
        jurusan: 'Teknik Informatika',
        angkatan: '2021',
      ),
      MahasiswaModel(
        nama: 'Rina Amelia',
        nim: '2001003',
        email: 'rina.a@example.com',
        jurusan: 'Sistem Informasi',
        angkatan: '2020',
      ),
    ];
  }
}