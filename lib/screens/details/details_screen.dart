import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yoga/constants/constants.dart';
import 'package:yoga/data/data.dart';
import 'package:yoga/screens/details/components/background_image_clipper.dart';
import 'package:yoga/screens/details/components/circle_button.dart';
import 'package:yoga/screens/details/components/detial_body.dart';
import 'package:yoga/models/course.dart';

class DetailsScreen extends StatefulWidget {
  final DocumentSnapshot detailList;
  const DetailsScreen({super.key, required this.detailList});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late DocumentSnapshot course;

  @override
  void initState() {
    course = widget.detailList;
    super.initState();
  }

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
                  capacity: int.parse(course["capacity"].toString()),
                  courseId: int.parse(course["courseId"].toString()),
                  courseName: course["courseName"].toString(),
                  dayOfWeek: course["dayOfWeek"].toString(),
                  description: course["description"],
                  duration: double.parse(course["duration"].toString()),
                  id: int.parse(course["id"].toString()),
                  price: double.parse(course["price"]),
                  time: course["time"],
                  type: course["type"],
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
