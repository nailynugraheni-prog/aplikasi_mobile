import 'package:cobadulu/core/network/dio_client.dart';
import 'package:cobadulu/features/dosen/data/models/dosen_model.dart';
import 'package:dio/dio.dart';

class DosenRepository {
  final DioClient _dioClient;

  DosenRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  /// get data daftar dosen
  Future<List<DosenModel>> getDosenList() async {
    try {
      final Response response = await _dioClient.dio.get('/users');
      final List<dynamic> data = response.data;
      return data.map((json) => DosenModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(
        'Gagal memuat data dosen: ${e.response?.statusCode} - ${e.message}',
      );
    }
  }
}

////////dio
//import 'package:dio/dio.dart';
///import 'package:cobadulu/features/dosen/data/models/dosen_model.dart';

//class DosenRepository {
  //final Dio _dio = Dio(
    //BaseOptions(
      //baseUrl: 'https://jsonplaceholder.typicode.com',
      //headers: {'Accept': 'application/json'},
    //),
  //);

  //// Mendapatkan daftar dosen
  //Future<List<DosenModel>> getDosenList() async {
    //try {
      //final response = await _dio.get('/users');

      //if (response.statusCode == 200) {
        //final data = response.data as List<dynamic>;
        //print(data); // Debug
        //return data.map((json) => DosenModel.fromJson(json)).toList();
      //} else {
        //throw Exception('Gagal memuat data dosen: ${response.statusCode}');
      //}
    //} on DioException catch (e) {
      //print('Dio error: ${e.message}');
      //throw Exception('Gagal memuat data dosen: ${e.message}');
    //} catch (e) {
      //print('Error: $e');
      //throw Exception('Terjadi kesalahan: $e');
    //}
  //}
//}
////////////////////////http
//import 'dart:convert';
//import 'package:cobadulu/features/dosen/data/models/dosen_model.dart';
//import 'package:http/http.dart' as http;

//class DosenRepository {
  //// Mendapatkan daftar dosen
  //Future<List<DosenModel>> getDosenList() async {
    //final response = await http.get(
      //Uri.parse('https://jsonplaceholder.typicode.com/users'),
      //headers: {'Accept': 'application/json'},
    //);

    //if (response.statusCode == 200) {
      //final List<dynamic> data = jsonDecode(response.body);
      //print(data); // Debug: Tampilkan data yang sudah di-decode
      //return data.map((json) => DosenModel.fromJson(json)).toList();
    //} else {
      //print('Error: ${response.statusCode} - ${response.body}');
      //throw Exception('Gagal memuat data dosen: ${response.statusCode}');
    //}
  //}
//}