import 'package:app_vlxd/model/DonDatHang.dart';
import 'package:app_vlxd/screen/OrderDetailScreen.dart';
import 'package:app_vlxd/services/DonDatHangService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllOrdersScreen extends StatefulWidget {

  const AllOrdersScreen({Key? key}) : super(key: key);

  @override
  _AllOrdersScreenState createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  late Future<List<DonDatHang>> _futureOrders;

  @override
  void initState() {
    super.initState();
    _futureOrders = _fetchOrders();
  }

  Future<List<DonDatHang>> _fetchOrders() async {
    try {
      final donDatHangService = DonDatHangService();
      return await donDatHangService.GetOrder();
    } catch (error) {
      throw Exception('Không thể tải dữ liệu: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách đơn hàng', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<DonDatHang>>(
        future: _futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi khi tải dữ liệu: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Không có đơn hàng nào.'));
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Text(
                      '${index + 1}.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.teal,
                      ),
                    ),
                    title: Text(
                      "Địa chỉ: ${order.diaChiGiaoHang}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text('Ngày đặt: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(order.ngayDat.toLocal()) }'),
                        SizedBox(height: 4),
                        Text(
                          'Trạng thái: ${order.trangThai ? "Đã giao" : "Đang giao"}',
                          style: TextStyle(
                            color: order.trangThai ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(
                      '${order.tongTien.toStringAsFixed(2)} VND',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailScreen(order: order),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
