import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:yoga/constants/constants.dart';
import 'package:yoga/screens/booking/booking_screen.dart';
import 'package:yoga/screens/home/courses_screen.dart';
// import 'package:yoga/screens/home/home_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  @override
  _NavigationBarScreenState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _selectedIndex = 0;

  // List of pages to display based on the selected index
  static List<Widget> pages = <Widget>[
    CoursesScreen(),
    BookingScreen(),
  ];
  int selsctedIconIndex = 0;

  // Function to handle navigation bar item taps
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        index: selsctedIconIndex,
        buttonBackgroundColor: darkYellow,
        height: 60.0,
        color: darkYellow,
        onTap: onItemTapped,
        animationDuration: const Duration(
          milliseconds: 200,
        ),
        items: <Widget>[
          Icon(
            Icons.home_outlined,
            size: 30,
            color: selsctedIconIndex == 0 ? white : black,
          ),
          Icon(
            Icons.shopping_cart_checkout_outlined,
            size: 30,
            color: selsctedIconIndex == 1 ? white : black,
          ),
        ],
      ),
    );
  }
}
