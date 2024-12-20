import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../details/components/background_image_clipper.dart';
import 'components/login_credentials.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackgroundImage(
                  img: 'assets/images/yoga.png',
                ),
                LoginCredentials(),
              ],
            ),
            // CircleButton(),
          ],
        ),
      ),
    );
  }
}
