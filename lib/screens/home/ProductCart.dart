import 'package:flutter/material.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:foodorder_app/models/product_model.dart';
import 'package:foodorder_app/screens/widgets/count.dart';

class ProductCart extends StatefulWidget {
  final String? productImage;
  final String? productName;
  final String? productPrice;
  final void Function()? onTap;
  final String? productId;
  final ProductModel? productUnit;
  ProductCart(
      {this.productId,
      this.productImage,
      this.productName,
      this.productUnit,
      this.onTap,
      this.productPrice});

  @override
  _ProductCartState createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  var unitData;
  var firstValue;
  @override
  Widget build(BuildContext context) {
    widget.productUnit?.productUnit?.firstWhere((element) {
      setState(() {
        firstValue = element;
      });
      return true;
    });
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
    String formattedPrice =
        CurrencyFormatter.format(widget.productPrice!, currencySettings);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: 280,
          width: 160,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                      height: 120,
                      padding: EdgeInsets.all(0),
                      width: double.infinity,
                      child: Image.network(
                        widget.productImage!,
                        fit: BoxFit.contain,
                      ))),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      widget.productName!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      formattedPrice,
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 100,
                    child: Count(
                      productId: widget.productId ?? '',
                      productImage: widget.productImage ?? '',
                      productName: widget.productName ?? '',
                      productPrice: widget.productPrice ?? '',
                      productUnit: unitData == null ? firstValue : unitData,
                    ),
                  ),
                ],
              ))
            ]),
          ),
        ),
      ]),
    );
  }
}
