import 'dart:io';

class Mahasiswa {
  String? nama;
  int? nim;
  String? jurusan;

  Mahasiswa({this.nama, this.nim, this.jurusan});

  void tampilkanData() {
    print('---------------------------');
    print("Nama   : ${nama ?? 'Belum diisi'}");
    print("NIM    : ${nim ?? 'Belum diisi'}");
    print("Jurusan: ${jurusan ?? 'Belum diisi'}");
  }
}

mixin ContactMixin {
  String? email;
  String? telepon;

  void tampilkanKontak() {
    print("Email  : ${email ?? 'Belum diisi'}");
    print("Telepon: ${telepon ?? 'Belum diisi'}");
  }
}

mixin TimestampMixin {
  DateTime createdAt = DateTime.now();
  DateTime? updatedAt;

  void touch() {
    updatedAt = DateTime.now();
  }

  void tampilkanTimestamp() {
    print("Dibuat   : ${createdAt.toIso8601String()}");
    print("Diperbarui: ${updatedAt?.toIso8601String() ?? 'Belum diperbarui'}");
  }
}

mixin AcademicMixin {
  double? ipk;
  List<String> daftarMataKuliah = [];

  void tambahMataKuliah(String mk) {
    final trimmed = mk.trim();
    if (trimmed.isNotEmpty) daftarMataKuliah.add(trimmed);
  }

  void tampilkanAkademik() {
    print("IPK          : ${ipk?.toStringAsFixed(2) ?? 'Belum diisi'}");
    print("Mata Kuliah  : ${daftarMataKuliah.isEmpty ? 'Belum ada' : daftarMataKuliah.join(', ')}");
  }
}

mixin EmploymentMixin {
  String? jabatan;
  double? gaji;

  void tampilkanKepegawaian() {
    print("Jabatan: ${jabatan ?? 'Belum diisi'}");
    print("Gaji   : ${gaji == null ? 'Belum diisi' : 'Rp ${gaji!.toStringAsFixed(0)}'}");
  }
}

// Turunan Mahasiswa: MahasiswaAktif dan MahasiswaAlumni (dari kode Anda, sedikit disesuaikan)
class MahasiswaAktif extends Mahasiswa with AcademicMixin, ContactMixin, TimestampMixin {
  MahasiswaAktif({
    String? nama,
    int? nim,
    String? jurusan,
    double? ipk,
    List<String>? mataKuliah,
  }) : super(nama: nama, nim: nim, jurusan: jurusan) {
    this.ipk = ipk;
    if (mataKuliah != null) daftarMataKuliah = mataKuliah;
  }

  @override
  void tampilkanData() {
    super.tampilkanData();
    print("Status : Aktif");
    tampilkanKontak();
    tampilkanAkademik();
    tampilkanTimestamp();
  }
}

class MahasiswaAlumni extends Mahasiswa with ContactMixin, TimestampMixin {
  int? tahunLulus;
  String? pekerjaan;

  MahasiswaAlumni({
    String? nama,
    int? nim,
    String? jurusan,
    this.tahunLulus,
    this.pekerjaan,
  }) : super(nama: nama, nim: nim, jurusan: jurusan);

  @override
  void tampilkanData() {
    super.tampilkanData();
    print("Status     : Alumni");
    print("Tahun Lulus: ${tahunLulus ?? 'Belum diisi'}");
    print("Pekerjaan  : ${pekerjaan ?? 'Belum diisi'}");
    tampilkanKontak();
    tampilkanTimestamp();
  }
}

// Dosen yang extend Mahasiswa (sesuai permintaan) dan memakai mixin:
class Dosen extends Mahasiswa with ContactMixin, TimestampMixin, EmploymentMixin, AcademicMixin {
  Dosen({
    String? nama,
    int? nim,
    String? jurusan,
    String? jabatan,
    double? gaji,
    double? ipk, // misal dosen juga punya IPK (history)
  }) : super(nama: nama, nim: nim, jurusan: jurusan) {
    this.jabatan = jabatan;
    this.gaji = gaji;
    this.ipk = ipk;
  }

  @override
  void tampilkanData() {
    super.tampilkanData();
    print("Peran  : Dosen");
    tampilkanKepegawaian();
    tampilkanKontak();
    tampilkanAkademik();
    tampilkanTimestamp();
  }
}

// Fakultas yang extend Mahasiswa (meskipun secara semantik aneh, ini sesuai permintaan)
class Fakultas extends Mahasiswa with ContactMixin, TimestampMixin {
  String? namaFakultas;
  int? jumlahProdi;

  Fakultas({
    String? nama, // bisa dipakai sebagai nama fakultas
    int? nim, // id fakultas (opsional)
    this.namaFakultas,
    this.jumlahProdi,
  }) : super(nama: nama, nim: nim);

  @override
  void tampilkanData() {
    // gunakan properti fakultas jika ada, fallback ke nama Mahasiswa
    print('---------------------------');
    print("Nama Fakultas: ${namaFakultas ?? nama ?? 'Belum diisi'}");
    print("ID Fakultas  : ${nim ?? 'Belum diisi'}");
    print("Jumlah Prodi : ${jumlahProdi ?? 'Belum diisi'}");
    tampilkanKontak();
    tampilkanTimestamp();
  }
}

void main() {
  // Contoh: Mahasiswa Aktif
  final m = MahasiswaAktif(
    nama: 'Ayu S.',
    nim: 123456,
    jurusan: 'Teknik Informatika',
    ipk: 3.75,
    mataKuliah: ['Pemrograman', 'Basis Data'],
  );
  m.email = 'ayu@example.com';
  m.telepon = '08123456789';
  m.tambahMataKuliah('Sistem Operasi');
  m.touch(); // set updatedAt
  print('\n=== Data Mahasiswa Aktif ===');
  m.tampilkanData();

  // Contoh: Dosen
  final d = Dosen(
    nama: 'Dr. Budi',
    nim: 999001,
    jurusan: 'Teknik Informatika',
    jabatan: 'Lektor',
    gaji: 12000000,
    ipk: 3.80,
  );
  d.email = 'budi@univ.ac.id';
  d.telepon = '082233445566';
  d.tambahMataKuliah('Algoritma Lanjut'); // sebagai daftar mata ajar/historis
  print('\n=== Data Dosen ===');
  d.tampilkanData();

  // Contoh: Fakultas
  final f = Fakultas(
    namaFakultas: 'Fakultas Teknik',
    jumlahProdi: 6,
    nama: null,
    nim: 10, // id fakultas
  );
  f.email = 'ftek@univ.ac.id';
  f.telepon = '021-555555';
  print('\n=== Data Fakultas ===');
  f.tampilkanData();

  // Contoh: Alumni
  final a = MahasiswaAlumni(
    nama: 'Rina',
    nim: 223344,
    jurusan: 'Sistem Informasi',
    tahunLulus: 2020,
    pekerjaan: 'Backend Developer',
  );
  a.email = 'rina@mail.com';
  a.touch();
  print('\n=== Data Alumni ===');
  a.tampilkanData();
}