import 'package:flutter/material.dart';
import './ui/home.dart';
import './ui/login_screen.dart';
import './ui/create_account_screen.dart';

void main() {
  runApp(new MaterialApp(
    title: "ddilabs",
    home: Home(),
    routes: {
    //  "/Home": (_) => new Home(),
    },
  ));
}

