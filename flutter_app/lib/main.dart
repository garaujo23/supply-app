import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import './ui/home.dart';
import './ui/login_screen.dart';
import './ui/create_account_screen.dart';
import './ui/customer_home_screen.dart';
import './ui/supplier_home_screen.dart';
import './ui/add_customer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/rendering.dart.';

FirebaseUser currentUser;

const API_KEY = "";

void main() {

  MapView.setApiKey(API_KEY);
  //Use for debugging UI
  //debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  //MapView.setApiKey(API_KEY);
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    //UI Settings for whole app
    theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.blueGrey,
        accentColor: Colors.deepPurple,
        buttonColor: Colors.blueGrey,
        //scaffoldBackgroundColor: Colors.black
    ),
    title: "ddilabs",
    home: Home(),
    routes: {
      '/customerHome': (_) => CustomerHome(),
      '/home': (_) => Home(),
      '/supplierHome': (_) => SupplierHome(),
      '/addCustomer': (_) => AddCustomer(),
  },
  ));
}
