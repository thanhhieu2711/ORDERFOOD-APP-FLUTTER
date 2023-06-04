import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodorder_app/providers/user_provider.dart';
import 'package:foodorder_app/screens/home/HomeScreen.dart';
import 'package:matcher/matcher.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  UserProvider? userProvider;
  _googleSignIn() async {
    try {
      String googleClientId = 'your-web-client-id.apps.googleusercontent.com';
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      //khởi tạo phương thức đăng nhập GG
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      //authenticate đăng nhập
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      //lấy thông tin đăng nhập, token
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      //trả về thông tin user
      final User? user = (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user!.displayName!);
      if (user == null) {
        return;
      } else {
        userProvider!.addUserData(
          currentUser: user,
          userEmail: user!.email,
          userImage: user.photoURL,
          userName: user.displayName,
        );
        return user;
      }
    } catch (e) {
      throw (e);
    }
  }
  // _googleSignIn() async {
  //   try {
  //     final GoogleSignIn _googleSignIn = GoogleSignIn(
  //       scopes: ['email', 'photoURL', 'displayName'],
  //     );
  //     final FirebaseAuth _auth = FirebaseAuth.instance;

  //     //khởi tạo phương thức đăng nhập GG
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     //authenticate đăng nhập
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;
  //     //lấy thông tin đăng nhập, token
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //     //trả về thông tin user
  //     final User? user = (await _auth.signInWithCredential(credential)).user;
  //     userProvider!.addUserData(
  //       currentUser: user,
  //       userEmail: user!.email,
  //       userImage: user.photoURL,
  //       userName: user.displayName,
  //     );
  //     return user;
  //   } catch (e) {
  //     print(e);
  //     // throw (e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/background2.jpg'))),
        child: new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              height: 400,
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Vui lòng đăng nhập để tiếp tục',
                    ),
                    Image.network(
                      'https://foodcoin-app.com/wp-content/uploads/2021/06/Logo-Foodcoin.png',
                      width: 300,
                    ),
                    Column(
                      children: [
                        SignInButton(
                          Buttons.Google,
                          text: "Đăng nhập với Google",
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 75),
                          onPressed: () {
                            _googleSignIn().then((value) =>
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen())));
                          },
                        ),
                        SizedBox(height: 20),
                        SignInButton(
                          Buttons.Apple,
                          text: "Đăng nhập với Apple",
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 75),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Bằng cách ấn đăng nhập, bạn đã đồng ý với chính sách, thỏa thuận của chúng tôi.',
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            // shadows: [
                            //   BoxShadow(
                            //       blurRadius: 1,
                            //       color: Colors.black87,
                            //       offset: Offset(0, 1))
                            // ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],

                      // Text(
                      //   'Chính sách và Điều khoản của chúng tôi.',
                      //   style: TextStyle(color: Colors.grey[600]),
                      //   textAlign: TextAlign.center,
                      // ),
                    )
                  ]),
            )
          ]),
        ),
      ),
    );
  }
}
