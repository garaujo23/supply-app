import 'package:flutter/material.dart';

class SupplierLoginScreen extends StatefulWidget {
  @override
  _SupplierLoginScreenState createState() => _SupplierLoginScreenState();
}

class _SupplierLoginScreenState extends State<SupplierLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Supplier Login"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
    );
  }
}
