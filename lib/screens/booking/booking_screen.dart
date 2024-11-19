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

  // var email = "";

  @override
  void initState() {
    getBookedListData();
    super.initState();
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed from the widget tree
    super.dispose();
  }

  getBookedListData() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    // email = prefs.getString('email') ?? "";
    setState(() {
      bookListDtl = [];
    });

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
        // print("BOOK LIST >> ${querySnapshot.docs[i]["classId"]}");

        await FirebaseFirestore.instance
            .collection('yoga_class_instances')            
            .where('classId',
                isEqualTo: int.parse(querySnapshot.docs[i]["classId"]))
            .get()
            .then((querySnapshotClass) {
          // setState(() {
          // bookListDtl = querySnapshotClass.docs;
          print("BOOK LIST Lgh >> ${querySnapshotClass.docs.length}");
          for (var j = 0; j < querySnapshotClass.docs.length; j++) {
            // print(
            //     "BOOK LIST 2 >> ${querySnapshotClass.docs[j]["className"]}");
            print("BOOK LIST 1 >> ${querySnapshot.docs[i]["bookId"]}");
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
              if (i == querySnapshot.docs.length - 1) {
                setState(() {
                  loading = false;
                });
              }
            });
          }
          // });
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
          onPressed: () async {
            final result = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Cancel Booking',
                    // style: TextStyle(color: Colors.red),
                  ),
                  content: Text(
                      "Are you sure you want to cancel this '${document[i]['courseName']} | ${document[i]['className']} ~ ${document[i]['date']}'?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false); // Return "No"
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection("yoga_book")
                            .doc(document[i]['bookId'].toString())
                            .delete()
                            .whenComplete(() {
                          print(
                              "Document deleted >>> ${document[i]['bookId'].toString()}");
                          Navigator.of(context).pop(true); // Return "Yes"
                          Future.delayed(const Duration(seconds: 1), () {
                            getBookedListData();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Canceled Successfully!')),
                          );
                        }).then(
                          (doc) {},
                          onError: (e) => print("Error updating document $e"),
                        );
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                );
              },
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
                                  'BOOKED LIST',
                                  style: TextStyle(
                                    fontSize: 23,
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
                              child: Text("NO DATA"),
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
          //                     child: Text("NO DATA"),
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
