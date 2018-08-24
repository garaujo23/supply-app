import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './add_customer.dart';
import '../ui/login_screen.dart';

String uID = userUid;

class SupplierHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Customer Orders"),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(
                  "${data['First Name']} ${data['Last Name']} \n ${data['Company Name']} \n ${data['Company Address']}",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                margin: EdgeInsets.only(bottom: 10.0),
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text("Orders"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
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
        body: Center(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Customer A',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
                subtitle: Text('85 W Portal Ave, Sydney NSW 2036'),
                leading: Icon(
                  Icons.account_balance,
                  //color: Colors.blue[500],
                ),
              ),
              new GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '');
                },
                child: ListTile(
                  title: Text('Customer B',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0)),
                  subtitle: Text('85 W Portal Ave, Sydney NSW 2036'),
                  leading: Icon(
                    Icons.beach_access,
                  ),
                ),
              ),
              ListTile(
                title: Text('Customer B',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
                subtitle: Text('85 W Portal Ave, Sydney NSW 2036'),
                leading: Icon(
                  Icons.beach_access,
                ),
              ),
              ListTile(
                title: Text('Customer C',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
                subtitle: Text('85 W Portal Ave'),
                leading: Icon(
                  Icons.cake,
                ),
              ),
            ],
          ),
          //color: Colors.deepOrange.shade100,
        ),
        floatingActionButton: new FloatingActionButton(
            elevation: 0.0,
            child: new Icon(Icons.add),
            backgroundColor: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (context) => new AddCustomer()),
                  );
              //Navigator.pushReplacementNamed(context, '/addCustomer');
            }));
  }
}
