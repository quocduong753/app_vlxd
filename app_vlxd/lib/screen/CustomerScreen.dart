import 'package:app_vlxd/screen/AllOrderScreen.dart';
import 'package:app_vlxd/screen/ChangePassword.dart';
import 'package:app_vlxd/services/ApiService.dart';
import 'package:app_vlxd/model/KhachHang.dart';
import 'package:app_vlxd/screen/EditCustommerScreen.dart';
import 'package:app_vlxd/screen/LogInScreen.dart';
import 'package:app_vlxd/services/KhachHangService.dart';
import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final KhachHangService khService = KhachHangService();
  KhachHang? khachHang;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCustomerData();
  }

  Future<void> fetchCustomerData() async {
    try {
      final KhachHang? fetchedKhachHang = await khService.getKhachHang();
      setState(() {
        khachHang = fetchedKhachHang;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> logout() async {
    khService.removeToken();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin tài khoản', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
          automaticallyImplyLeading: false
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : khachHang == null
          ? Center(child: Text('Không có thông tin khách hàng'))
          : SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.teal.shade700,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      khachHang!.userName,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        'Tên:',
                        khachHang!.tenKH,
                        Icons.account_circle,
                      ),
                      _buildInfoRow(
                        'Email:',
                        khachHang!.email,
                        Icons.email,
                      ),
                      _buildInfoRow(
                        'Địa chỉ:',
                        khachHang!.diaChi,
                        Icons.location_on,
                      ),
                      _buildInfoRow(
                        'Giới tính:',
                        khachHang!.gioiTinh,
                        Icons.wc,
                      ),
                      _buildInfoRow(
                        'Ngày sinh:',
                        khachHang!.ngaySinh,
                        Icons.calendar_today,
                      ),
                      _buildInfoRow(
                        'Điện thoại:',
                        khachHang!.dienThoai,
                        Icons.phone,
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllOrdersScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.inventory_2,
                              color: Colors.teal,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Xem tất cả đơn hàng',
                              style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          final updateKhachHang =
                          await Navigator.push<KhachHang>(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditCustomerScreen(khachHang: khachHang),
                            ),
                          );

                          if (updateKhachHang != null) {
                            setState(() {
                              khachHang = updateKhachHang;
                            });
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.teal,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Sửa thông tin',
                              style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePasswordScreen(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock, // Icon đổi mật khẩu
                              color: Colors.teal,
                            ),
                            SizedBox(width: 8), // Khoảng cách giữa icon và text
                            Text(
                              'Đổi mật khẩu',
                              style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: logout,
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text(
                  'Đăng xuất',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildInfoRow(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              '$title $value',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
