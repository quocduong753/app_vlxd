import 'package:app_vlxd/services/KhachHangService.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final KhachHangService khService = KhachHangService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? oldPasswordError;

  String? validateOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu hiện tại';
    }
    return oldPasswordError;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu mới';
    }
    if (value.length < 8) {
      return 'Mật khẩu mới phải dài hơn 6 ký tự';
    }
    if (value == oldPasswordController.text) {
      return 'Mật khẩu mới không được trùng với mật khẩu hiện tại';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập lại mật khẩu mới';
    }
    if (value != newPasswordController.text) {
      return 'Mật khẩu mới không khớp';
    }
    return null;
  }

  Future<void> changePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        oldPasswordError = null;
      });

      final result = await khService.chagePasswordKhachHang(
        oldPasswordController.text,
        newPasswordController.text,
      );

      if (result['code'] == 4006) {
        setState(() {
          oldPasswordError = 'Mật khẩu không đúng';
        });
        _formKey.currentState!.validate();
      } else if (result['code'] == 1000) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đổi mật khẩu thành công')),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đổi mật khẩu', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: oldPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu hiện tại',
                  border: OutlineInputBorder(),
                  errorText: oldPasswordError,
                ),
                validator: validateOldPassword,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu mới',
                  border: OutlineInputBorder(),
                ),
                validator: validateNewPassword,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Nhập lại mật khẩu mới',
                  border: OutlineInputBorder(),
                ),
                validator: validateConfirmPassword,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: changePassword,
                child: Text('Xác nhận'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
