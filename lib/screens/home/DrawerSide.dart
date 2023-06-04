import 'package:flutter/material.dart';
import 'package:foodorder_app/screens/ReviewCart/ListCart.dart';
import 'package:foodorder_app/screens/notificate/Notifications.dart';
import 'package:foodorder_app/screens/order/list_order.dart';
import 'package:foodorder_app/screens/profile/Profile.dart';
import 'package:foodorder_app/screens/home/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodorder_app/screens/wishlist/wish-list.dart';
import 'package:foodorder_app/providers/user_provider.dart';

class DrawerSide extends StatefulWidget {
  UserProvider? userProvider;
  DrawerSide({this.userProvider});
  @override
  _DrawerSideState createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Widget listTile(
      {IconData? icon, String? title, Function()? onTap, String? colorState}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 28,
        color: colorState != null ? Colors.red : Colors.black,
      ),
      title: Text(
        title!,
        style: TextStyle(
            fontSize: 18,
            color: colorState != null ? Colors.red : Colors.black,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider?.currentUserData;
    print(userData);
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            DrawerHeader(
                child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 32,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: Color.fromRGBO(2, 134, 17, 1),
                    backgroundImage: NetworkImage(
                      userData?.userImage ??
                          "https://antimatter.vn/wp-content/uploads/2022/11/anh-avatar-trang-fb-mac-dinh.jpg",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Text('Xin chào, ${userData?.userName}'),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    userData != null
                        ? SizedBox(
                            height: 0,
                          )
                        : Container(
                            height: 25,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 0.9,
                                      color: Color.fromRGBO(2, 134, 17, 1)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  )),
                              onPressed: () {},
                              child: Text(
                                'Đăng nhập',
                                style: TextStyle(
                                  color: Color.fromRGBO(2, 134, 17, 1),
                                ),
                              ),
                            ),
                          )
                  ],
                )
              ],
            )),
            listTile(
                icon: Icons.home_outlined,
                title: 'Trang chủ',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                }),
            listTile(
              icon: Icons.receipt_long_outlined,
              title: 'Đơn hàng của tôi',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ListOrder(),
                  ),
                );
              },
            ),
            listTile(
                icon: Icons.favorite_outline_sharp,
                title: 'Xem sau',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WishLsit(),
                    ),
                  );
                }),
            listTile(
                icon: Icons.supervised_user_circle_sharp,
                title: 'Tài khoản của tôi',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                  );
                }),
            listTile(
                icon: Icons.notifications,
                title: 'Thông báo',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Notifications(),
                    ),
                  );
                }),
            listTile(
                icon: Icons.request_page_outlined, title: 'Yêu cầu hỗ trợ'),
            listTile(icon: Icons.question_answer_outlined, title: 'Hỏi đáp'),
            Container(
              child: listTile(
                icon: Icons.logout_outlined,
                title: 'Đăng xuất',
                colorState: 'red',
                onTap: () async {
                  await _auth.signOut();
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Liên hệ hỗ trợ',
                      style: TextStyle(
                          color: Color.fromRGBO(2, 134, 17, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Text(
                        'Tổng đài : 1900009',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 3),
                      child: Text(
                        'Email : supportth@gmail.vn',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
