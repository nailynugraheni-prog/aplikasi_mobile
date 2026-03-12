import 'package:cobadulu/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  /// Kembalikan List<MahasiswaAktifModel>
  Future<List<MahasiswaAktifModel>> getMahasiswaAktif() async {
    await Future.delayed(const Duration(milliseconds: 700)); // simulasi

    return [
      MahasiswaAktifModel(
        nama: 'Siti Nurhaliza',
        nim: '2001001',
        email: 'siti.n@example.com',
        jurusan: 'Teknik Informatika',
        angkatan: '2020',
        isActive: true,
      ),
      MahasiswaAktifModel(
        nama: 'Budi Santoso',
        nim: '2001002',
        email: 'budi.s@example.com',
        jurusan: 'Teknik Informatika',
        angkatan: '2021',
        isActive: true,
      ),
      MahasiswaAktifModel(
        nama: 'Doni Prasetyo',
        nim: '2001004',
        email: 'doni.p@example.com',
        jurusan: 'Teknik Komputer',
        angkatan: '2022',
        isActive: true,
      ),
    ];
  }
}