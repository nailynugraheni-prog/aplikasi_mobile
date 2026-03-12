// MahasiswaAktifModel: dipakai hanya oleh fitur mahasiswa_aktif
class MahasiswaAktifModel {
  final String nama;
  final String nim;
  final String email;
  final String jurusan;
  final String? angkatan;
  final bool isActive; // jelas bedain dengan Mahasiswa biasa

  MahasiswaAktifModel({
    required this.nama,
    required this.nim,
    required this.email,
    required this.jurusan,
    this.angkatan,
    this.isActive = true,
  });

  factory MahasiswaAktifModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaAktifModel(
      nama: (json['nama'] ?? '') as String,
      nim: (json['nim'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      jurusan: (json['jurusan'] ?? '') as String,
      angkatan: json['angkatan']?.toString(),
      isActive: (json['isActive'] ?? true) as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'nim': nim,
      'email': email,
      'jurusan': jurusan,
      'angkatan': angkatan,
      'isActive': isActive,
    };
  }

  MahasiswaAktifModel copyWith({
    String? nama,
    String? nim,
    String? email,
    String? jurusan,
    String? angkatan,
    bool? isActive,
  }) {
    return MahasiswaAktifModel(
      nama: nama ?? this.nama,
      nim: nim ?? this.nim,
      email: email ?? this.email,
      jurusan: jurusan ?? this.jurusan,
      angkatan: angkatan ?? this.angkatan,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  String toString() {
    return 'MahasiswaAktifModel(nama: $nama, nim: $nim, jurusan: $jurusan, angkatan: $angkatan, isActive: $isActive)';
  }
}