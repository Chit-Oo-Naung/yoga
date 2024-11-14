import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoga/constants/constants.dart';
import 'package:yoga/screens/booking/booking_screen.dart';
import 'package:yoga/screens/home/components/courses.dart';
import 'package:yoga/screens/home/components/custom_app_bar.dart';
import 'package:yoga/screens/home/components/diff_styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selsctedIconIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(top: appPadding * 2),
        child: Column(
          children: [
            //  CustomAppBar(),
            //  DiffStyles(),
            Courses()
          ],
        ),
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   backgroundColor: Colors.transparent,
      //   index: selsctedIconIndex,
      //   buttonBackgroundColor: const Color.fromARGB(255, 222, 192, 2),
      //   height: 60.0,
      //   color: const Color.fromARGB(255, 222, 192, 2),
      //   onTap: (index) {
      //     setState(() {
      //       selsctedIconIndex = index;
      //     });
      //   },
      //   animationDuration: const Duration(
      //     milliseconds: 200,
      //   ),
      //   items: <Widget>[
      //     Icon(
      //       Icons.home_outlined,
      //       size: 30,
      //       color: selsctedIconIndex == 0 ? white : black,
      //     ),
      //     Icon(
      //       Icons.shopping_cart_checkout_outlined,
      //       size: 30,
      //       color: selsctedIconIndex == 1 ? white : black,
      //     ),
      //   ],
      // ),
    );
  }
}
