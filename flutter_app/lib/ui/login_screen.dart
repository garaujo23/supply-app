import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  var type;

  LoginScreen({this.type});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<User> userAccounts = List();
  User user;
  final FirebaseDatabase database = FirebaseDatabase.instance;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final snackBar = new SnackBar(content: Text("Processing Data"));

  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  void _erase() {
    setState(() {
      _nameController.clear();
      _passwordController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("${widget.type.toString()} Login"),
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
                    controller: _nameController,
                    decoration: new InputDecoration(
                        hintText: "${widget.type.toString()} ID",
                        icon: new Icon(Icons.person)),
                  ),
                  new TextField(
                    controller: _passwordController,
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
//                            onPressed: () => debugPrint ("Login Pressed"),
                            onPressed: () {
                              //_scaffoldKey.currentState.showSnackBar(snackBar);
                              _logInUser();
                            },
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

  _logInUser() async {
    if (_nameController.text == "" || _passwordController.text == "") {
      _errorDialog("Username/password cannot be blank");
    } else {
      _auth
          .signInWithEmailAndPassword(
          email: _nameController.text, password: _passwordController.text)
          .catchError((error) {

      });
      _auth.currentUser().then((currentUser) {
        checkUserType(currentUser);
      });
    }
  }

  void checkUserType(FirebaseUser currentUser) {
    //Gets the database values of the user signing in ONCE only
    database
        .reference()
        .child("Users")
        .child(currentUser.uid)
        .once()
        .then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> data = snapshot.value;
// Checking to see if the user type is the same as the login type the user selected
      if (snapshot.value['User Type'] == widget.type.toString()) {
        if (widget.type.toString() == "Customer") {
          // creating a new route so user cannot go back but instead will have to log out
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/customerHome', (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/supplierHome', (Route<dynamic> route) => false);
        }
      } else {
        _errorDialog("Invalid Username/password");
        _nameController.clear();
        _passwordController.clear();
      }
    });
  }

  void _errorDialog(String error) {
    String title = "";
    String message = "";

    if (error == "Username/password cannot be blank") {
      title = "ERROR!";
      message =
      "Username or Password cannot be blank!";
    } else if (error == "Invalid Username/password") {
      title = "ERROR!";
      message = "Invalid username or password!";
    }

    var alert = AlertDialog(
      content: Container(
        height: 120.0,
        width: 305.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            new Padding(padding: const EdgeInsets.all(6.0)),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            FlatButton(
              color: Colors.blueGrey,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Ok",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }
}
