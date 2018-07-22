import 'package:flutter/material.dart';

class CustomerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ("Customer Home"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: FlatButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
          },
          child: Text("To Home"),
      ),
    );
  }
}
