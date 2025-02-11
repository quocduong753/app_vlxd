import 'dart:convert';

import 'package:app_vlxd/model/KhachHang.dart';
import 'package:app_vlxd/services/ApiService.dart';
import 'package:http/http.dart' as http;


class KhachHangService extends ApiService {

  Future<Map<String, dynamic>> login(String userName, String pass) async {
    final url = Uri.parse('${ApiService.baseUrl}khachhang/login');

    final Map<String, dynamic> loginData = {
      'userName': userName,
      'pass': pass,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(loginData),
    );
    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> data = json.decode(decodedBody);
    if(data['code']==1000){
      await saveToken(data['result']['token']);
    }
    return data;

  }

  Future<KhachHang?> getKhachHang() async {
    final String? token = await getToken(); // Lấy token từ SharedPreferences

    if (token == null) {
      return null;
    }

    final url = Uri.parse('${ApiService.baseUrl}khachhang/getKhachHang');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> data = json.decode(decodedBody);

    if (response.statusCode == 200) {
      return KhachHang.fromJson(data['result']);
    } else {
      throw Exception('Lỗi khi lấy dữ liệu khách hàng: ${data['message']}');
    }
  }

  Future<Map<String, dynamic>> register(KhachHang khachHang) async {
    final url = Uri.parse('${ApiService.baseUrl}khachhang');

    final Map<String, dynamic> registerData = khachHang.toJson();

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(registerData),
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> data = json.decode(decodedBody);
    return data;
  }

  Future<Map<String, dynamic>> updateKhachHang(KhachHang khachHang) async {
    final String? token = await getToken();
    final url = Uri.parse('${ApiService.baseUrl}khachhang');

    final Map<String, dynamic> registerData = khachHang.toJson();

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: json.encode(registerData),
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> data = json.decode(decodedBody);
    return data;
  }

  Future<Map<String, dynamic>> chagePasswordKhachHang(oldPassword, newPassword) async {
    final String? token = await getToken();
    final url = Uri.parse('${ApiService.baseUrl}khachhang/udatePassword');

    final Map<String, dynamic> registerData = {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: json.encode(registerData),
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> data = json.decode(decodedBody);
    return data;
  }
}