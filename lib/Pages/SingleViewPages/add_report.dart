import 'package:flutter/material.dart';

class add_report extends StatefulWidget {
  const add_report({super.key});

  @override
  State<add_report> createState() => _add_reportState();
}

class _add_reportState extends State<add_report> {

  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(
    text:  DateTime.now().year.toString()+'-'+DateTime.now().month.toString()+'-'+DateTime.now().day.toString(),
  );

  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xffffffff),
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
                      "Raise an Issue",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff5850d2),
                      ),
                    ),

                    const SizedBox(height: 40),
                    // Date of Birth
                    _buildTextField('Report about', Icons.report,
                        _dobController, false),
                    const SizedBox(height: 20),
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Color(0xff5850d2),),


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


                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField('Car ID', Icons.car_rental_outlined,
                              _phoneNumberController, false),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildTextField(
                              'Driver ID', Icons.person_pin,_phoneNumberController , false),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    // Phone Number and Email
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField('Remark', Icons.add_box_rounded,
                              _phoneNumberController, false),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildTextField(
                              'Review Date', Icons.calendar_today, _emailController, false),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),




                    const SizedBox(height: 20),

                    // Sign Up Button
                    ElevatedButton(
                      onPressed: () async{
                        // _signUp(context);
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
                        'Add Review',
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
                        '',
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
