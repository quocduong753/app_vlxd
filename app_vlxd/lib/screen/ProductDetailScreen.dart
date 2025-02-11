import 'package:app_vlxd/model/VatTuDetail.dart';
import 'package:app_vlxd/provide/CartProvider.dart';
import 'package:app_vlxd/model/VatTu.dart';
import 'package:app_vlxd/screen/OrderScreen.dart';
import 'package:app_vlxd/services/VatTuService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final VatTu product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  final VatTuService vatTuService = VatTuService();
  List<VatTu> similarProducts = [];
  TextEditingController quantityController = TextEditingController();
  FocusNode quantityFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    fetchSimilarProducts();
    quantityController.text = '$quantity';
  }

  @override
  void dispose() {
    quantityFocusNode.dispose();
    super.dispose();
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
      quantityController.text = '$quantity';
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        quantityController.text = '$quantity';
      });
    }
  }

  Future<void> fetchSimilarProducts() async {
    try {
      final String key = widget.product.ten.split(' ').first;
      final List<VatTu> data = await vatTuService.searchVatTu(key);
      setState(() {
        similarProducts = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Không thể tải danh sách sản phẩm liên quan.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.ten,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hiển thị chi tiết sản phẩm
              Image.network(
                product.image,
                height: 280,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text(
                'Mã sản phẩm: ${product.ma}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                product.ten,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Giá: ${product.donGia} đ/${product.dvt}',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Số lượng:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(width: 16),
                  Container(
                    height: 40,
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: decrementQuantity,
                        ),
                        Expanded(
                          child: TextField(
                            controller: quantityController,
                            focusNode: quantityFocusNode,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onTap: () {
                              setState(() {
                                quantity=0;
                                quantityController.text = "0";
                              });
                            },
                            onChanged: (value) {
                              if(value != "0"){
                                value = value.replaceAll(RegExp(r'^0+'), '');
                                quantityController.text="$value";
                              }
                                final int? newQuantity = int.tryParse(value);
                                if (newQuantity != null && newQuantity > 0) {
                                  setState(() {
                                    quantity = newQuantity;
                                  });
                                }
                                else if (value.isEmpty) {
                                  setState(() {
                                    quantityController.text="0";
                                    quantity = 0;
                                  });
                                }
                            },
                            onEditingComplete: () {
                              if (quantity == 0 ||
                                  quantityController.text.isEmpty
                              ) {
                                setState(() {
                                  quantity = 1;
                                  quantityController.text = "$quantity";
                                });
                              }
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: incrementQuantity,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    '${widget.product.dvt}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),//
              SizedBox(height: 16),
              Text(
                'Loại vật tư: ${product.loaiVT.tenLoai}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if(quantity>0){
                          VatTuDetail vtDetail = VatTuDetail.fromVatTu(widget.product, quantity.toDouble());
                          Provider.of<CartProvider>(context, listen: false).addToCart(vtDetail);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${widget.product.ten} đã được thêm vào giỏ hàng.'),
                            ),
                          );
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Vui lòng nhập số lượng hợp lệ.'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Thêm vào giỏ hàng',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if(quantity > 0){
                          VatTuDetail vtDetail = VatTuDetail.fromVatTu(widget.product, quantity.toDouble());
                          List<VatTuDetail> ds = [vtDetail];
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>OrderScreen(isCart: false,selectedItems: ds, totalAmount: vtDetail.gia)));
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Vui lòng nhập số lượng",
                            ),
                          ));
                        }
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Đặt hàng',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),

              Text(
                'Sản phẩm liên quan',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              similarProducts.isEmpty
                  ? Center(
                child: Text(
                  'Không có sản phẩm liên quan.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: similarProducts.length,
                itemBuilder: (context, index) {
                  final VatTu similarProduct = similarProducts[index];
                  return ListTile(
                    leading: Image.network(
                      similarProduct.image,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(similarProduct.ten),
                    subtitle: Text('${similarProduct.donGia} đ/${similarProduct.dvt}'),
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(product: similarProduct),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}