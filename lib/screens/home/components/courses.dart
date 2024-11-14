import 'package:flutter/material.dart';
import 'package:yoga/constants/constants.dart';
import 'package:yoga/data/data.dart';
import 'package:yoga/models/course.dart';
import 'package:yoga/screens/details/details_screen.dart';

class Courses extends StatelessWidget {
  Widget _buildCourses(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    Course course = courses[index];
    double screenWidth = MediaQuery.of(context).size.width;
    String? selectedDay;

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: appPadding, vertical: appPadding / 2),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => DetailsScreen(
          //       id: index,
          //     ),
          //   ),
          // );
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
                        course.courseName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        course.description,
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
                            " ${course.duration} Day(s)",
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
                            " ${course.dayOfWeek} - ${course.time}",
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
        // Container(
        //   height: size.height * 0.2,
        //   decoration: BoxDecoration(
        //       color: white,
        //       borderRadius: BorderRadius.circular(30.0),
        //       boxShadow: [
        //         BoxShadow(
        //             color: black.withOpacity(0.3),
        //             blurRadius: 30.0,
        //             offset: Offset(10, 15))
        //       ]),
        //   child: Padding(
        //     padding: const EdgeInsets.all(appPadding),
        //     child: Row(
        //       children: [
        //         SizedBox(
        //           width: size.width * 0.2,
        //           height: size.height * 0.1,
        //           child: ClipRRect(
        //             borderRadius: BorderRadius.circular(20.0),
        //             child: const Image(
        //               image: AssetImage('assets/images/yoga.png'),
        //               fit: BoxFit.cover,
        //             ),
        //           ),
        //         ),
        //         SizedBox(
        //           width: size.width - (size.width * 0.2),
        //           child: Padding(
        //             padding: const EdgeInsets.only(
        //                 left: appPadding / 2, top: appPadding / 1.5),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Flexible(
        //                   child: Text(
        //                     course.courseName,
        //                     overflow: TextOverflow.ellipsis,
        //                     style: const TextStyle(
        //                       fontWeight: FontWeight.bold,
        //                       fontSize: 16,
        //                     ),
        //                     maxLines: 2,
        //                   ),
        //                 ),
        //                 // SizedBox(
        //                 //   height: size.height * 0.01,
        //                 // ),
        //                 // Row(
        //                 //   children: [
        //                 //     // Icon(
        //                 //     //   Icons.folder_open_rounded,
        //                 //     //   color: black.withOpacity(0.3),
        //                 //     // ),
        //                 //     SizedBox(
        //                 //       width: size.width * 0.01,
        //                 //     ),
        //                 //     Text(
        //                 //       course.description,
        //                 //       style: TextStyle(
        //                 //         color: black.withOpacity(0.3),
        //                 //       ),
        //                 //     )
        //                 //   ],
        //                 // ),
        //                 // SizedBox(
        //                 //   height: size.height * 0.01,
        //                 // ),
        //                 // Row(
        //                 //   children: [
        //                 //     Icon(
        //                 //       Icons.access_time_outlined,
        //                 //       color: black.withOpacity(0.3),
        //                 //     ),
        //                 //     SizedBox(
        //                 //       width: size.width * 0.01,
        //                 //     ),
        //                 //     Text(
        //                 //       course.time.toString() + ' min',
        //                 //       style: TextStyle(
        //                 //         color: black.withOpacity(0.3),
        //                 //       ),
        //                 //     )
        //                 //   ],
        //                 // ),
        //               ],
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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

    return Expanded(
      child: Column(
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
                        // setState(() {
                        selectedDay = newValue;
                        // });
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
                              color: Colors.grey, // Color for top border
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
                              color: Colors.grey, // Color for top border
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
            physics: BouncingScrollPhysics(),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return _buildCourses(context, index);
            },
          ))
        ],
      ),
    );
  }
}
