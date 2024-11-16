import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:yoga/constants/constants.dart';
import 'package:yoga/screens/home/home_screen_(no_need).dart';

import '../../navigationbar/navigationbar_screen.dart';

class DetailBody extends StatelessWidget {
  final int capacity;
  final int courseId;
  final String courseName;
  final String dayOfWeek;
  final String description;
  final double duration;
  final int id;
  final double price;
  final String time;
  final String type;

  final String classId;
  final String className;
  final String teacher;
  final String date;
  final String email;

  const DetailBody(
      {required this.capacity,
      required this.courseId,
      required this.courseName,
      required this.dayOfWeek,
      required this.description,
      required this.duration,
      required this.id,
      required this.price,
      required this.time,
      required this.type,
      required this.classId,
      required this.className,
      required this.teacher,
      required this.date,
      required this.email,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              courseName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Class Name ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.meeting_room_rounded,
                          size: 18,
                        ),
                        Text(
                          " $className",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Date ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.date_range_rounded,
                          size: 18,
                        ),
                        Text(
                          " $date",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Teacher ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person_2_rounded,
                          size: 18,
                        ),
                        Text(
                          " $teacher",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Duration ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 18,
                        ),
                        Text(
                          " ${duration} Day(s)",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Capacity ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person_2_outlined,
                          size: 18,
                        ),
                        Text(
                          " ${capacity} Person(s)",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Day & Time ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          size: 18,
                        ),
                        Text(
                          " ${dayOfWeek} - ${time}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price ",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  " \$$price",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF830101),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () {
                // var rng = Random();
                // var doc;
                // for (var i = 0; i < 10; i++) {
                //   doc = rng.nextInt(1000);
                //   print(doc);
                // }
                var number = "";
                var randomnumber = Random();
                //chnage i < 15 on your digits need
                for (var i = 0; i < 15; i++) {
                  number = number + randomnumber.nextInt(9).toString();
                }
                print(number);

                final book = <String, dynamic>{
                  "bookId": int.parse(number),
                  "classId": classId,
                  "email": email
                };

                FirebaseFirestore.instance
                    .collection("yoga_book")
                    .doc(number.toString())
                    .set(book)
                    .then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavigationBarScreen(),
                    ),
                  );
                }).onError((e, _) {
                  print("Error writing document: $e");
                });
              },
              // onTap: () => Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => HomeScreen(),
              //   ),
              // ),
              child: Material(
                  elevation: 10.0,
                  shadowColor: darkYellow,
                  color: darkYellow,
                  borderRadius: BorderRadius.circular(30.0),
                  child: SizedBox(
                    width: size.width,
                    height: size.width * 0.15,
                    child: const Center(
                      child: Text(
                        'Book',
                        style: TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
