import 'dart:convert';
import 'dart:math';

import 'package:app_vlxd/provide/CartProvider.dart';
import 'package:app_vlxd/screen/CartScreen.dart';
import 'package:app_vlxd/screen/CustomerScreen.dart';
import 'package:app_vlxd/screen/LogInScreen.dart';
import 'package:app_vlxd/screen/ProductDetailScreen.dart';
import 'package:app_vlxd/model/VatTu.dart';
import 'package:app_vlxd/services/VatTuService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<VatTu> vatTuList = [];

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => CartProvider(),
    child: BuildingMaterialApp(),
  ));
}

class BuildingMaterialApp extends StatelessWidget {
  const BuildingMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final List<Widget> screens = [
    const HomePage(),
    CustomerScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex], // Hiển thị màn hình hiện tại
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản'),
        ],
        currentIndex: currentIndex,
        onTap: onTabTapped,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  final VatTuService vatTuService = VatTuService();
  List<VatTu> searchResults = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchVatTu();
  }

  Future<void> fetchVatTu() async {
    try {
      final List<VatTu> data = await vatTuService.fetchVatTu();
      setState(() {
        vatTuList = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Có lỗi khi tải
      });
      print('Lỗi khi tải dữ liệu: $e');
      throw Exception('Không thể tải dữ liệu');
    }
  }

  Future<void> searchProducts(String keyword) async {
    setState(() {
      searchQuery = keyword;
    });
    try {
      final List<VatTu> results = await vatTuService.searchVatTu(keyword);
      setState(() {
        searchResults = results;
      });
    } catch (e) {
      setState(() {
        searchResults = [];
      });
      print('Lỗi khi tìm kiếm: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            elevation: 10,
            title: searchQuery.isNotEmpty
                ? Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.teal),
                        onPressed: () {
                          setState(() {
                            searchQuery = '';
                            searchResults = [];
                          });
                        },
                      ),
                      Expanded(
                        child: SearchBar(onSearch: searchProducts),
                      ),
                    ],
                  )
                : SearchBar(onSearch: searchProducts),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              if (searchQuery.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Kết quả tìm kiếm cho "$searchQuery"',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                searchResults.isEmpty
                    ? Center(
                        child: Text(
                          "Không có sản phẩm phù hợp",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            final product = searchResults[index];
                            return ProductItem(product: product);
                          },
                        ),
                      ),
              ] else ...[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BannerWidget(),
                        SizedBox(height: 16),
                        RecommendedProducts(),
                        SizedBox(height: 16),
                        AllProducts(isLoading: isLoading),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
          Positioned(
              right: 16,
              bottom: 16,
              child: Stack(
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()),
                      );
                    },
                    backgroundColor: Colors.teal,
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  Positioned(
                      right: 1,
                      top: -2,
                      child: Consumer<CartProvider>(
                        builder: (context, cartProvider, child) {
                          return cartProvider.getTotal > 0
                              ? Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${cartProvider.getTotal}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : SizedBox();
                        },
                      ))
                ],
              )),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final VatTu product;

  ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: product)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Image.network(product.image,
                height: 80, width: 80, fit: BoxFit.cover),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.ten,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('${product.donGia} đ',
                    style: TextStyle(fontSize: 16, color: Colors.green)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const SearchBar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Container(
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
          Container(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                final keyword = searchController.text.trim();
                if (keyword.isNotEmpty) {
                  onSearch(keyword);
                }
              },
              child:
                  Icon(Icons.search, color: Colors.white), // Đổi màu của icon
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Hình ảnh banner
        Container(
          height: 150,
          width: double.infinity,
          child: Image.network(
            'https://bizweb.dktcdn.net/100/387/417/themes/765499/assets/slider_2.jpg?1722254739294',
            fit: BoxFit.cover,
          ),
        ),

        Positioned(
          bottom: 16,
          left: 16,
          child: Text(
            'Vật liệu xây dựng',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RecommendedProducts extends StatelessWidget {
  const RecommendedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    if (vatTuList.isEmpty) {
      return Center(
          child: const Text(
        "Không có sản phẩm đề xuất",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ));
    }

    final random = Random();
    final Set<int> selectedIndices = {};
    final List<VatTu> recommendedList = [];

    while (recommendedList.length < 8 &&
        recommendedList.length < vatTuList.length) {
      int randomIndex = random.nextInt(vatTuList.length);
      if (!selectedIndices.contains(randomIndex)) {
        selectedIndices.add(randomIndex);
        recommendedList.add(vatTuList[randomIndex]);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Sản phẩm đề xuất',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recommendedList.length,
            itemBuilder: (context, index) {
              final product = recommendedList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: product)));
                },
                child: Container(
                  width: 120,
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(product.image,
                          height: 80, width: 120, fit: BoxFit.cover),
                      SizedBox(height: 8),
                      Text(product.ten,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('${product.donGia} đ',
                          style: TextStyle(fontSize: 14, color: Colors.green)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class AllProducts extends StatelessWidget {
  final bool isLoading;

  AllProducts({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Tất cả sản phẩm',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: vatTuList.length,
                itemBuilder: (context, index) {
                  final product = vatTuList[index];
                  return ProductItem(product: product);
                },
              ),
      ],
    );
  }
}
