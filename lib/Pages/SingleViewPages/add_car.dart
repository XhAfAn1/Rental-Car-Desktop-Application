import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCarPage extends StatefulWidget {
  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController registrationNumberController = TextEditingController();
  final TextEditingController carTypeController = TextEditingController();
  final TextEditingController modelNameController = TextEditingController();
  final TextEditingController manufacturerController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController availableStatusController = TextEditingController();
  final TextEditingController availableDateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController photoController = TextEditingController();

  Future<void> submitCarDetails() async {
    const String apiUrl = 'https://localhost/flutter/rental_car_api/add_data/add_car.php';

    Map<String, dynamic> carData = {
      "registrationNumber": registrationNumberController.text,
      "carType": carTypeController.text,
      "modelName": modelNameController.text,
      "manufacturer": manufacturerController.text,
      "year": yearController.text,
      "availableStatus": availableStatusController.text,
      "availableDate": availableDateController.text,
      "amount": amountController.text,
    };

    try {
      print(carData);
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(carData),
      );

      if (response.statusCode == 200) {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Car details added successfully!')),
        );
        _formKey.currentState?.reset();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add car details.')),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add Car'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Car Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 16),
              buildTextField(
                controller: registrationNumberController,
                labelText: 'Registration Number',
                hintText: 'Enter the registration number',
              ),
              buildTextField(
                controller: carTypeController,
                labelText: 'Car Type',
                hintText: 'Enter the car type (e.g., SUV, Sedan)',
              ),
              buildTextField(
                controller: modelNameController,
                labelText: 'Model Name',
                hintText: 'Enter the model name',
              ),
              buildTextField(
                controller: manufacturerController,
                labelText: 'Manufacturer',
                hintText: 'Enter the manufacturer',
              ),
              buildTextField(
                controller: yearController,
                labelText: 'Year',
                hintText: 'Enter the model year (e.g., 2023)',
                keyboardType: TextInputType.number,
              ),
              buildTextField(
                controller: availableStatusController,
                labelText: 'AvailabilityID (1.Available 2.Unavailable 3.In Maintainance)',
                hintText: 'Enter the AvailabilityID',
              ),

              buildTextField(
                controller: amountController,
                labelText: 'CostID (1,2,3,4,5)',
                hintText: 'Enter the cost ID',
                keyboardType: TextInputType.number,
              ),
              buildTextField(
                controller: photoController,
                labelText: 'Photo Link',
                hintText: 'Enter the photo Link',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      submitCarDetails();
                    }
                  },
                  child: Text('Add Car',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    textStyle: TextStyle(fontSize: 25),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }
}
