import 'dart:convert';

import 'package:car_rental_app/Pages/admin/admin_home.dart';
import 'package:car_rental_app/Pages/home_screen.dart';
import 'package:car_rental_app/Pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../MainWheretoGo.dart';
import '../data management/all classes/person.dart';
import '../data management/api/loginfunc.dart';
import '../data management/api/sharedPref.dart';
import '../data management/userData/currentUser.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() async {

    final username = usernameController.text;
    final password = passwordController.text;

    // Call the login API
    final authService = AuthService();
    final result = await authService.login(username, password);

    if (result['success']) {

      print('Login successful!');
        loggedin();
       Map<String,dynamic> data= await authService.getPersonData(result['data']['personid']);
      Person usr=Person.fromJson(data);
      currentUser.CurrentUser=usr;
      saveUser(usr);
      if(usr.customerId!=null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => home_screen(),));
      }
      if(usr.driverId!=null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => home_screen(),));
      }
      else if(usr.staffId!=null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => admin_home(),));
      }


    } else {
      // Show error message
      final errorMessage = result['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5850d2),
      body: Center(
        child: Container(
          height:double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/loginbg.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.1),
                BlendMode.dstATop,
              ),
            ),
          ),
          padding: EdgeInsets.all(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 100,),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black.withAlpha(10), width: 2),
                ),
                height: 600,
                width: 450,
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff5850d2),
                      ),
                    ),
                    SizedBox(height: 50,),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Color(0xff5850d2),),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xff5850d2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff5850d2),),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Color(0xff5850d2),),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xff5850d2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff5850d2),),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        _login();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff000000),
                        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18,color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Forgot password link
                    InkWell(
                      onTap: () {
                        // Navigate to password reset screen
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color(0xff000000),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t have an account? ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),InkWell(
                          onTap: () {
                            // Navigate to the Sign Up page
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xff5850d2),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                      ],
                    ),

                  ],
                ),

              )
            ],
          ),
        ),
      ),

    );
  }
}
