import 'package:app_vlxd/services/KhachHangService.dart';
import 'package:flutter/material.dart';
import 'package:app_vlxd/model/KhachHang.dart';
import 'package:intl/intl.dart';


class EditCustomerScreen extends StatefulWidget {
  final KhachHang? khachHang;

  EditCustomerScreen({required this.khachHang});

  @override
  _EditCustomerScreenState createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _tenController = TextEditingController();
  TextEditingController _ngaySinhController = TextEditingController();
  TextEditingController _dienThoaiController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _diaChiController = TextEditingController();
  String? _gioiTinh;

  @override
  void initState() {
    super.initState();
    _tenController.text = widget.khachHang?.tenKH ?? '';
    _ngaySinhController.text = widget.khachHang?.ngaySinh ?? '';
    _dienThoaiController.text = widget.khachHang?.dienThoai ?? '';
    _emailController.text = widget.khachHang?.email ?? '';
    _diaChiController.text = widget.khachHang?.diaChi ?? '';
    _gioiTinh = widget.khachHang?.gioiTinh;
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.teal,
            colorScheme: ColorScheme.light(primary: Colors.teal),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _ngaySinhController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _updateCustomer() async {
    if (_formKey.currentState!.validate()) {
      KhachHang updatedCustomer = KhachHang(
        maKH: widget.khachHang?.maKH,
        tenKH: _tenController.text,
        userName: widget.khachHang?.userName ?? '',
        email: _emailController.text,
        diaChi: _diaChiController.text,
        gioiTinh: _gioiTinh ?? '',
        ngaySinh: _ngaySinhController.text,
        dienThoai: _dienThoaiController.text,
      );

      try {
        var response = await KhachHangService().updateKhachHang(updatedCustomer);
        if (response['code'] == 1000) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cập nhật thông tin thành công!')));
          Navigator.pop(context, updatedCustomer);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đã xảy ra lỗi!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sửa thông tin', style:TextStyle(color: Colors.white),),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.teal[50],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.person, color: Colors.teal),
                        SizedBox(width: 18),
                        Text(
                          '${widget.khachHang?.userName ?? ''}',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Tên
                  TextFormField(
                    controller: _tenController,
                    decoration: InputDecoration(
                      labelText: 'Tên',
                      prefixIcon: Icon(Icons.account_circle),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Ngày sinh
                  TextFormField(
                    controller: _ngaySinhController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Ngày sinh',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(),
                    ),
                    onTap: () => _selectDate(context),
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: _dienThoaiController,
                    decoration: InputDecoration(
                      labelText: 'Số điện thoại',
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập số điện thoại';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: _diaChiController,
                    decoration: InputDecoration(
                      labelText: 'Địa chỉ',
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập địa chỉ';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: _gioiTinh,
                    decoration: InputDecoration(
                      labelText: 'Giới tính',
                      prefixIcon: Icon(Icons.wc),
                      border: OutlineInputBorder(),
                    ),
                    items: ['Nam', 'Nữ', 'Khác']
                        .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _gioiTinh = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng chọn giới tính';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _updateCustomer,
                        icon: Icon(Icons.check, color: Colors.white,),
                        label: Text('Xác nhận'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close, color: Colors.white,),
                        label: Text('Hủy'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
    );
  }
}
