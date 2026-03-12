// lib/features/mahasiswa/data/models/mahasiswa_model.dart
class MahasiswaModel {
  final String nama;
  final String nim;
  final String email;
  final String jurusan;
  final String? angkatan; // optional

  MahasiswaModel({
    required this.nama,
    required this.nim,
    required this.email,
    required this.jurusan,
    this.angkatan,
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      email: json['email'] ?? '',
      jurusan: json['jurusan'] ?? '',
      angkatan: json['angkatan']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'nim': nim,
      'email': email,
      'jurusan': jurusan,
      'angkatan': angkatan,
    };
  }
}