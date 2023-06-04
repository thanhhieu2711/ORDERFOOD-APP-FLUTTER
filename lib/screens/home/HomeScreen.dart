import 'package:flutter/material.dart';
import 'package:foodorder_app/screens/ReviewCart/ListCart.dart';
import 'package:foodorder_app/screens/detail/ProductDetail.dart';
import 'package:foodorder_app/screens/home/DrawerSide.dart';
import 'package:foodorder_app/screens/home/ProductCart.dart';
import 'package:foodorder_app/screens/search/Search.dart';
import 'package:foodorder_app/providers/product_provider.dart';
import 'package:foodorder_app/providers/user_provider.dart';
import 'package:foodorder_app/screens/widgets/SingleItem.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductProvider? productProvider;
  Widget _buildFastProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Món ăn nhanh',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider!.getFastFoodDataList,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Xem thêm',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider!.getFastFoodDataList.map(
              (fastFoodData) {
                return ProductCart(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(
                          productId: fastFoodData.productId,
                          productPrice: fastFoodData.productPrice,
                          productName: fastFoodData.productName,
                          productImage: fastFoodData.productImage,
                          productDes: fastFoodData.productDes,
                        ),
                      ),
                    );
                  },
                  productId: fastFoodData.productId,
                  productPrice: fastFoodData.productPrice,
                  productImage: fastFoodData.productImage,
                  productName: fastFoodData.productName,
                );
              },
            ).toList(),
            // children: [

            // ],
          ),
        ),
      ],
    );
  }

  Widget _buildDrinksProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nước uống',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider!.getDrinkDataList,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Xem thêm',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider!.getDrinkDataList.map(
              (data) {
                return ProductCart(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(
                          productId: data.productId,
                          productPrice: data.productPrice,
                          productName: data.productName,
                          productImage: data.productImage,
                          productDes: data.productDes,
                        ),
                      ),
                    );
                  },
                  productId: data.productId,
                  productPrice: data.productPrice,
                  productImage: data.productImage,
                  productName: data.productName,
                );
              },
            ).toList(),
            // children: [

            // ],
          ),
        ),
      ],
    );
  }

  Widget _buildOthersProduct(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Còn nữa...',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Search(
                        search: productProvider!.getRootProductDataList,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Xem thêm',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productProvider!.getRootProductDataList.map(
              (data) {
                return ProductCart(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(
                          productId: data.productId,
                          productPrice: data.productPrice,
                          productName: data.productName,
                          productImage: data.productImage,
                          productDes: data.productDes,
                        ),
                      ),
                    );
                  },
                  productId: data.productId,
                  productPrice: data.productPrice,
                  productImage: data.productImage,
                  productName: data.productName,
                );
              },
            ).toList(),
            // children: [

            // ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    ProductProvider initProductProvider = Provider.of(context, listen: false);
    initProductProvider.fetchDrinksData();
    initProductProvider.fetchFastFoodData();
    initProductProvider.fetchAllProductsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    return Scaffold(
        drawer: DrawerSide(userProvider: userProvider),
        backgroundColor: Color.fromARGB(255, 245, 245, 245),
        // drawer: DrawerSide(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color.fromRGBO(2, 134, 17, 1)),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 0.3,
          actions: [
            CircleAvatar(
              child: GestureDetector(
                child: Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.white,
                ),
                onTap: () => {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Search()))
                },
              ),
              backgroundColor: Color.fromRGBO(2, 134, 17, 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CircleAvatar(
                backgroundColor: Color.fromRGBO(2, 134, 17, 1),
                child: GestureDetector(
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 20,
                    color: Colors.white,
                  ),
                  onTap: () => {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ListCart()))
                  },
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: ListView(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage("https://i.imgur.com/roWDfjQ.png"))),
              ),
              _buildFastProduct(context),
              _buildDrinksProduct(context),
              _buildOthersProduct(context),
            ],
          ),
        ));
  }
}
