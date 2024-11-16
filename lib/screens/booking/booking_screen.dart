import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoga/constants/constants.dart';

class YogaClass {
  final String name;
  final String time;
  bool isBooked;

  YogaClass({required this.name, required this.time, this.isBooked = false});
}

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // Sample list of yoga classes
  // List<YogaClass> yogaClasses = [
  //   YogaClass(
  //       name: 'Flow Yoga Course 1', time: 'Monday - 8:00 AM', isBooked: true),
  //   YogaClass(
  //       name: 'Flow Yoga Course 2', time: 'Monday - 8:00 AM', isBooked: false),
  //   YogaClass(
  //       name: 'Flow Yoga Course 3', time: 'Monday - 8:00 AM', isBooked: false),
  //   YogaClass(
  //       name: 'Flow Yoga Course 4', time: 'Monday - 8:00 AM', isBooked: true),
  // ];

  // // Function to toggle booking status
  // void toggleBooking(int index) {
  //   setState(() {
  //     yogaClasses[index].isBooked = !yogaClasses[index].isBooked;
  //   });
  // }

  // late List bookList = [];

  late List bookListDtl = [];

  bool loading = true;

  var email = "";

  @override
  void initState() {
    getBookedListData();
    super.initState();
  }

  getBookedListData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    email = prefs.getString('email') ?? "";
    bookListDtl = [];
    FirebaseFirestore.instance
        .collection('yoga_book')
        .where('email', isEqualTo: email)
        .get()
        .then((querySnapshot) async {
      // bookListDtl = querySnapshot.docs;
      print("BOOK LIST >> ${querySnapshot.docs.length}");
      if (querySnapshot.docs.isEmpty) {
        setState(() {
          loading = false;
        });
      }
      for (var i = 0; i < querySnapshot.docs.length; i++) {
        print("BOOK LIST >> ${querySnapshot.docs[i]["classId"]}");

        await FirebaseFirestore.instance
            .collection('yoga_class_instances')
            .where('classId',
                isEqualTo: int.parse(querySnapshot.docs[i]["classId"]))
            .get()
            .then((querySnapshotClass) {
          setState(() {
            // bookListDtl = querySnapshotClass.docs;
            print("BOOK LIST 1 >> ${querySnapshotClass.docs.length}");
            for (var j = 0; j < querySnapshotClass.docs.length; j++) {
              print(
                  "BOOK LIST 2 >> ${querySnapshotClass.docs[j]["className"]}");

              // bookListDtl = querySnapshotClass.docs;
              setState(() {
                bookListDtl.add({
                  'bookId': querySnapshot.docs[i]["bookId"],
                  'classId': querySnapshot.docs[i]["classId"],
                  'email': querySnapshot.docs[i]["email"],
                  'additionalComments': querySnapshotClass.docs[j]
                      ["additionalComments"],
                  'className': querySnapshotClass.docs[j]["className"],
                  'courseId': querySnapshotClass.docs[j]["courseId"],
                  'courseName': querySnapshotClass.docs[j]["courseName"],
                  'date': querySnapshotClass.docs[j]["date"],
                  'id': querySnapshotClass.docs[j]["id"],
                  'teacher': querySnapshotClass.docs[j]["teacher"],
                });
                loading = false;
              });
            }
          });
        });
      }
    });
  }

  Widget buildBookedList(BuildContext context, List document, int i) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          document[i]['courseName'].toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
            '${document[i]['className']} ~ ${document[i]['date']}'), //Text(yogaClass.time),
        trailing: ElevatedButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection("yoga_book")
                .doc(document[i]['bookId'].toString())
                .delete()
                .then(
              (doc) {
                print(
                    "Document deleted >>> ${document[i]['bookId'].toString()}");
                Future.delayed(const Duration(seconds: 2), () {
                  getBookedListData();
                });
              },
              onError: (e) => print("Error updating document $e"),
            );
          }, //toggleBooking(index),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget buildListItem(BuildContext context, List document, int i) {
    // print("COURSE ID >> >${document['classId']}");

    return ListTile(
      title: Row(
        children: [Expanded(child: buildBookedList(context, document, i))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: loading
              ?
              // ignore: curly_braces_in_flow_control_structures
              const Center(child: Text("Loading...")
                  // CircularProgressIndicator(
                  //   strokeWidth: 4.0,
                  //   color: Colors.black,
                  //   backgroundColor: Colors.white,
                  // ),
                  )
              : Column(
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
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Booked List',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.5,
                                    color: darkYellow,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  email,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.5,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: bookListDtl.isEmpty
                          ? const Center(
                              child: Text("No Data"),
                            )
                          : ListView.builder(
                              // itemExtent: 80.0,
                              itemCount: bookListDtl.length,
                              itemBuilder: (context, index) =>
                                  buildListItem(context, bookListDtl, index),
                            ),
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                )

          // body: StreamBuilder(
          //     stream: FirebaseFirestore.instance
          //         .collection('yoga_book')
          //         .where('email', isEqualTo: "con@gmail.com")
          //         .snapshots(),
          //     builder: (context, snapshot) {
          //       if (!snapshot.hasData)
          //         // ignore: curly_braces_in_flow_control_structures
          //         return const Center(child: Text("Loading...")
          //             // CircularProgressIndicator(
          //             //   strokeWidth: 4.0,
          //             //   color: Colors.black,
          //             //   backgroundColor: Colors.white,
          //             // ),
          //             );

          //       return Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.symmetric(
          //               horizontal: appPadding,
          //             ),
          //             child: Column(
          //               children: [
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     const Padding(
          //                       padding: EdgeInsets.only(top: 8.0),
          //                       child: Text(
          //                         'Booked List',
          //                         style: TextStyle(
          //                           fontSize: 24,
          //                           fontWeight: FontWeight.w800,
          //                           letterSpacing: 1.5,
          //                           color: darkYellow,
          //                         ),
          //                       ),
          //                     ),
          //                     Container()
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Expanded(
          //             child: snapshot.data!.docs.isEmpty
          //                 ? const Center(
          //                     child: Text("No Data"),
          //                   )
          //                 : ListView.builder(
          //                     // itemExtent: 80.0,
          //                     itemCount: snapshot.data!.docs.length,
          //                     itemBuilder: (context, index) => buildListItem(
          //                         context, snapshot.data!.docs[index]),
          //                   ),
          //           ),
          //           const SizedBox(
          //             height: 15,
          //           )
          //         ],
          //       );
          //     }),
          ),
    );
  }
}

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BookingScreen(),
//     );
//   }
// }
