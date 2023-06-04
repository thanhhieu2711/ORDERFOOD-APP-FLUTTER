import 'package:flutter/material.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:foodorder_app/providers/review_cart_provider.dart';
import 'package:foodorder_app/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SingleItem extends StatefulWidget {
  bool? isBool;
  String? productImage;
  String? productName;
  bool? wishList = false;
  bool? isCart = false;

  String? productPrice;
  String? productId;
  int? productQuantity;
  Function? onDelete;
  SingleItem(
      {this.isCart,
      this.productQuantity,
      this.productId,
      this.onDelete,
      this.isBool,
      this.productImage,
      this.productName,
      this.productPrice,
      this.wishList});

  @override
  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  ReviewCartProvider? reviewCartProvider;
  WishListProvider? wishListProvider;

  int? count;
  getCount() {
    setState(() {
      count = widget.productQuantity ?? 0;
    });
  }

  CurrencyFormatterSettings currencySettings = CurrencyFormatterSettings(
    symbol: 'đ',
    symbolSide: SymbolSide.right,
    thousandSeparator: '.',
    decimalSeparator: ',',
    symbolSeparator: ' ',
  );

  @override
  Widget build(BuildContext context) {
    getCount();
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    wishListProvider = Provider.of<WishListProvider>(context);

    reviewCartProvider?.getReviewCartData();
    var priceNumber = 0;
    try {
      int nums = int.parse(widget.productPrice!);
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
              child: Image.network(widget.productImage!),
            ),
          ),
        ),
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
                      widget.productName ?? '',
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
                Container(
                  width: 90,
                  margin: EdgeInsets.only(top: 5),
                  child: widget.isBool == true
                      ? SizedBox(width: 0, height: 0)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(2, 134, 17, 1),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  count = count! + 1;
                                });
                                reviewCartProvider?.updateReviewCartData(
                                  cartId: widget.productId,
                                  cartImage: widget.productImage,
                                  cartName: widget.productName,
                                  cartPrice: widget.productPrice,
                                  cartQuantity: count,
                                );
                              },
                            ),
                            Text(
                              count!.toString(),
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 42, 42, 42)),
                            ),
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(2, 134, 17, 1)
                                    // color: Colors.red
                                    ,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Icon(
                                  Icons.remove,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  count = count! - 1;
                                });
                                reviewCartProvider?.updateReviewCartData(
                                  cartId: widget.productId,
                                  cartImage: widget.productImage,
                                  cartName: widget.productName,
                                  cartPrice: widget.productPrice,
                                  cartQuantity: count,
                                );
                                if (count == 0) {
                                  widget.isBool == false
                                      ? reviewCartProvider
                                          ?.reviewCartDataDelete(
                                              widget.productId)
                                      : wishListProvider!
                                          .deleteWishtList(widget.productId);
                                  Fluttertoast.showToast(
                                      msg: "Xóa SP khỏi giỏ hàng thành công",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red[500],
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              },
                            ),
                          ],
                        ),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 10),
          child: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 214, 214, 214),
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
                onTap: () => {
                  widget.isBool == false
                      ? reviewCartProvider
                          ?.reviewCartDataDelete(widget.productId)
                      : wishListProvider!.deleteWishtList(widget.productId),
                  Fluttertoast.showToast(
                      msg: "Xóa SP khỏi giỏ hàng thành công",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red[500],
                      textColor: Colors.white,
                      fontSize: 16.0)
                },
                child: Icon(
                  Icons.delete_outlined,
                  color: Color.fromARGB(255, 42, 42, 42),
                  size: 20,
                ),
              )),
        ),
      ],
    );
  }
}
