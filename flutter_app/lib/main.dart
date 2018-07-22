import 'package:flutter/material.dart';
import './ui/home.dart';
import './ui/login_screen.dart';
import './ui/create_account_screen.dart';
import './ui/customer_home_screen.dart';
import './ui/supplier_home_screen.dart';

void main() {
  runApp(new MaterialApp(
    title: "ddilabs",
    home: Home(),
    routes: {
      '/customerHome': (_) => CustomerHome(),
      '/home': (_) => Home(),
      '/supplierHome': (_) => SupplierHome(),
    } ,
  ));
}

