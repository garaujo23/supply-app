import 'package:flutter/material.dart';

class AddCustomer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddCustomerState();
  }
}

class _AddCustomerState extends State<AddCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Customer"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        alignment: Alignment.center,
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
            RaisedButton(
              onPressed: () => _cancelAdd(),
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
          ],
        ),
      ),
    );
  }

  void _cancelAdd() {
    Navigator.pop(context);
  }

}

