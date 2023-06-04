import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:foodorder_app/screens/notificate/NotificateItem.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(2, 134, 17, 1),
        title: Text('Thông báo'),
      ),
      body: NotificationList(),
    );
  }
}

class NotificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: <Widget>[
          NotificationItem(
            title: 'Order ready for pickup',
            message: 'Your Domino\'s pizza is ready for pickup',
            time: '2 minutes ago',
          ),
          NotificationItem(
            title: 'Order delivered',
            message: 'Your pizza has been delivered to your doorstep',
            time: '10 minutes ago',
          ),
          NotificationItem(
            title: 'New promotion',
            message: 'Get one pizza and get one free! Use code PIZZA123 ',
            time: '1 hour ago',
          ),
          NotificationItem(
            title: 'New promotion',
            message: 'Get one pizza and get one free! Use code PIZZA123',
            time: '1 hour ago',
          ),
          NotificationItem(
            title: 'New promotion',
            message: 'Get one pizza and get one free! Use code PIZZA123',
            time: '1 hour ago',
          ),
          NotificationItem(
            title: 'New promotion',
            message: 'Get one pizza and get one free! Use code PIZZA123',
            time: '1 hour ago',
          ),
          NotificationItem(
            title: 'New promotion',
            message: 'Get one pizza and get one free! Use code PIZZA123',
            time: '1 hour ago',
          ),
          NotificationItem(
            title: 'New promotion',
            message: 'Get one pizza and get one free! Use code PIZZA123',
            time: '1 hour ago',
          ),
          NotificationItem(
            title: 'New promotion',
            message: 'Get one pizza and get one free! Use code PIZZA123',
            time: '1 hour ago',
          ),
          NotificationItem(
            title: 'New promotion',
            message: 'Get one pizza and get one free! Use code PIZZA123',
            time: '1 hour ago',
          ),
        ],
      ),
    );
  }
}
