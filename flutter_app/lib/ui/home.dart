import 'package:flutter/material.dart';

import '../ui/customer_login_screen.dart';
import '../ui/supplier_login_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("DDILABS"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.black,
      body: new Container(
        alignment: Alignment.topCenter,
        child: new ListView(
          padding: const EdgeInsets.all(7.0),
          children: <Widget>[
            new Padding(padding: const EdgeInsets.all(15.0)),
            new Image.asset(
              "images/758.png",
              height: 133.0,
              width: 200.0,
              color: Colors.white,
            ),
            new Container(
              //height: 250.0,
              //color: Colors.grey,
              child: new Column(
                children: <Widget>[
                  new Padding(padding: const EdgeInsets.all(30.0)),
                  new Text(
                    "LOGIN",
                    style: new TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  new Padding(padding: const EdgeInsets.all(14.0)),
                  new InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerLoginScreen()));
                    },
                    child: new Container(
                      height: 50.0,
                      width: 300.0,
                      color: Colors.blueGrey.shade600,
                      child: new Center(
                        child: new Text(
                          "CUSTOMER",
                          style: new TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  new Padding(padding: const EdgeInsets.all(14.0)),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "--------------------------------",
                        style: new TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.all(5.0)),
                      new Text(
                        "OR",
                        style: new TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.all(5.0)),
                      new Text(
                        "--------------------------------",
                        style: new TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  new Padding(padding: const EdgeInsets.all(14.0)),
                  new InkWell(
                    onTap:  () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SupplierLoginScreen()));
                    },
                    child: new Container(
                      height: 50.0,
                      width: 300.0,
                      color: Colors.blueGrey.shade600,
                      child: new Center(
                        child: new Text(
                          "SUPPLIER",
                          style: new TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
