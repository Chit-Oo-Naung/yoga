import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoga/constants/constants.dart';
import 'package:yoga/data/data.dart';
import 'package:yoga/screens/details/components/background_image_clipper.dart';
import 'package:yoga/screens/details/components/circle_button.dart';
import 'package:yoga/screens/details/components/detial_body.dart';
import 'package:yoga/models/course.dart';

class DetailsScreen extends StatefulWidget {
  final DocumentSnapshot courseDetail;
  final DocumentSnapshot classDetail;
  final String email;
  const DetailsScreen(
      {super.key, required this.courseDetail, required this.classDetail, required this.email});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late DocumentSnapshot courseDtl;
  late DocumentSnapshot classDtl;
  // var email = "";

  @override
  void initState() {
    courseDtl = widget.courseDetail;
    classDtl = widget.classDetail;
    super.initState();
  }

  // getEmail() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   email = prefs.getString('email') ?? "";
  // }

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
                BackgroundImage(),
                DetailBody(
                  capacity: int.parse(courseDtl["capacity"].toString()),
                  courseId: int.parse(courseDtl["courseId"].toString()),
                  courseName: courseDtl["courseName"].toString(),
                  dayOfWeek: courseDtl["dayOfWeek"].toString(),
                  description: courseDtl["description"],
                  duration: double.parse(courseDtl["duration"].toString()),
                  id: int.parse(courseDtl["id"].toString()),
                  price: double.parse(courseDtl["price"]),
                  time: courseDtl["time"],
                  type: courseDtl["type"],
                  classId: classDtl["classId"].toString(),
                  className: classDtl["className"],
                  teacher: classDtl["teacher"],
                  date: classDtl["date"],
                  email: widget.email
                ),
              ],
            ),
            CircleButton(),
          ],
        ),
      ),
    );
  }
}
