import 'package:app_vlxd/services/ApiService.dart';
import 'package:app_vlxd/model/KhachHang.dart';
import 'package:app_vlxd/screen/LogInScreen.dart';
import 'package:app_vlxd/services/KhachHangService.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final KhachHangService khService = KhachHangService();
  String selectedGender = 'Nam';
  DateTime? selectedDate;

  String? nameError;
  String? usernameError;
  String? emailError;
  String? passwordError;
  String? addressError;
  String? phoneError;
  String? dateError;

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateError = null;
      });
    }
  }

  Future<void> _register() async {
    String name = nameController.text.trim();
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String address = addressController.text.trim();
    String phone = phoneController.text.trim();

    setState(() {
      nameError = null;
      usernameError = null;
      emailError = null;
      passwordError = null;
      addressError = null;
      phoneError = null;
      dateError = null;
    });

    bool isValid = true;

    if (name.isEmpty) {
      setState(() {
        nameError = 'Vui lòng nhập họ và tên';
      });
      isValid = false;
    }

    if (username.isEmpty) {
      setState(() {
        usernameError = 'Vui lòng nhập tên tài khoản';
      });
      isValid = false;
    }

    if (email.isEmpty || !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$').hasMatch(email)) {
      setState(() {
        emailError = 'Email không hợp lệ';
      });
      isValid = false;
    }

    if (password.isEmpty || password.length < 8) {
      setState(() {
        passwordError = 'Mật khẩu phải có ít nhất 8 ký tự';
      });
      isValid = false;
    }

    if (address.isEmpty) {
      setState(() {
        addressError = 'Vui lòng nhập địa chỉ';
      });
      isValid = false;
    }

    if (phone.isEmpty) {
      setState(() {
        phoneError = 'Vui lòng nhập số điện thoại';
      });
      isValid = false;
    }

    if (selectedDate == null || selectedDate!.year == DateTime.now().year) {
      setState(() {
        dateError = 'Ngày sinh không hợp lệ';
      });
      isValid = false;
    }

    if (isValid) {
      KhachHang khachHang = KhachHang(
          tenKH: name,
          userName: username,
          email: email,
          diaChi: address,
          gioiTinh: selectedGender,
          ngaySinh: "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}",
          dienThoai: phone,
          password: password);

      try {
        var response = await khService.register(khachHang);
        if(response['code'] == 4001){
          setState(() {
            usernameError = 'Tên tài khoản đã tồn tại';
          });
        }
        if (response['code'] == 1000) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đăng ký thành công!')),
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đã xảy ra lỗi!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng ký tài khoản'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Họ và Tên',
                errorText: nameError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Tên tài khoản',
                errorText: usernameError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: emailError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
                errorText: passwordError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Địa chỉ',
                errorText: addressError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Giới tính:'),
                DropdownButton<String>(
                  value: selectedGender,
                  items: ['Nam', 'Nữ'].map((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Ngày sinh:'),
                Text(selectedDate == null
                    ? 'Chọn ngày'
                    : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Chọn ngày'),
                ),
              ],
            ),
            if (dateError != null) ...[
              const SizedBox(height: 8),
              Text(
                dateError!,
                style: TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Số điện thoại',
                errorText: phoneError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Đăng ký',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}