import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON encoding
import 'package:http/http.dart' as http;

import '../data management/all classes/person.dart'; // For making API calls

class SignUp extends StatelessWidget {
  SignUp({super.key});

  // Controllers for each input field
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  int age=0;
  // Function to push data to the API
  Future<void> _signUp(BuildContext context) async {
    try {
      age=(int.parse((DateTime.now().difference(DateTime.parse(_dobController.text)).inDays).toString())/365).toInt() ;
      final person = Person(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        name: '${_firstNameController.text} ${_lastNameController.text}',
        username: _usernameController.text,
        password: _passwordController.text,
        dob: DateTime.tryParse(_dobController.text),
        age: age,
        phoneNumber: _phoneNumberController.text,
        email: _emailController.text,
        street: _streetController.text,
        city: _cityController.text,
        state: _stateController.text,
        zip: _zipController.text,
      );
      final response = await http.post(
        Uri.parse('https://localhost/flutter/rental_car_api/add_data/add_person.php'), // Replace with your API URL
        body: json.encode(person.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success
        print("User successfully created!");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User successfully created!')),
        );
      } else {
        // Error
        print("Failed to create user: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create user: ${response.body}')),
        );
      }
    } catch (e) {
      print("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5850d2),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(30),
                constraints: BoxConstraints(maxWidth: 900),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff5850d2),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // First Name and Last Name
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                              'First Name', Icons.person, _firstNameController, false),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildTextField(
                              'Last Name', Icons.person, _lastNameController, false),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                   Row(
                     children: [
                       // Username
                       Expanded(
                         child: _buildTextField(
                             'Username', Icons.person_outline, _usernameController, false),
                       ),
                       const SizedBox(width: 20),

                       Expanded(
                         child: _buildTextField(
                             'Password', Icons.key, _passwordController, false),
                       ),
                     ],
                   ),
                    const SizedBox(height: 20),

                    // Date of Birth
                    _buildTextField('Date of Birth (YYYY-MM-DD)', Icons.calendar_today,
                        _dobController, false),
                    const SizedBox(height: 20),

                    // Phone Number and Email
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField('Phone Number', Icons.phone,
                              _phoneNumberController, false),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildTextField(
                              'Email', Icons.email, _emailController, false),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Street and City
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                              'Street', Icons.location_on, _streetController, false),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildTextField(
                              'City', Icons.location_city, _cityController, false),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // State and ZIP Code
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                              'State', Icons.map, _stateController, false),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildTextField(
                              'ZIP Code', Icons.markunread_mailbox, _zipController, false),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Sign Up Button
                    ElevatedButton(
                      onPressed: () async{
                        _signUp(context);
                        Navigator.of(context).pop();
                      }, // Call the API function on press
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff000000),
                        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18,color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Already have an account link
                    InkWell(
                      onTap: () {
                        // Navigate back to Login page
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Already have an account? Login',
                        style: TextStyle(
                          color: Color(0xff5850d2),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to create TextFields with controllers
  Widget _buildTextField(String label, IconData icon,
      TextEditingController controller, bool obscureText) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Color(0xff5850d2),),
        prefixIcon: Icon(
          icon,
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
    );
  }
}


