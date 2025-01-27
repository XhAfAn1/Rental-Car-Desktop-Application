import 'package:flutter/material.dart';
import 'package:car_rental_app/data management/userData/currentUser.dart';

class user_page extends StatefulWidget {
  const user_page({super.key});

  @override
  State<user_page> createState() => _user_pageState();
}

class _user_pageState extends State<user_page> {
  List<Map<String, dynamic>> userData = [];

  String userType(){
    if(currentUser.CurrentUser?.customerId !=null){
      return "Customer";
    }else if(currentUser.CurrentUser?.driverId !=null){
      return "Driver";
    }else{
      return "Administrator";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: (){
              Navigator.of(context).pop();
            }, icon: Icon(Icons.arrow_back_ios_new)),
            Text(
              'My Profile',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6C63FF),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Profile Picture and Name
                      Row(

                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Color(0xFF5EBDB4),
                            child: Icon(Icons.person)
                          ),
                          SizedBox(width: 16),
                          Text(
                            '${currentUser.CurrentUser?.name}',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      // Personal Information Section
                      Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xFF6C63FF),
                          fontWeight: FontWeight.w500,
                        ),
                      ), Divider(
                        color: Colors.grey,
                        thickness: 1,
                        endIndent: 300,
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoField('First Name', '${currentUser.CurrentUser?.firstName}'),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _buildInfoField('Last Name', '${currentUser.CurrentUser?.lastName}'),
                          ),


                                (currentUser.CurrentUser?.drivingLicenseNumber!=null)?_buildInfoField('Driving Licence', '${currentUser.CurrentUser?.drivingLicenseNumber}'):Container(),
                                (currentUser.CurrentUser?.staffRole!=null)?_buildInfoField('Staff Role', 'Admin'):Container(),




                              (currentUser.CurrentUser?.membership!=null && currentUser.CurrentUser?.membership!='')?_buildInfoField('Membership Status', '${currentUser.CurrentUser?.membership}'):Container(),
                          SizedBox(width: 550),

                        ],
                      ),
                      Row(
                       // mainAxisAlignment: MainAxisAlignment.start,
                       // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildInfoField('Email', '${currentUser.CurrentUser?.email}'),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              children: [
                            
                                  _buildInfoField('Phone', '${currentUser.CurrentUser?.phoneNumber}'),
                            
                            
                              //  (currentUser.CurrentUser?.phoneNumber2!=null)?_buildInfoField('Phone 2', '${currentUser.CurrentUser?.phoneNumber2}'):Container()
                            
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 100),

                      // Address Section
                      Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xFF6C63FF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                        endIndent: 300,
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildInfoField('State', '${currentUser.CurrentUser?.state}'),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _buildInfoField('City', '${currentUser.CurrentUser?.city}'),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _buildInfoField('Code', '${currentUser.CurrentUser?.zip}'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 25,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}


