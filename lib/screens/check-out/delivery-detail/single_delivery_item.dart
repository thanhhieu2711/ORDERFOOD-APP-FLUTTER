import 'package:flutter/material.dart';
import 'package:foodorder_app/config/colors.dart';

class SingleDeliveryItem extends StatelessWidget {
  void Function()? onTap;
  final String? title;
  final String? address;
  final String? number;
  final String? addressType;
  final bool? isSelected;
  SingleDeliveryItem(
      {this.title,
      this.addressType,
      this.address,
      this.number,
      this.isSelected,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ListTile(
            title: Text(
              title!,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 7,
                ),
                Text(
                  address!,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  number!,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 7,
                ),
                Text("( ${addressType} )", style: TextStyle(fontSize: 16))
              ],
            ),
            trailing: isSelected == true
                ? Container(
                    // margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Mặc Định",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Mặc Định",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
          ),
          SizedBox(height: 15)
        ],
      ),
    );
  }
}
