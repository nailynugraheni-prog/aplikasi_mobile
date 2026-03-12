// list.dart
// Versi sesuai modul: contoh operasi List (a - m)
// Jalankan: dart run list.dart

import 'dart:io';

String readLine(String prompt) {
  stdout.write(prompt);
  return stdin.readLineSync() ?? '';
}

int readInt(String prompt, {int? min, int? max}) {
  while (true) {
    String s = readLine(prompt);
    try {
      int v = int.parse(s);
      if ((min != null && v < min) || (max != null && v > max)) {
        print('Masukkan angka antara ${min ?? "-∞"} dan ${max ?? "∞"}.');
        continue;
      }
      return v;
    } catch (e) {
      print('Input tidak valid. Masukkan angka (contoh: 5).');
    }
  }
}

void main() {
  print('1. LIST\n');

  // a-c. (instruksi pembuatan file / folder modul_2 dan list.dart) --- tidak perlu kode

  // d. Buat code seperti contoh (contoh awal)
  // import 'dart:io'; (sudah di atas)
  List<String> names = ['Alfa', 'beta', 'Charlie'];
  print('Names: $names'); // Names: [Alfa, beta, Charlie]

  // e. Tambah data list
  names.add('Delta');
  print('Names setelah ditambahkan: $names'); // [Alfa, beta, Charlie, Delta]

  // f. Tampilkan data pada index tertentu
  print('Elemen pertama: ${names[0]}'); // Alfa
  print('Elemen kedua: ${names[1]}');  // beta

  // g. Mengubah data pada index tertentu
  names[1] = 'Bravo';
  print('Names setelah diubah: $names'); // [Alfa, Bravo, Charlie, Delta]

  // h. Hapus data tertentu (berdasarkan nilai)
  names.remove('Charlie');
  print('Names setelah dihapus: $names'); // [Alfa, Bravo, Delta]

  // i. Hitung jumlah data
  print('Jumlah data: ${names.length}'); // 3

  // j. Tampilkan semua data dengan looping
  print('Menampilkan setiap elemen:');
  for (String name in names) {
    print(name);
  }
  // k. Data yang dihasilkan adalah seperti contoh di modul (lihat output di atas)

  // -------------------------------------------------------
  // l. Membuat list dengan model input data (interaktif)
  print('\n--- Membuat list dengan input pengguna (bagian l) ---');
  List<String> dataList = [];
  print('Data list kosong: $dataList');

  int count = 0;
  while (count <= 0) {
    count = readInt('Masukkan jumlah list: ');
    if (count <= 0) {
      print('Masukkan angka lebih dari 0!');
    }
  }

  for (int i = 0; i < count; i++) {
    String x = readLine('data ke-${i + 1}: ');
    dataList.add(x);
  }

  print('Data list:');
  print(dataList);

  // -------------------------------------------------------
  // m. Buatkan dengan inputan untuk:
  //    - Tampil berdasarkan index tertentu
  //    - Ubah berdasarkan index tertentu
  //    - Hapus berdasarkan index tertentu
  //    - Tampilkan hasil akhir
  // Menu sederhana sesuai modul

  print('\n--- Bagian m: operasi berdasarkan index pada dataList ---');
  if (dataList.isEmpty) {
    print('dataList kosong, tidak ada operasi yang bisa dilakukan.');
  } else {
    bool selesai = false;
    while (!selesai) {
      print('\nPilih operasi:');
      print('1. Tampilkan berdasarkan index tertentu');
      print('2. Ubah berdasarkan index tertentu');
      print('3. Hapus berdasarkan index tertentu');
      print('4. Tampilkan semua data (hasil akhir)');
      print('0. Selesai / Keluar');
      int op = readInt('Masukkan pilihan: ', min: 0, max: 4);

      switch (op) {
        case 0:
          selesai = true;
          break;
        case 1:
          if (dataList.isEmpty) {
            print('dataList kosong.');
            break;
          }
          for (int i = 0; i < dataList.length; i++) {
            print('Index $i: ${dataList[i]}');
          }
          int idxShow = readInt('Masukkan index yang ingin ditampilkan: ', min: 0, max: dataList.length - 1);
          print('Elemen pada index $idxShow: ${dataList[idxShow]}');
          break;
        case 2:
          if (dataList.isEmpty) {
            print('dataList kosong.');
            break;
          }
          for (int i = 0; i < dataList.length; i++) {
            print('Index $i: ${dataList[i]}');
          }
          int idxUbah = readInt('Masukkan index yang ingin diubah: ', min: 0, max: dataList.length - 1);
          String newVal = readLine('Masukkan nilai baru untuk index $idxUbah: ');
          dataList[idxUbah] = newVal;
          print('DataList setelah diubah: $dataList');
          break;
        case 3:
          if (dataList.isEmpty) {
            print('dataList kosong.');
            break;
          }
          for (int i = 0; i < dataList.length; i++) {
            print('Index $i: ${dataList[i]}');
          }
          int idxDel = readInt('Masukkan index yang ingin dihapus: ', min: 0, max: dataList.length - 1);
          var removed = dataList.removeAt(idxDel);
          print('Menghapus "$removed". DataList sekarang: $dataList');
          break;
        case 4:
          print('\n=== SEMUA DATA ===');
          for (int i = 0; i < dataList.length; i++) {
            print('Index $i: ${dataList[i]}');
          }
          break;
        default:
          print('Pilihan tidak dikenali.');
      }
    }
  }

  // Tampilkan hasil akhir seperti contoh modul
  print('\n=== HASIL AKHIR ===');
  if (dataList.isEmpty) {
    print('dataList kosong.');
  } else {
    for (int i = 0; i < dataList.length; i++) {
      print('Index $i: ${dataList[i]}');
    }
  }

  print('\nSelesai. Terima kasih.');
}