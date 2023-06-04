import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodorder_app/models/review_cart_model.dart';
import 'package:foodorder_app/providers/review_cart_provider.dart';
import 'package:foodorder_app/providers/wishlist_provider.dart';
import 'package:foodorder_app/screens/check-out/delivery-detail/DeliveryDetail.dart';
import 'package:foodorder_app/screens/widgets/SingleItem.dart';
import 'package:provider/provider.dart';

class ListCart extends StatelessWidget {
  static String routeName = "/ListCart";
  ReviewCartProvider? reviewCartProvider;
  WishListProvider? wishListProvider;
  showAlertDialog(BuildContext context, ReviewCartModel delete) {
    // set up the buttons
    Widget cancelButton = FloatingActionButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FloatingActionButton(
      child: Text("Yes"),
      onPressed: () {
        reviewCartProvider?.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Are you devete on cartProduct?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider?.getReviewCartData();
    CurrencyFormatterSettings currencySettings = CurrencyFormatterSettings(
      symbol: 'đ',
      symbolSide: SymbolSide.right,
      thousandSeparator: '.',
      decimalSeparator: ',',
      symbolSeparator: ' ',
    );

    // var priceNumber = 0;
    // try {
    //   int nums = int.parse(widget.productPrice!);
    //   priceNumber = nums;
    // } catch (e) {
    //   print('Chuỗi không thể chuyển đổi thành số: $e');
    // }
    String formattedPrice = CurrencyFormatter.format(
        reviewCartProvider?.getTotalPrice(), currencySettings);
    return Scaffold(
      bottomNavigationBar: reviewCartProvider?.getReviewCartDataList.length != 0
          ? ListTile(
              title: Text(
                'Tổng tiền:',
                style: TextStyle(
                    color: Color.fromARGB(255, 39, 39, 39),
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              subtitle: Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "${formattedPrice}",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color.fromRGBO(223, 46, 56, 1),
                      fontWeight: FontWeight.bold),
                ),
              ),
              trailing: Container(
                child: MaterialButton(
                    // padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: Container(
                        width: 150,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text(
                              'Thanh toán',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            )),
                            Icon(
                              Icons.navigate_next,
                              size: 33,
                              weight: 20,
                              color: Color.fromARGB(255, 255, 255, 255),
                            )
                          ],
                        )),
                    color: Color.fromRGBO(2, 134, 17, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DeliveryDetails(),
                        ),
                      );
                    }),
              ),
              contentPadding:
                  EdgeInsets.only(top: 15, bottom: 20, right: 20, left: 20),
            )
          : SizedBox(
              width: 0,
              height: 0,
            ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(2, 134, 17, 1),
        title: Text('Giỏ hàng'),
      ),
      body: reviewCartProvider?.getReviewCartDataList.length == 0
          ? Center(
              child: Text(
                "Giỏ hàng trống!!!",
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              itemCount: reviewCartProvider?.getReviewCartDataList.length,
              itemBuilder: (context, index) {
                ReviewCartModel data =
                    reviewCartProvider!.getReviewCartDataList[index];
                // final item = reviewCartProvider?.getReviewCartDataList[index];
                return Dismissible(
                  key: Key(index.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(color: Colors.red),
                  onDismissed: (DismissDirection direction) {
                    reviewCartProvider?.reviewCartDataDelete(data.cartId);
                    // : wishListProvider!.deleteWishtList(widget.productId);
                    // print(data.cartId);
                  },
                  child: SingleItem(
                    isBool: false,
                    wishList: false,
                    productImage: data.cartImage,
                    productName: data.cartName,
                    productPrice: data.cartPrice,
                    productId: data.cartId,
                    productQuantity: data.cartQuantity,
                    // productUnit: data.cartUnit,
                    onDelete: () {
                      showAlertDialog(context, data);
                    },
                  ),
                );
              },
            ),
    );
  }
}
