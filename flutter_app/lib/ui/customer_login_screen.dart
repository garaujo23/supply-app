import 'package:flutter/material.dart';

class CustomerLoginScreen extends StatefulWidget {
  @override
  _CustomerLoginScreenState createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  final TextEditingController _customerNameController =
  new TextEditingController();
  final TextEditingController _customerPasswordController =
  new TextEditingController();

  void _erase() {
    setState(() {
      _customerNameController.clear();
      _customerPasswordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Customer Login"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: new Container(
        alignment: Alignment.topCenter,
        child: new ListView(
          children: <Widget>[
            new Padding(padding: const EdgeInsets.all(15.0)),
            //image/profile
            new Image.asset(
              'images/face.png',
              width: 90.0,
              height: 90.0,
              color: Colors.white,
            ),
            //Form
            new Padding(padding: const EdgeInsets.all(20.0)),
            new Container(
              height: 180.0,
              width: 380.0,
              color: Colors.blueGrey.shade50,
              child: new Column(
                children: <Widget>[
                  new Padding(padding: const EdgeInsets.all(4.0)),
                  new TextField(
                    controller: _customerNameController,
                    decoration: new InputDecoration(
                        hintText: "Customer ID", icon: new Icon(Icons.person)),
                  ),
                  new TextField(
                    controller: _customerPasswordController,
                    decoration: new InputDecoration(
                      hintText: "Password",
                      icon: new Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  // Add space between password line and login button
                  new Padding(padding: new EdgeInsets.all(10.5)),

                  new Center(
                    child: new Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //Login Button
                        new Container(
                          margin: const EdgeInsets.only(left: 40.0),
                          child: new RaisedButton(
                            onPressed: () => debugPrint ("Login Pressed"),
                            color: Colors.blueGrey,
                            child: new Text(
                              "Login",
                              style: new TextStyle(
                                fontSize: 16.9,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        //Clear Button
                        new Container(
                          margin: const EdgeInsets.only(left: 120.0),
                          child: new RaisedButton(
                            onPressed: _erase,
                            color: Colors.blueGrey,
                            child: new Text(
                              "Clear",
                              style: new TextStyle(
                                fontSize: 16.9,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}
