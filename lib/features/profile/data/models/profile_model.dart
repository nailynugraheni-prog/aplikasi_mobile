// lib/features/profile/data/models/profile_model.dart
class ProfileModel {
  final String id;
  final String nama;
  final String email;
  final String role; // contoh: "mahasiswa" atau "dosen"
  final String? nomorHp;
  final String? jurusan;
  final String? angkatan;
  final String? avatarUrl;

  ProfileModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.role,
    this.nomorHp,
    this.jurusan,
    this.angkatan,
    this.avatarUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: (json['id'] ?? '') as String,
      nama: (json['nama'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      role: (json['role'] ?? 'mahasiswa') as String,
      nomorHp: json['nomorHp'] as String?,
      jurusan: json['jurusan'] as String?,
      angkatan: json['angkatan'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'role': role,
      'nomorHp': nomorHp,
      'jurusan': jurusan,
      'angkatan': angkatan,
      'avatarUrl': avatarUrl,
    };
  }

  ProfileModel copyWith({
    String? id,
    String? nama,
    String? email,
    String? role,
    String? nomorHp,
    String? jurusan,
    String? angkatan,
    String? avatarUrl,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      role: role ?? this.role,
      nomorHp: nomorHp ?? this.nomorHp,
      jurusan: jurusan ?? this.jurusan,
      angkatan: angkatan ?? this.angkatan,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  String toString() {
    return 'ProfileModel(id: $id, nama: $nama, email: $email, role: $role)';
  }
}