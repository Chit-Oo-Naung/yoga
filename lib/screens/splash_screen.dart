import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoga/constants/constants.dart';
import 'package:yoga/login/login_screen.dart';

import 'navigationbar/navigationbar_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkEmail();
    super.initState();
  }

  checkEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var email = prefs.getString('email') ?? "";
    Future.delayed(const Duration(seconds: 3), () {
      if (email == "") {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationBarScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Image.asset(
            'assets/logo/yoga.png',
            width: 300.0,
            height: 300.0,
          ),
        ),
      ),
    );
  }
}
