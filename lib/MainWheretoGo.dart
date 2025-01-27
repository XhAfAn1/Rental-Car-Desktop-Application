import 'dart:async';

import 'package:car_rental_app/Pages/Login.dart';
import 'package:car_rental_app/Pages/admin/admin_home.dart';
import 'package:car_rental_app/data%20management/userData/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages/home_screen.dart';
import 'data management/api/sharedPref.dart';

const String KEYLOGINED ="loginc";

class mainlog extends StatefulWidget {
  const mainlog({super.key});

  @override
  State<mainlog> createState() => _mainlogState();
}

class _mainlogState extends State<mainlog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wheretoGo();
    getInstance();
  }
  @override
  Widget build(BuildContext context) {
    return const login();
  }

  wheretoGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isloggedin = sharedPref.getBool(KEYLOGIN);
  //  var isloggedin = false;
    Timer(const Duration(seconds: 0),(){
      if(isloggedin!=null){
        if(isloggedin){
         if(currentUser.CurrentUser?.customerId!=null)
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const home_screen(),));
         if(currentUser.CurrentUser?.driverId!=null)
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const home_screen(),));
         else if(currentUser.CurrentUser?.staffId!=null)
           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const admin_home(),));
        }
        else{

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context)=>const login(
            ),
          ));
        }
      }else{


        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context)=>const login(
          ),
        ));
      }
    }
    );
  }
}
