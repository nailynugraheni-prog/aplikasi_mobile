// file: map.dart
import 'dart:io';

void main() {
  // 1) Membuat Map dengan data awal (sesuai modul)
  Map<String, String> data = {
    'Anang': '081234567890',
    'Arman': '082345678901',
    'Doni': '083456789012',
  };

  void printMap(Map<String, String> m, String title) {
    print('\n--- $title ---');
    if (m.isEmpty) {
      print('(kosong)');
      return;
    }
    m.forEach((k, v) {
      print('$k: $v');
    });
  }

  // Tampilkan data awal
  printMap(data, 'Data awal');

  // 2) Tambah data
  print('\nMenambahkan data: data[\'Rio\'] = \'084567890123\'');
  data['Rio'] = '084567890123';
  printMap(data, 'Data setelah ditambahkan');

  // 3) Mengakses data tertentu berdasarkan key
  print('\nAkses data berdasarkan key:');
  String keyToAccess = 'Anang';
  if (data.containsKey(keyToAccess)) {
    print('Nomor $keyToAccess: ${data[keyToAccess]}');
  } else {
    print('Key "$keyToAccess" tidak ditemukan.');
  }

  // 4) Ubah data (update)
  print('\nUpdate: mengubah nomor Anang menjadi 081000000000');
  if (data.containsKey('Anang')) {
    data['Anang'] = '081000000000';
    print('Berhasil diupdate.');
  } else {
    print('Key "Anang" tidak ada, tidak bisa update.');
  }
  printMap(data, 'Data setelah update');

  // 5) Hapus data
  print('\nHapus data: menghapus key "Arman"');
  if (data.remove('Arman') != null) {
    print('Key "Arman" berhasil dihapus.');
  } else {
    print('Key "Arman" tidak ada.');
  }
  printMap(data, 'Data setelah penghapusan');

  // 6) Cek apakah key/value ada
  String cekKey = 'Doni';
  print('\nCek apakah key "$cekKey" ada: ${data.containsKey(cekKey) ? 'YA' : 'TIDAK'}');
  String cekValue = '084567890123';
  print('Cek apakah value "$cekValue" ada: ${data.containsValue(cekValue) ? 'YA' : 'TIDAK'}');

  // 7) Hitung jumlah data
  print('\nTotal data: ${data.length}');

  // 8) Tampilkan semua key dan semua value secara terpisah
  print('\nSemua key:');
  data.keys.forEach((k) => print('- $k'));

  print('\nSemua value:');
  data.values.forEach((v) => print('- $v'));

  // -----------------------------------------------
  // Bagian f: Input single dan multiple (contoh Mahasiswa)
  // -----------------------------------------------

  // SINGLE input mahasiswa
  print('\n\n=== INPUT DATA MAHASISWA (SINGLE) ===');
  stdout.write('Masukkan NIM: ');
  String? nim = stdin.readLineSync();
  stdout.write('Masukkan Nama: ');
  String? nama = stdin.readLineSync();
  stdout.write('Masukkan Jurusan: ');
  String? jurusan = stdin.readLineSync();
  stdout.write('Masukkan IPK: ');
  String? ipkStr = stdin.readLineSync();
  double ipk = double.tryParse(ipkStr ?? '') ?? 0.0;

  Map<String, dynamic> mahasiswa = {
    'nim': (nim ?? '').trim(),
    'nama': (nama ?? '').trim(),
    'jurusan': (jurusan ?? '').trim(),
    'ipk': ipk,
  };

  print('\nData Mahasiswa: $mahasiswa');

  // MULTIPLE input mahasiswa
  print('\n\n=== INPUT MULTIPLE MAHASISWA ===');
  stdout.write('Masukkan jumlah mahasiswa: ');
  String? countStr = stdin.readLineSync();
  int count = int.tryParse(countStr ?? '') ?? 0;

  List<Map<String, dynamic>> daftarMahasiswa = [];

  for (int i = 0; i < count; i++) {
    print('\n--- Mahasiswa ke-${i + 1} ---');
    stdout.write('Masukkan NIM: ');
    String? nimI = stdin.readLineSync();
    stdout.write('Masukkan Nama: ');
    String? namaI = stdin.readLineSync();
    stdout.write('Masukkan Jurusan: ');
    String? jurusanI = stdin.readLineSync();
    stdout.write('Masukkan IPK: ');
    String? ipkIStr = stdin.readLineSync();
    double ipkI = double.tryParse(ipkIStr ?? '') ?? 0.0;

    Map<String, dynamic> mhs = {
      'nim': (nimI ?? '').trim(),
      'nama': (namaI ?? '').trim(),
      'jurusan': (jurusanI ?? '').trim(),
      'ipk': ipkI,
    };
    daftarMahasiswa.add(mhs);
  }

  // Tampilkan hasil multiple input
  print('\n\n=== DAFTAR MAHASISWA ===');
  if (daftarMahasiswa.isEmpty) {
    print('(Tidak ada data mahasiswa)');
  } else {
    for (int i = 0; i < daftarMahasiswa.length; i++) {
      var m = daftarMahasiswa[i];
      print('\n--- Mahasiswa ke-${i + 1} ---');
      print('NIM    : ${m['nim']}');
      print('Nama   : ${m['nama']}');
      print('Jurusan: ${m['jurusan']}');
      print('IPK    : ${m['ipk']}');
    }
  }

  print('\nSelesai.');
}