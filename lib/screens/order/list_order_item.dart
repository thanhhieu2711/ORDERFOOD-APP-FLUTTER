import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodorder_app/config/colors.dart';
import 'package:foodorder_app/screens/check-out/payment/order_item.dart';
import 'package:intl/intl.dart';

class ListOrderItem extends StatelessWidget {
  // const MyWidget({super.key});
  String? order_id;
  List<dynamic>? list_order;
  bool? order_status;
  Timestamp? order_at;
  List<dynamic>? list_info;
  String? order_total;
  void Function()? onTap;
  ListOrderItem(
      {this.order_id,
      this.list_order,
      this.order_status,
      this.order_at,
      this.list_info,
      this.order_total,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(
        order_at!.seconds * 1000 + (order_at!.nanoseconds / 1000000).round());
    final formattedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(date);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListTile(
          leading: Image.network(
            'https://foodcoin-app.com/wp-content/uploads/2021/06/Logo-Foodcoin.png',
            width: 50,
            color: primaryColor,
            fit: BoxFit.contain,
            height: 50,
            alignment: Alignment.center,
          ),
          title: Text(
            "Đơn hàng : #${order_id!}",
            maxLines: 1,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          subtitle: Text(formattedDate),
          trailing: Container(
            width: 75,
            alignment: Alignment.center,
            height: 30,
            // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: order_status == true
                  ? primaryColor
                  : Color.fromARGB(255, 198, 13, 0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              order_status == true ? "Đang giao" : "Đã hủy",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
