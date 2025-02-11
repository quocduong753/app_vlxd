import 'dart:convert';
import 'package:app_vlxd/model/DonDatHang.dart';
import 'package:app_vlxd/services/ApiService.dart';
import 'package:http/http.dart' as http;
class DonDatHangService extends ApiService{

  Future<Map<String, dynamic>> order(DonDatHang dondathang) async {
    final url = Uri.parse('${ApiService.baseUrl}dondathang');
    final String? token = await getToken();
    final Map<String, dynamic> registerData = dondathang.toJson();

    // Gửi yêu cầu POST
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(registerData),
    );

    final String decodedBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> data = json.decode(decodedBody);
    return data;
  }

  Future<List<DonDatHang>> GetOrder() async {
    final url = Uri.parse('${ApiService.baseUrl}dondathang/getDonHang');
    final String? token = await getToken();

    // Gửi yêu cầu POST
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      }
    );

    if (response.statusCode == 200) {
      final String decodedBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> data = json.decode(decodedBody);
      List<dynamic> result = data['result'];
      return result.map((json) => DonDatHang.fromJson(json)).toList();
    } else {
      throw Exception('Không thể tải dữ liệu');
    }

  }
}