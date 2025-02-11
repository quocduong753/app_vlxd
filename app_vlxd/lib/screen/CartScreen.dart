import 'package:app_vlxd/model/VatTuDetail.dart';
import 'package:app_vlxd/provide/CartProvider.dart';
import 'package:app_vlxd/screen/OrderScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<VatTuDetail> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    int totalSelectedPrice = _selectedItems
        .fold(0, (total, item) => total + item.gia);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Giỏ hàng',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: cartProvider.cartItems.isEmpty
          ? const Center(
        child: Text(
          'Giỏ hàng của bạn đang trống',
          style: TextStyle(fontSize: 16),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cartItems[index];
                final isSelected = _selectedItems.contains(item);
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.vatTu.image,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.vatTu.ten,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Đơn giá: ${item.vatTu.donGia} VND',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Tổng: ${item.gia} VND',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      if (item.soLuong > 1) {
                                        setState(() {
                                          item.soLuong--;
                                          item.gia =
                                              (item.vatTu.donGia *
                                                  item.soLuong)
                                                  .toInt();
                                        });
                                      }
                                    },
                                  ),
                                  Text(
                                    '${item.soLuong.toInt()}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        item.soLuong++;
                                        item.gia = (item.vatTu.donGia *
                                            item.soLuong)
                                            .toInt();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  cartProvider.removeFromCart(item.vatTu.ma);
                                });
                              },
                            ),
                            Checkbox(
                              value: isSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value == true) {
                                    _selectedItems.add(item);
                                  } else {
                                    _selectedItems.remove(item);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.teal,
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tổng cộng:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      '${totalSelectedPrice.toStringAsFixed(0)} VND',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: totalSelectedPrice > 0
                      ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderScreen(
                        isCart: true,
                          selectedItems: _selectedItems,
                          totalAmount: totalSelectedPrice,
                        ),
                      ),
                    );
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Đặt hàng',
                    style: TextStyle(
                      fontSize: 16,
                      color: totalSelectedPrice > 0
                          ? Colors.teal
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
