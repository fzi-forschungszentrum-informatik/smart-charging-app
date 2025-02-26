
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './app.dart';



/// main entry point for flutter app
void main() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    runApp(App(prefs));
}
