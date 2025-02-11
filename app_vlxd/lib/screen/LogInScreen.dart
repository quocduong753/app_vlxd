import 'package:app_vlxd/main.dart';
import 'package:app_vlxd/services/ApiService.dart';
import 'package:app_vlxd/model/KhachHang.dart';
import 'package:app_vlxd/screen/ForgotPasswordScreen.dart';
import 'package:app_vlxd/screen/RegisterScreen.dart';
import 'package:app_vlxd/services/KhachHangService.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});



  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  final KhachHangService khService = KhachHangService();


  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final KhachHang? khachHang = await khService.getKhachHang();

    if (khachHang != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Text(
                'Chào mừng bạn!',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Đăng nhập để tiếp tục',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Tên đăng nhập',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: !isPasswordVisible, // Ẩn/hiện mật khẩu
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                  },
                  child: const Text('Quên mật khẩu?'),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  String username = usernameController.text.trim();
                  String password = passwordController.text.trim();

                  if (username.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin!')),
                    );
                  } else {
                    try {
                      final data = await khService.login(username, password);
                      if (data['code'] == 1000) {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MainScreen()));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Đăng nhập thành công')),
                        );
                      } else if (data['code'] == 4006) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Mật khẩu không đúng')),
                        );
                      } else if (data['code'] == 4005) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tên đăng nhập không tồn tại')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Lỗi đăng nhập')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Có lỗi xảy ra, vui lòng thử lại')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Bạn chưa có tài khoản?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                    },
                    child: const Text('Đăng ký ngay'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}