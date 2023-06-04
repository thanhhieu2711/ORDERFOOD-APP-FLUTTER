import 'package:flutter/material.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:foodorder_app/providers/review_cart_provider.dart';
import 'package:foodorder_app/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchItem extends StatelessWidget {
  String? productImage;
  String? productName;
  String? productPrice;
  String? productId;
  SearchItem({
    this.productId,
    this.productImage,
    this.productName,
    this.productPrice,
  });

  CurrencyFormatterSettings currencySettings = CurrencyFormatterSettings(
    symbol: 'đ',
    symbolSide: SymbolSide.right,
    thousandSeparator: '.',
    decimalSeparator: ',',
    symbolSeparator: ' ',
  );

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    var priceNumber = 0;
    try {
      int nums = int.parse(productPrice!);
      priceNumber = nums;
    } catch (e) {
      print('Chuỗi không thể chuyển đổi thành số: $e');
    }
    String formattedPrice =
        CurrencyFormatter.format(priceNumber, currencySettings);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 100,
            child: Center(
              child: Image.network(productImage!),
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName ?? '',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(height: 5),
                    Text(
                      formattedPrice ?? '',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.only(right: 10),
            child: Center(
              child: Container(
                // height: 30,
                // width: 60,
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.green[600],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () => {
                    reviewCartProvider.addReviewCartData(
                      cartId: productId,
                      cartImage: productImage,
                      cartName: productName,
                      cartPrice: productPrice,
                      cartQuantity: 1,
                    ),
                    Fluttertoast.showToast(
                        msg: "Thêm SP vào giỏ hàng thành công",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green[500],
                        textColor: Colors.white,
                        fontSize: 16.0)
                  },
                  child: Text(
                    'Thêm',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
