import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodorder_app/models/review_cart_model.dart';

class ReviewCartProvider with ChangeNotifier {
  void addReviewCartData({
    String? cartId,
    String? cartName,
    String? cartImage,
    String? cartPrice,
    int? cartQuantity,
    var cartUnit,
  }) async {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .set(
      {
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "cartUnit": cartUnit,
        "isAdd": true,
      },
    );
  }

  void updateReviewCartData({
    String? cartId,
    String? cartName,
    String? cartImage,
    String? cartPrice,
    int? cartQuantity,
  }) async {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .update(
      {
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "isAdd": true,
      },
    );
  }

  List<ReviewCartModel> reviewCartDataList = [];
  void getReviewCartData() async {
    List<ReviewCartModel> newList = [];

    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourReviewCart")
        .get();
    reviewCartValue.docs.forEach((element) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
        cartId: element.data().toString().contains('cartId')
            ? element.get('cartId')
            : '',
        cartImage: element.data().toString().contains('cartImage')
            ? element.get('cartImage')
            : '',
        cartName: element.data().toString().contains('cartName')
            ? element.get('cartName')
            : '',
        cartPrice: element.data().toString().contains('cartPrice')
            ? element.get('cartPrice')
            : '',
        cartQuantity: element.data().toString().contains('cartQuantity')
            ? element.get('cartQuantity')
            : '',
        cartUnit: element.get("cartUnit"),
      );
      newList.add(reviewCartModel);
    });
    reviewCartDataList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get getReviewCartDataList {
    return reviewCartDataList;
  }

//// TotalPrice  ///

  getTotalPrice() {
    double total = 0;
    reviewCartDataList.length > 0
        ? reviewCartDataList.forEach((element) {
            total += int.parse(element.cartPrice!) * element.cartQuantity!;
          })
        : [];
    return total.toStringAsFixed(0);
  }

  getTotalPaymentPrice({int? shipping}) {
    double total = 0;
    reviewCartDataList.length > 0
        ? reviewCartDataList.forEach((element) {
            total += int.parse(element.cartPrice!) * element.cartQuantity!;
          })
        : [];
    if (shipping != 0) {
      total = (total + shipping!);
    }
    return total.toStringAsFixed(0);
  }

////////////// ReviCartDeleteFunction ////////////
  Future<void> reviewCartDataDelete(cartId) async {
    try {
      var res = await FirebaseFirestore.instance
          .collection("ReviewCart")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("YourReviewCart")
          .doc(cartId)
          .delete();
      notifyListeners();
    } catch (e) {
      print("delete item in cart failed : ${e}");
    }
  }

  Future<void> deleteAllListCart() async {
    try {
      QuerySnapshot res = await FirebaseFirestore.instance
          .collection("ReviewCart")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("YourReviewCart")
          .get();

      res.docs.forEach((element) async {
        await FirebaseFirestore.instance
            .collection("ReviewCart")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("YourReviewCart")
            .doc(element.id)
            .delete();
      });
    } catch (e) {
      print("delete all cart failed : ${e}");
    }
  }
}
