import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrderItem extends StatelessWidget {
  bool? isTrue;
  String? name;
  String? price;
  String? quantity;
  String? image;

  OrderItem({this.name, this.price, this.quantity, this.image});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 5,
      leading: Image.network(
        image!,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name!,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          Text("x${quantity}",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          Text('${price}đ',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16))
        ],
      ),
    );
  }
}
