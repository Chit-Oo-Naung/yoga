import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';
import '../navigationbar/navigationbar_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List lst = [];

  @override
  void initState() {
    getList();
    super.initState();
  }

  getList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var crtLst = prefs.getString('cart_list') ?? "";
    if (crtLst != "") {
      setState(() {
        lst = json.decode(crtLst);
        print("LST >>> $lst");
      });
    }
  }

// getEmail() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   email = prefs.getString('email') ?? "";
  // }
  @override
  Widget build(BuildContext context) {
    Widget buildCartList(BuildContext context, List document, int i) {
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
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              setState(() {
                lst.removeAt(i);
                prefs.setString("cart_list", json.encode(lst));
              });
            }, //toggleBooking(index),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'REMOVE',
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
          children: [Expanded(child: buildCartList(context, document, i))],
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NavigationBarScreen(),
                ),
              );
            },
          ),
          title: Text(
            "CART",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
              color: white,
            ),
          ),
        ),
        body: lst.isEmpty
            ? const Center(
                child: Text("NO DATA"),
              )
            : ListView.builder(
                // itemExtent: 80.0,
                itemCount: lst.length,
                itemBuilder: (context, index) =>
                    buildListItem(context, lst, index),
              ),
        bottomNavigationBar: Container(
          height: 56,
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(color: darkYellow,),
                        );
                      },
                    );

                    for (var i = 0; i < lst.length; i++) {
                      var number = "";
                      var randomnumber = Random();
                      //can change i < 15 on if digits need
                      for (var i = 0; i < 15; i++) {
                        number = number + randomnumber.nextInt(9).toString();
                      }
                      print(number);

                      final book = <String, dynamic>{
                        "bookId": int.parse(number),
                        "classId": lst[i]['classId'],
                        "email": email
                      };

                      FirebaseFirestore.instance
                          .collection("yoga_book")
                          .doc(number.toString())
                          .set(book)
                          .then((value) {
                        if (i == lst.length - 1) {
                          setState(() {
                            lst = [];
                            prefs.setString("cart_list", json.encode(lst));
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavigationBarScreen(),
                            ),
                          );
                        }
                      }).onError((e, _) {
                        print("Error writing document: $e");
                      });
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: darkYellow,
                    child: Text("BOOK NOW",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
