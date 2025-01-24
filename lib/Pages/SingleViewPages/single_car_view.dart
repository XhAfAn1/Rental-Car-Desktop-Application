import 'dart:convert';
import 'package:car_rental_app/Pages/SingleViewPages/payment_page.dart';
import 'package:http/http.dart' as http;
import 'package:car_rental_app/data%20management/userData/currentUser.dart';
import 'package:flutter/material.dart';

import '../../data management/all classes/car_model.dart';
import '../../data management/api/fetch_api.dart';

class single_car_view extends StatefulWidget {
  final carId; // Added type for better readability
  const single_car_view({super.key, required this.carId});

  @override
  State<single_car_view> createState() => _SingleCarViewState();
}

class _SingleCarViewState extends State<single_car_view> {
  CarDetails? carDetails;
  bool isLoading = true;
  int bookingID  = 0;

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers for booking fields
  final TextEditingController _pickupDateController = TextEditingController(
    text:  DateTime.now().year.toString()+'-'+DateTime.now().month.toString()+'-'+DateTime.now().day.toString(),
  );
  final TextEditingController _dropDateController = TextEditingController();
  final TextEditingController _pointIdController = TextEditingController();
  final TextEditingController _driverIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCarDetails();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Color(0xff5850d2),
          strokeWidth: 5,
        ),
      )
          : carDetails != null
          ? Row(
        children: [
          // Left Sidebar
          Expanded(
            flex: 1,
            child: Container(
              color: Color(0xff5850d2),
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 30),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    carDetails!.manufacturer!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    carDetails!.modelName!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    carDetails!.manufacturer!,
                    style:
                    TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Divider(
                    endIndent: 60,
                    thickness: 2,
                    color: Colors.white,
                  ),
                  Text(
                    carDetails!.year!,
                    style:
                    TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Divider(
                    endIndent: 60,
                    thickness: 2,
                    color: Colors.white,
                  ),
                  Text(
                    carDetails!.carType!,
                    style:
                    TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Divider(
                    endIndent: 60,
                    thickness: 2,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "Rent Details: ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      Text(
                        '৳ ${carDetails!.amount?.toInt()}',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Text(
                        '/day',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Booking Form Section
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Book This Car",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xff5850d2),
                            fontSize: 40),
                      ),
                      const SizedBox(height: 20),

                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _pickupDateController,
                        decoration: InputDecoration(
                          labelText: "Pickup Date (YYYY-MM-DD)",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            _pickupDateController.text=DateTime.now().toString();
                            return null;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _dropDateController,
                        decoration: InputDecoration(
                          labelText: "Drop Date (YYYY-MM-DD)",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Drop Date';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _pointIdController,
                        decoration: InputDecoration(
                          labelText: "Hire Point ID (1 , 2 , 3)",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Hire Point ID';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _driverIdController,
                        decoration: InputDecoration(
                          labelText: "Driver ID (optional)",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submitBooking();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff5850d2),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Confirm Booking",
                            style: TextStyle(
                              color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Right Image Section
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(carDetails!.photo!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(child: Text("Review Area")),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
          : Center(
        child: Text(
          "Failed to load car details.",
          style: TextStyle(fontSize: 18, color: Colors.red[600]),
        ),
      ),
    );
  }

  Future<void> fetchCarDetails() async {
    try {
      Map<String, dynamic> data =
      await CarDetailsService().getSingleCar(widget.carId);
      CarDetails fetchedCar = CarDetails.fromJson(data);
      setState(() {
        carDetails = fetchedCar;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching car details: $e");
      setState(() {
        isLoading = false;
      });
    }
  }


  Future<void> _submitBooking() async {
    if (_formKey.currentState!.validate()) {
      const String apiUrl = 'http://localhost/flutter/rental_car_api/add_data/add_booking.php';

      // Construct booking data
      Map<String, dynamic> bookingData = {
        'status': 'pending',
        'pickup_date': _pickupDateController.text.trim(),
        'drop_date': _dropDateController.text.trim(),
        'car_id': widget.carId,
        'point_id': int.tryParse(_pointIdController.text.trim()),
        'person_id': currentUser.CurrentUser?.personId,
        'driver_id': _driverIdController.text.isNotEmpty
            ? int.tryParse(_driverIdController.text.trim())
            : null,
      };

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          body: jsonEncode(bookingData),
        );
        print(response.body);
        // Check response status
        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          if (responseData['success'] == true) {

            bookingID=responseData['booking_id'];
            print(bookingID);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Booking added successfully!')),
            );
            _formKey.currentState?.reset();

            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => payment_page(bookingID: bookingID,paymentDate:_pickupDateController.text,endDate: _dropDateController.text,),));// Reset form after successful submission
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to add booking: ${responseData['error']}')),
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
  }
}