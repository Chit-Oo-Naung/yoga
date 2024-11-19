import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoga/constants/constants.dart';
import 'package:yoga/screens/details/components/background_image_clipper.dart';
import 'package:yoga/screens/details/components/circle_button.dart';
import 'package:yoga/screens/details/details_screen.dart';

class ClassScreen extends StatefulWidget {
  final DocumentSnapshot courseDetail;
  const ClassScreen({super.key, required this.courseDetail});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  late DocumentSnapshot course;
  String courseName = "";

  @override
  void initState() {
    course = widget.courseDetail;
    courseName = course["courseName"];
    // getEmail();
    super.initState();
  }

  // var email = "";

  // getEmail() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   email = prefs.getString('email') ?? "";
  //   print("Email>> $email");
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    Widget buildCourses(BuildContext context, DocumentSnapshot document) {
      // Size size = MediaQuery.of(context).size;
      // // Course course = courses[index];
      // double screenWidth = MediaQuery.of(context).size.width;
      // String? selectedDay;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  courseDetail: course,
                  classDetail: document,
                  email: email,
                ),
              ),
            );
          },
          child: Card(
            elevation: 4,
            color: darkYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Left-side image
                  // Container(
                  //   width: screenWidth * 0.3, // Adjust based on screen width
                  //   height: 100,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8),
                  //     image: const DecorationImage(
                  //       image: AssetImage('assets/images/yoga.png'),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(width: 16), // Space between image and text

                  // Right-side texts
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document['courseName'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: black
                          ),
                        ),
                        const SizedBox(height: 3),
                        document['additionalComments'] == "" ||
                                document['additionalComments'] == null
                            ? Container()
                            : Text(
                                document['additionalComments'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: black,
                                ),
                              ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(
                              Icons.meeting_room_rounded,
                              size: 15,
                              color: black,
                            ),
                            Text(
                              " ${document['className']}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(
                              Icons.date_range_rounded,
                              size: 15,
                              color: black,
                            ),
                            Text(
                              " ${document['date']}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(
                              Icons.person_2_rounded,
                              size: 15,
                              color: black,
                            ),
                            Text(
                              " ${document['teacher']}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: black,
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(height: 3),
                        // Row(
                        //   children: [
                        //     const Icon(
                        //       Icons.calendar_month_outlined,
                        //       size: 15,
                        //     ),
                        //     Text(
                        //       " ${document['dayOfWeek']} - ${document['time']}",
                        //       style: TextStyle(
                        //         fontSize: 14,
                        //         color: Colors.grey[600],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget buildListItem(BuildContext context, DocumentSnapshot document) {
      return ListTile(
        title: Row(
          children: [Expanded(child: buildCourses(context, document))],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          extendBody: true,
          appBar: AppBar(
            backgroundColor: darkYellow,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              courseName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
                color: white,
              ),
            ),
          ),
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('yoga_class_instances')
                .where("courseId", isEqualTo: course["courseId"])
                .snapshots(),
            builder: (context, snapshot) {
              // documents = snapshot.data!.docs;
              if (!snapshot.hasData)
                // ignore: curly_braces_in_flow_control_structures
                return const Center(child: Text("Loading...")
                    // CircularProgressIndicator(
                    //   strokeWidth: 4.0,
                    //   color: Colors.black,
                    //   backgroundColor: Colors.white,
                    // ),
                    );

              return Column(
                children: [
                  Expanded(
                    child: (snapshot.data!.docs.isEmpty)
                        ? const Center(
                            child: Text("NO DATA"),
                          )
                        : ListView.builder(
                            // itemExtent: 80.0,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) => buildListItem(
                                context, snapshot.data!.docs[index]),
                          ),
                  ),
                ],
              );
              // return SingleChildScrollView(
              //   child: Stack(
              //     alignment: Alignment.topCenter,
              //     children: [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           BackgroundImage(),
              //         ],
              //       ),
              //       CircleButton(),

              //       // Expanded(
              //       //     child: Column(
              //       //       // crossAxisAlignment: CrossAxisAlignment.start,
              //       //       children: [
              //       //         Text("ABC"),
              //       //         // Column(
              //       //         //   children: [
              //       //         //     Expanded(
              //       //         //       child: (snapshot.data!.docs.isEmpty)
              //       //         //           ? const Center(
              //       //         //               child: Text("NO DATA"),
              //       //         //             )
              //       //         //           : ListView.builder(
              //       //         //               // itemExtent: 80.0,
              //       //         //               itemCount:
              //       //         //                   snapshot.data!.docs.length,
              //       //         //               itemBuilder: (context, index) =>
              //       //         //                   buildListItem(context,
              //       //         //                       snapshot.data!.docs[index]),
              //       //         //             ),
              //       //         //     ),
              //       //         //   ],
              //       //         // ),
              //       //         //       const SizedBox(
              //       //         //         height: 15,
              //       //         //       )
              //       //       ],
              //       //     ))
              //     ],
              //   ),
              // );
            },
          )),
    );
  }
}
