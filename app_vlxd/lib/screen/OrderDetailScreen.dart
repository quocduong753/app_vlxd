import 'package:app_vlxd/model/DonDatHang.dart';
import 'package:app_vlxd/model/KhachHang.dart';
import 'package:app_vlxd/services/KhachHangService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends StatefulWidget {
  final DonDatHang order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  KhachHang? _khachHang;

  @override
  void initState() {
    super.initState();
    _loadKhachHang();
  }

  Future<void> _loadKhachHang() async {
    final KhachHangService khService = KhachHangService();
    try {
      final KhachHang? fetchedKhachHang = await khService.getKhachHang();
      setState(() {
        _khachHang = fetchedKhachHang;
      });
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    String formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(order.ngayDat.toLocal());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chi tiết đơn hàng',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thông tin đơn hàng:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              SizedBox(height: 8),
              Text('Mã đơn hàng: ${order.ma}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 4),
              Text('Ngày đặt: $formattedDate', style: TextStyle(fontSize: 16)),
              SizedBox(height: 4),
              Text('Địa chỉ giao hàng: ${order.diaChiGiaoHang}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 4),
              Text(
                'Tổng tiền: ${order.tongTien} VND',
                style: TextStyle(fontSize: 16, color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Trạng thái: ${order.trangThai ? "Đã giao" : "Đang giao"}',
                style: TextStyle(
                  fontSize: 16,
                  color: order.trangThai ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              // Thông tin khách hàng
              if (_khachHang != null)
                Text(
                  'Thông tin khách hàng:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
              if (_khachHang != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tên: ${_khachHang!.tenKH}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 4),
                      Text('Email: ${_khachHang!.email}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 4),
                      Text('Số điện thoại: ${_khachHang!.dienThoai}', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              Divider(),
              Text(
                'Danh sách mua:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              SizedBox(height: 8),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: order.muaList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = order.muaList[index];
                    double itemTotalPrice = item.soLuong * item.gia;

                    return Card(
                      margin: EdgeInsets.only(bottom: 8.0),
                      elevation: 4,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 45,
                          backgroundImage: NetworkImage(item.vatTu.image),
                        ),
                        title: Text(item.vatTu.ten, style: TextStyle(fontSize: 16)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              'Giá: ${item.gia} VND',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Số lượng: ${item.soLuong} ${item.vatTu.dvt}', // Đơn vị tính phía sau số lượng
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 14,),
                            Text(
                              'Tổng: ${itemTotalPrice.toStringAsFixed(2)} VND', // Hiển thị tổng giá cho vật tư
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
    );
  }
}
