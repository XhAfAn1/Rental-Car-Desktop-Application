import 'dart:io';
import 'package:car_rental_app/MainWheretoGo.dart';
import 'package:car_rental_app/data%20management/api/sharedPref.dart';
import 'package:flutter/material.dart';
import 'Pages/Login.dart';
import 'Pages/home_screen.dart';
import 'data management/api/fetch_api.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  mainlog(),

     //home:home_screen()
    // home:login()
      //home: admin_home(),
    );
  }

}
