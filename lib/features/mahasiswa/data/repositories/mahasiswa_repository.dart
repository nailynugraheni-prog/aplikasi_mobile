///////////dio
import 'package:dio/dio.dart';
import 'package:cobadulu/features/mahasiswa/data/models/mahasiswa_model.dart';

class MahasiswaRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      headers: {'Accept': 'application/json'},
    ),
  );

  Future<List<MahasiswaModel>> getMahasiswaList() async {
    try {
      final response = await _dio.get('/comments');

      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        print(data);
        return data.map((json) => MahasiswaModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data mahasiswa: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      throw Exception('Gagal memuat data mahasiswa: ${e.message}');
    }
  }
}
////////http
//import 'dart:convert';
//import 'package:cobadulu/features/mahasiswa/data/models/mahasiswa_model.dart';
//import 'package:http/http.dart' as http;

//class MahasiswaRepository {
  //// Mendapatkan daftar mahasiswa/komentar
  //Future<List<MahasiswaModel>> getMahasiswaList() async {
    //final response = await http.get(
      //Uri.parse('https://jsonplaceholder.typicode.com/comments'),
      //headers: {'Accept': 'application/json'},
    //);

    //if (response.statusCode == 200) {
      //final List<dynamic> data = jsonDecode(response.body);
      //print(data); // Debug: tampilkan data hasil decode
      //return data.map((json) => MahasiswaModel.fromJson(json)).toList();
    //} else {
      //print('Error: ${response.statusCode} - ${response.body}');
      //throw Exception('Gagal memuat data mahasiswa: ${response.statusCode}');
    //}
 // }
//}