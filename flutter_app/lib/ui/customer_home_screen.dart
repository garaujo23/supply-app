import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'dart:async';

class CustomerHome extends StatelessWidget{
  var currentLocation = <String, double> {};
  var location = new Location();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Home"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text("Menu"),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              margin: EdgeInsets.only(bottom: 10.0),
            ),

            ListTile(
              leading: Icon(Icons.map),
              title: Text("Maps"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text("Feedback"),
              onTap: () {
                Navigator.pop(context);

              },
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text("Logout"),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home', (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
      body:Container(
        color: Colors.deepPurple.shade100,
        child: Text("Current Location: "),

      ),

    );
  }




}
