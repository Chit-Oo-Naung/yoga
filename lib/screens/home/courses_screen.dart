import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yoga/constants/constants.dart';
import 'package:yoga/screens/details/details_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  late List documents;

  String? selectedDay;

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  // Function to pick start time
  Future<void> pickStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != startTime) {
      // setState(() {
      startTime = picked;
      // });
    }
  }

  // Function to pick end time
  Future<void> pickEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != endTime) {
      // setState(() {
      endTime = picked;
      // });
    }
  }

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
                  detailList: document,
                ),
              ),
            );
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Left-side image
                  Container(
                    width: screenWidth * 0.3, // Adjust based on screen width
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/yoga.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Space between image and text

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
                          ),
                        ),
                        const SizedBox(height: 3),
                        document['description'] == "" ||
                                document['description'] == null
                            ? Container()
                            : Text(
                                document['description'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[800],
                                ),
                              ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              size: 15,
                            ),
                            Text(
                              " ${document['duration']} Day(s)",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              size: 15,
                            ),
                            Text(
                              " ${document['dayOfWeek']} - ${document['time']}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
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
          body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('yoga_courses')
                .snapshots(),
            builder: (context, snapshot) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: appPadding,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Courses',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.5,
                                color: darkYellow,
                              ),
                            ),
                            Container(
                                child: DropdownButton<String>(
                              hint: const Text(
                                "Select a Day",
                                style: TextStyle(
                                  color: darkYellow,
                                ),
                              ),
                              value: selectedDay,
                              onChanged: (String? newValue) {
                                setState(() {
                                  print("SELECTED DAY >> $selectedDay");
                                  selectedDay = newValue;
                                  documents = snapshot.data!.docs;
                                  if (selectedDay != "") {
                                    documents = documents.where((element) {
                                      return element
                                          .get('dayOfWeek')
                                          .toString()
                                          .toLowerCase()
                                          .contains(selectedDay
                                              .toString()
                                              .toLowerCase());
                                    }).toList();
                                  }
                                });
                              },
                              items: daysOfWeek.map((String day) {
                                return DropdownMenuItem<String>(
                                  value: day,
                                  child: Text(day),
                                );
                              }).toList(),
                            )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Start Time Picker
                            GestureDetector(
                              onTap: () => pickStartTime(context),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color:
                                          Colors.grey, // Color for top border
                                      width:
                                          0.0, // Setting width to 0 makes the top border invisible
                                    ),
                                  ),
                                  //  Border.all(color: Colors.grey),
                                  // borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.timer_outlined,
                                      size: 20,
                                      color: darkYellow,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      startTime != null
                                          ? startTime!.format(context)
                                          : 'Start Time',
                                      style: const TextStyle(
                                          fontSize: 16, color: darkYellow),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // End Time Picker
                            GestureDetector(
                              onTap: () => pickEndTime(context),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color:
                                          Colors.grey, // Color for top border
                                      width:
                                          0.0, // Setting width to 0 makes the top border invisible
                                    ),
                                  ),
                                  //  Border.all(color: Colors.grey),
                                  // borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.timer_outlined,
                                      size: 20,
                                      color: darkYellow,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      endTime != null
                                          ? endTime!.format(context)
                                          : 'End Time',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: darkYellow,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      // itemExtent: 80.0,
                      itemCount: documents.isEmpty
                          ? snapshot.data?.docs.length
                          : documents.length,
                      itemBuilder: (context, index) =>
                          buildListItem(context, snapshot.data!.docs[index]),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              );
            },
          )),
    );
  }
}
