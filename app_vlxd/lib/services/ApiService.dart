import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.4:8088/vatlieuxaydung/';
  Future<List<T>> fetchData<T>(String endpoint, T Function(Map<String, dynamic>) fromJson) async {
    final response = await http.get(Uri.parse(baseUrl + endpoint));

    if (response.statusCode == 200) {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> data = json.decode(decodedBody);
      List<dynamic> result = data['result'];

      return result.map((json) => fromJson(json)).toList();
    } else {
      throw Exception('Không thể tải dữ liệu từ endpoint $endpoint');
    }
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // Lấy token từ SharedPreferences
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

}