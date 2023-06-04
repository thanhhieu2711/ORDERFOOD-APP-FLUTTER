import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodorder_app/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductModel? productModel;

  List<ProductModel> search = [];
  productModels(QueryDocumentSnapshot element) {
    productModel = ProductModel(
      productImage: element.data().toString().contains('productImage')
          ? element.get('productImage')
          : '',
      productName: element.data().toString().contains('productName')
          ? element.get('productName')
          : '',
      productPrice: element.data().toString().contains('productPrice')
          ? element.get('productPrice')
          : '',
      productId: element.id,
      productDes: element.data().toString().contains('productDes')
          ? element.get('productDes')
          : '',
    );
    search.add(productModel!);
  }

  /////////////// Fast ///////////////////////////////
  List<ProductModel> fastProductsList = [];

  fetchFastFoodData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("Fast").get();

    value.docs.forEach(
      (element) {
        productModels(element);

        newList.add(productModel!);
      },
    );
    fastProductsList = newList;
    notifyListeners();
  }

  List<ProductModel> get getFastFoodDataList {
    return fastProductsList;
  }

//////////////// Drinks ///////////////////////////////////////

  List<ProductModel> drinkList = [];

  fetchDrinksData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("Drinks").get();

    value.docs.forEach(
      (element) {
        productModels(element);
        newList.add(productModel!);
      },
    );
    drinkList = newList;
    notifyListeners();
  }

  List<ProductModel> get getDrinkDataList {
    return drinkList;
  }

//////////////// All Product ///////////////////////////////////////

  List<ProductModel> productsList = [];

  fetchAllProductsData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("Products").get();

    value.docs.forEach(
      (element) {
        productModels(element);
        newList.add(productModel!);
      },
    );
    productsList = newList;
    notifyListeners();
  }

  List<ProductModel> get getRootProductDataList {
    return productsList;
  }

  /////////////////// Search Return ////////////
  List<ProductModel> get getAllProductSearch {
    return search;
  }
}
