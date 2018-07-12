import 'package:flutter/material.dart';

class CustomerLoginScreen extends StatefulWidget {
  @override
  _CustomerLoginScreenState createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Customer Login"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
    );
  }
}
