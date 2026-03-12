// file: set.dart
import 'dart:io';

void main() {
  // Contoh sederhana seperti di screenshot
  Set<String> burung = {'Merpati', 'Elang', 'Kakatua'};
  print('Burung: $burung');

  // Inisialisasi Set dengan data awal untuk latihan
  Set<String> data = {'a', 'b', 'c', 'd', 'e'};

  // Fungsi bantu untuk menampilkan semua data dan total
  void printAll() {
    print('\n=== SEMUA DATA ===');
    int i = 1;
    for (var item in data) {
      print('${i}. $item');
      i++;
    }
    print('Total data: ${data.length}\n');
  }

  // Tampilkan data awal
  printAll();

  // 1) Tambah data baru
  stdout.write('Masukkan data baru: ');
  String? input = stdin.readLineSync();
  if (input != null) {
    String item = input.trim();
    if (item.isEmpty) {
      print('Tidak ada input. Lewati penambahan.');
    } else {
      if (data.add(item)) {
        print('Data "$item" berhasil ditambahkan!');
      } else {
        print('Data "$item" sudah ada di Set! (duplicate tidak ditambahkan).');
      }
    }
  }

  // 2) Coba tambahkan duplicate (user dapat memasukkan nilai sama lagi)
  stdout.write('Coba tambahkan data yang sama lagi (masukkan nilai yang sama untuk melihat duplicate): ');
  String? dupInput = stdin.readLineSync();
  if (dupInput != null) {
    String dup = dupInput.trim();
    if (dup.isEmpty) {
      print('Tidak ada input. Lewati percobaan duplicate.');
    } else {
      if (data.add(dup)) {
        print('Data "$dup" berhasil ditambahkan!');
      } else {
        print('Data "$dup" sudah ada di Set! (duplicate tidak ditambahkan).');
      }
    }
  }

  // Tampilkan setelah penambahan
  printAll();

  // 3) Hapus data
  stdout.write('Masukkan data yang ingin dihapus: ');
  String? delInput = stdin.readLineSync();
  if (delInput != null) {
    String del = delInput.trim();
    if (del.isEmpty) {
      print('Tidak ada input. Lewati penghapusan.');
    } else {
      if (data.remove(del)) {
        print('Data "$del" berhasil dihapus!');
      } else {
        print('Data "$del" tidak ada di Set!');
      }
    }
  }

  // Tampilkan setelah penghapusan
  printAll();

  // 4) Cek apakah suatu data ada di Set
  stdout.write('Masukkan data yang ingin dicek: ');
  String? cekInput = stdin.readLineSync();
  if (cekInput != null) {
    String cek = cekInput.trim();
    if (cek.isEmpty) {
      print('Tidak ada input. Lewati pengecekan.');
    } else {
      if (data.contains(cek)) {
        print('Data "$cek" ada di Set!');
      } else {
        print('Data "$cek" tidak ada di Set!');
      }
    }
  }

  // Final: tampilkan keadaan akhir Set
  printAll();

  print('Selesai.');
}