import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodorder_app/screens/check-out/payment/order_item.dart';

class OrderModel {
  String? order_id;
  String? total;
  Timestamp? order_create_at;
  List<dynamic>? list_order_item;
  bool? is_delivery;
  String? order_payment_type;
  List<dynamic>? order_info;
  OrderModel(
      {this.order_id,
      this.is_delivery,
      this.total,
      this.list_order_item,
      this.order_create_at,
      this.order_payment_type,
      this.order_info});
}
