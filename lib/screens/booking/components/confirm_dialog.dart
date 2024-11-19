import 'package:flutter/material.dart';

class YesNoDialogExample extends StatelessWidget {
  Future<void> _showYesNoDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to proceed?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return "No"
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return "Yes"
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );

    // Use the result
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You selected Yes!')),
      );
    } else if (result == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You selected No!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yes/No Dialog Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showYesNoDialog(context),
          child: Text('Show Dialog'),
        ),
      ),
    );
  }
}
