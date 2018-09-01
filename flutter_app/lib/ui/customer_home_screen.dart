import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../ui/customer_map.dart';
import '../ui/login_screen.dart';
import '../ui/customer_map.dart';

//import 'package:map_view/map_view.dart';

String uID = userUid;

class CustomerHome extends StatelessWidget {
  final currentLocation = <String, double>{};

  //final location = new Location();
  //final _mapView = new MapView();
  final FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Home"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              child: ListView(
                children: <Widget>[
                  new Image.asset(
                    'images/758.png',
                    width: 60.0,
                    height: 60.0,
                    color: Colors.white,
                  ),
                  Padding(padding: const EdgeInsets.only(top: 10.0)),
                  Text(
                    "${data['First Name']} ${data['Last Name']} \n${data['Company Name']} \n${data['Company Address']}",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
//              child: Text(
//                    "${data['First Name']} ${data['Last Name']} \n${data['Company Name']} \n${data['Company Address']}",
//                    style: TextStyle(
//                      fontSize: 16.0,
//                      fontWeight: FontWeight.w600,
//                      color: Colors.white,
//                    ),
//                  ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              margin: EdgeInsets.only(bottom: 10.0),
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text("Maps"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CustomerMap()));
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
      body: Container(
        color: Colors.deepPurple.shade100,
        child: Text("Current Location: "),
      ),
    );
    /*void showMap() {
    _mapView.show(new MapOptions(showUserLocation: true));
  }*/
  }
}
