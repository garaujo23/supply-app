
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import '../ui/login_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  List<User> userAccounts = List();
  User user;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final snackBar = new SnackBar(content: Text("Creating user account"));
  DatabaseReference databaseReference;
  int radioValue = 0;

  @override
  void initState() {
    super.initState();

    user = User("", "", "", "", "","");
    databaseReference = database.reference().child("Users");
  }

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;

      switch (radioValue) {
        case 0:
          break;
        case 1:
          user.userType = "Customer";
          break;
        case 2:
          user.userType = "Supplier";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Create Account"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          children: <Widget>[
            new Padding(padding: const EdgeInsets.all(6.0)),
            //image/profile
            new Image.asset(
              'images/face.png',
              width: 90.0,
              height: 90.0,
              color: Colors.black,
            ),
            //Form
            new Padding(padding: const EdgeInsets.all(6.0)),
            Center(
              child: Form(
                key: formKey,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.person),
                      title: TextFormField(
                        autofocus: true,
                        initialValue: "",
                        onSaved: (val) => user.firstName = val,
                        validator: (val) =>
                            val == "" ? 'first name required' : null,
                        decoration: InputDecoration(labelText: "First Name *"),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: TextFormField(
                        initialValue: "",
                        onSaved: (val) => user.lastName = val,
                        validator: (val) =>
                            val == "" ? 'Last name required' : null,
                        decoration: InputDecoration(labelText: "Last Name *"),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.work),
                      title: TextFormField(
                        initialValue: "",
                        onSaved: (val) => user.companyName = val,
                        validator: (val) =>
                            val == "" ? 'Company name required' : null,
                        decoration: InputDecoration(labelText: "Company Name *"),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                new Radio(
                                  activeColor: Colors.blueGrey,
                                  value: 1,
                                  groupValue: radioValue,
                                  onChanged: handleRadioValueChanged,
                                ),
                                new Text(
                                  "Customer",
                                  style: new TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                new Radio<int>(
                                    activeColor: Colors.blueGrey,
                                    value: 2,
                                    groupValue: radioValue,
                                    onChanged: handleRadioValueChanged),
                                new Text(
                                  "Supplier",
                                  style: new TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        initialValue: "",
                        onSaved: (val) => user.emailAddress = val,
                        validator: (val) =>
                            val == "" ? 'Email address required' : null,
                        decoration:
                            InputDecoration(labelText: "Email Address *"),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.lock),
                      title: TextFormField(
                        initialValue: "",
                        onSaved: (val) => user.password = val,
                        validator: (val) => val.length < 8
                            ? 'password needs to be 8 characters long'
                            : null,
                        decoration: InputDecoration(labelText: "Password *"),
                        obscureText: true,
                      ),
                    ),
                    new Padding(padding: new EdgeInsets.all(10.5)),
                    new Center(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          //Login Button
                          RaisedButton(
                            onPressed: () => _cancelCreate(),
                            color: Colors.redAccent,
                            child: new Text(
                              "Cancel",
                              style: new TextStyle(
                                fontSize: 16.9,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              _createUser();
                              _scaffoldKey.currentState.showSnackBar(snackBar);
                            },
                            // When create is pressed this function is called
                            color: Colors.blueGrey,
                            child: new Text(
                              "Create",
                              style: new TextStyle(
                                fontSize: 16.9,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _cancelCreate() {
    Navigator.pop(context);
  }

  // Creating the account and authenticating the user
  void _createUser() async {
    final FormState form = formKey.currentState;
    // checks if all fields in the form is entered correctly
    if (form.validate() && radioValue > 0) {
      form.save(); // saves the form
      //Authenticates the user and checks that the email address has not been used before. If authentication is ok, writes information to the database
      FirebaseUser userAccount = await _auth
          .createUserWithEmailAndPassword(
              email: "${user.emailAddress}", password: "${user.password}")
          .catchError((error) {
        // if email is already used to create account, displays error message
        _errorDialog("Email Taken");
      });

      //makes the authId the database ID and stores info into database
      userAccount.sendEmailVerification();
      //userAccount.sendEmailVerification();
      databaseReference.child("${userAccount.uid}").set(user.toJson());
      //databaseReference.push().set(user.toJson());
      form.reset(); //resets the form
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(type: user.userType)));
    } else {
      _errorDialog("User Type");
    }
  }

  void _errorDialog(String error) {
    String title = "";
    String message = "";

    if (error == "Email Taken") {
      title = "ERROR!";
      message =
          "Email address already in Use. Please choose a different email address!";
    } else if (error == "User Type") {
      title = "User type error!";
      message = "Please select if customer or supplier";
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
