import 'package:app_vlxd/model/DonDatHang.dart';
import 'package:app_vlxd/model/KhachHang.dart';
import 'package:app_vlxd/model/VatTuDetail.dart';
import 'package:app_vlxd/provide/CartProvider.dart';
import 'package:app_vlxd/services/DonDatHangService.dart';
import 'package:app_vlxd/services/KhachHangService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  final List<VatTuDetail> selectedItems;
  final int totalAmount;
  final bool isCart;


  const OrderScreen({
    Key? key,
    required this.selectedItems,
    required this.totalAmount,
    required this.isCart,
  }) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final TextEditingController _addressController = TextEditingController();
  final DonDatHangService _datHangService = DonDatHangService();
  KhachHang? khachHang;
  late BuildContext _orderScreenContext;

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
        khachHang = fetchedKhachHang;
      });
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    _orderScreenContext = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đặt hàng',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            khachHang == null
                ? const Center(child: CircularProgressIndicator())
                : Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tên: ${khachHang!.tenKH}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Email: ${khachHang!.email}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Số điện thoại: ${khachHang!.dienThoai}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Divider(height: 24, thickness: 1),
                ],
              ),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Địa chỉ giao hàng',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Danh sách mua:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.selectedItems.length,
              itemBuilder: (context, index) {
                final item = widget.selectedItems[index];
                final String donViTinh = item.vatTu.dvt;
                final double donGia = item.vatTu.donGia;
                final int soLuong = item.soLuong.toInt();
                final int thanhTien = item.gia;

                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.vatTu.image,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.vatTu.ten,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Đơn giá: ${donGia.toStringAsFixed(0)} VND / $donViTinh',
                                style: const TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Số lượng: $soLuong $donViTinh',
                                style: const TextStyle(fontSize: 14, color: Colors.black54),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Thành tiền: ${thanhTien.toStringAsFixed(0)} VND',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tổng cộng: ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                Text(
                  '${widget.totalAmount.toStringAsFixed(0)} VND',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_addressController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Vui lòng nhập địa chỉ giao hàng'),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Xác nhận đặt hàng'),
                      content: const Text('Bạn có chắc chắn muốn đặt hàng không?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Hủy'),
                        ),
                        TextButton(
                          onPressed: () async {
                            try{
                              DonDatHang ddh = DonDatHang(ma: "",
                                  ngayDat: DateTime.now(),
                                  diaChiGiaoHang: _addressController.text,
                                  tongTien: widget.totalAmount,
                                  trangThai: false,
                                  muaList: widget.selectedItems);
                              final response = await _datHangService.order(ddh);

                            }catch(error){
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Lỗi khi đặt hàng: $error')),
                              );
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Đặt hàng thành công')),
                            );
                            if(widget.isCart){
                              Provider.of<CartProvider>(context, listen: false).removeItems(widget.selectedItems);
                            }
                            Navigator.pop(_orderScreenContext);
                            Navigator.pop(_orderScreenContext);
                          },
                          child: const Text('Đặt hàng'),
                        ),
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Center(
                child: Text(
                  'Xác nhận đặt hàng',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
