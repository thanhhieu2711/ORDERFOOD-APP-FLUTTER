import 'package:flutter/material.dart';
import 'package:foodorder_app/auth/SignIn.dart';
import 'package:foodorder_app/providers/user_provider.dart';
import 'package:foodorder_app/screens/home/DrawerSide.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  Widget listTile({
    IconData? icon,
    String? title,
    Function()? onTap,
  }) {
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(
            icon,
            size: 34,
            color: Colors.black,
          ),
          title: Text(
            title ??= '',
            style: TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
          onTap: onTap,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    var currentUser = userProvider.currentData;

    return Scaffold(
      backgroundColor: Color.fromRGBO(2, 134, 17, 1),
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromRGBO(2, 134, 17, 1),
      ),
      drawer: DrawerSide(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 60,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 250,
                            height: 80,
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentUser!.userName.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      currentUser.userEmail.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300),
                                      maxLines: 1,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      listTile(
                          icon: Icons.shopping_bag_outlined,
                          title: 'My Orders'),
                      listTile(
                          icon: Icons.location_on_outlined,
                          title: 'My Delivery Address'),
                      listTile(
                          icon: Icons.person_outlined, title: 'Refer a Friend'),
                      listTile(icon: Icons.info_outline, title: 'About'),
                      listTile(
                          icon: Icons.file_copy_outlined,
                          title: 'Term & Condition'),
                      listTile(
                          icon: Icons.addchart_outlined,
                          title: 'Private & Policy'),
                      listTile(
                          icon: Icons.logout_outlined,
                          title: 'Log Out',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignIn()));
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 2),
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Color.fromRGBO(2, 134, 17, 1),
              child: CircleAvatar(
                backgroundImage: NetworkImage(currentUser.userImage.toString()),
                radius: 70,
                backgroundColor: Colors.black,
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 70,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Color.fromRGBO(2, 134, 17, 1),
              child: (CircleAvatar(
                radius: 15,
                child: Icon(
                  Icons.edit,
                  color: Color.fromRGBO(2, 134, 17, 1),
                ),
                backgroundColor: Colors.white,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
