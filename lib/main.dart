import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodorder_app/auth/SignIn.dart';
import 'package:foodorder_app/providers/check_out_provider.dart';
import 'package:foodorder_app/providers/list_order_provider.dart';
import 'package:foodorder_app/providers/product_provider.dart';
import 'package:foodorder_app/providers/review_cart_provider.dart';
import 'package:foodorder_app/providers/user_provider.dart';
import 'package:foodorder_app/providers/wishlist_provider.dart';
import 'package:foodorder_app/screens/notificate/NotificationService.dart';
import 'package:foodorder_app/screens/notificate/Notifications.dart';
import 'package:foodorder_app/screens/profile/Profile.dart';
import 'package:foodorder_app/screens/home/HomeScreen.dart';
import 'package:foodorder_app/screens/search/Search.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:foodorder_app/config/firebase_options.dart';
// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationServices().inititaliseNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
          create: (context) => ReviewCartProvider(),
        ),
        ChangeNotifierProvider<WishListProvider>(
          create: (context) => WishListProvider(),
        ),
        ChangeNotifierProvider<CheckoutProvider>(
          create: (context) => CheckoutProvider(),
        ),
        ChangeNotifierProvider<ListOrderProvider>(
          create: (context) => ListOrderProvider(),
        ),
      ],
      child: MaterialApp(
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return HomeScreen();
            }
            return SignIn();
          },
        ),
      ),
    );
  }
}


  // return MaterialApp(
  //     home: HomeScreen(),
  //   );