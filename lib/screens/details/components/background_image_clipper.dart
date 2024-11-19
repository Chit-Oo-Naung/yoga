import 'package:flutter/material.dart';
import 'package:yoga/constants/constants.dart';
import 'package:yoga/screens/home/components/curve_clipper.dart';

class BackgroundImage extends StatelessWidget {
  final String img;

  const BackgroundImage({required this.img, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ClipPath(
      clipper: CurveClipper(),
      child: Container(
        height: size.height * 0.45,
        color: blueGrey.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: appPadding / 2, vertical: appPadding * 3),
          child: Center(
            child: (img == "" || img.contains("assets/"))
                ? const Image(
                    image: AssetImage('assets/images/yoga.png'),
                    fit: BoxFit.cover,
                  )
                : Image(
                    image: NetworkImage(img),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}
