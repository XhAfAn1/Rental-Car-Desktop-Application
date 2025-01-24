import 'dart:convert';
import 'package:car_rental_app/Pages/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class payment_page extends StatefulWidget {
  final bookingID;
  final paymentDate;
  final endDate;

  const payment_page({super.key, this.bookingID, this.paymentDate, this.endDate});

  @override
  State<payment_page> createState() => _payment_pageState();
}

class _payment_pageState extends State<payment_page> {
  @override
  int cost=0;
  String pstatus='canceled';
  int avlid=1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    total_amount();
  }
  // Controllers for each input field
  final TextEditingController _paymentTypeController = TextEditingController();


  Future<void> _payment() async {

      const String apiUrl = 'http://localhost/flutter/rental_car_api/add_data/add_payment.php';

      // Construct booking data
      Map<String, dynamic> paymentData = {
        'booking_id': widget.bookingID,
        'payment_type': _paymentTypeController.text,
        'payment_date': widget.paymentDate,
        'payment_amount': cost
      };

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          body: jsonEncode(paymentData),
        );
        print(response.body);
        // Check response status
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          if (responseData['success'] == true) {
            print(responseData);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment successful!')),
            );


            Navigator.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to add payment: ${responseData['error']}')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to communicate with the server.')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $error')),
        );
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade100,
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
                      "Make Payment",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent.shade700,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Total Payable Amount",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent.shade700,
                      ),
                    ),
                    Text(
                      "$cost\৳",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent.shade700,
                      ),
                    ),






                    const SizedBox(height: 20),

                    // Date of Birth
                    _buildTextField('Enter Payment Type', Icons.payment,
                        _paymentTypeController, false),
                    const SizedBox(height: 20),


                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                     children: [
                       ElevatedButton(
                         onPressed: () async{
                           _payment();
                           pstatus='onGoing';
                           payment_status(pstatus,avlid=2);

                           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => home_screen(),));
                         }, // Call the API function on press
                         style: ElevatedButton.styleFrom(
                           backgroundColor: Colors.blueAccent.shade700,
                           padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(20),
                           ),
                         ),
                         child: Text(
                           'Confirm',
                           style: TextStyle(fontSize: 18,color: Colors.white),
                         ),
                       ),
                       ElevatedButton(
                         onPressed: () async{

                           pstatus='cancelled';
                           avlid=1;
                           payment_status(pstatus,avlid);

                           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => home_screen(),));
                         }, // Call the API function on press
                         style: ElevatedButton.styleFrom(
                           backgroundColor: Colors.blueAccent.shade700,
                           padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(20),
                           ),
                         ),
                         child: Text(
                           'Cancel',
                           style: TextStyle(fontSize: 18,color: Colors.white),
                         ),
                       ),
                     ],
                   ),

                    const SizedBox(height: 20),

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
        labelStyle: TextStyle(color: Colors.blueAccent.shade700),
        prefixIcon: Icon(
          icon,
          color: Colors.blueAccent.shade700,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent.shade700),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
  Future<void> total_amount() async {
    const String apiUrl = 'http://localhost/flutter/rental_car_api/get_payment_cost.php';

    try {
      print(widget.bookingID);
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'booking_id': widget.bookingID}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['success'] == true) {
          int totalCost = responseData['total_cost'];
          print('Total cost: $totalCost');
          cost=totalCost;
        } else {
          print('Error: ${responseData['error']}');
        }
      } else {
        print('Server returned status: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
    setState(() {
      
    });
  }
  Future<void> payment_status(String sts,int avid) async {
    const String apiUrl = 'http://localhost/flutter/rental_car_api/update_data/update_payment_status.php';

    try {
      // Prepare the data to send
      Map<String, dynamic> requestData = {
        'booking_id': widget.bookingID,
        'car_availability': avid, // Assuming '2' indicates availability status
        'status': sts // Assuming 'complete' indicates payment status
      };

      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );

      // Debugging: Print request and response
      print('Request data: $requestData');
      print('Response: ${response.body}');

      // Check the server response
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['success'] == true) {
          // Handle successful update
          print('Payment status updated successfully.');
        } else {
          // Handle back-end error
          print('Error from server: ${responseData['error']}');
        }
      } else {
        // Handle unexpected status codes
        print('Server returned status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions
      print('An error occurred: $e');
    }
  }




}
