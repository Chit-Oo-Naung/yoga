import 'package:flutter/material.dart';
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
  List<YogaClass> yogaClasses = [
    YogaClass(
        name: 'Flow Yoga Course 1', time: 'Monday - 8:00 AM', isBooked: true),
    YogaClass(
        name: 'Flow Yoga Course 2', time: 'Monday - 8:00 AM', isBooked: false),
    YogaClass(
        name: 'Flow Yoga Course 3', time: 'Monday - 8:00 AM', isBooked: false),
    YogaClass(
        name: 'Flow Yoga Course 4', time: 'Monday - 8:00 AM', isBooked: true),
  ];

  // Function to toggle booking status
  void toggleBooking(int index) {
    setState(() {
      yogaClasses[index].isBooked = !yogaClasses[index].isBooked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
            color: darkYellow,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: yogaClasses.length,
        itemBuilder: (context, index) {
          final yogaClass = yogaClasses[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(
                yogaClass.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(yogaClass.time),
              trailing: ElevatedButton(
                onPressed: () => toggleBooking(index),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      yogaClass.isBooked ? Colors.red : Colors.green,
                ),
                child: Text(
                  yogaClass.isBooked ? 'Booked' : 'Canceled',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BookingScreen(),
    );
  }
}
