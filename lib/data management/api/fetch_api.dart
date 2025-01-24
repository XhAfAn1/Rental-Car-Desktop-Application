import 'dart:convert';
import 'dart:io';
import 'package:car_rental_app/data%20management/all%20classes/booking.dart';
import 'package:car_rental_app/data%20management/all%20classes/hirepoint.dart';
import 'package:car_rental_app/data%20management/all%20classes/payment.dart';
import 'package:http/http.dart' as http;
import '../all classes/car_model.dart';
import '../all classes/maintainance.dart';
import '../all classes/person.dart';
import '../all classes/report.dart';
import '../all classes/review.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


class CarDetailsService {
  final String apiUrl = 'https://localhost/flutter/rental_car_api';

  Future<List<CarDetails>> fetchCarDetails() async {
    final response = await http.get(Uri.parse('$apiUrl/get_all_cars.php'));
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((car) => CarDetails.fromJson(car)).toList();
    } else {
      throw Exception('Failed to load car details');
    }
  }
  Future<List<CarDetails>> fetchAvlCarDetails() async {
    final response = await http.get(Uri.parse('$apiUrl/get_all_available_cars.php'));
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((car) => CarDetails.fromJson(car)).toList();
    } else {
      throw Exception('Failed to load car details');
    }
  }

  Future<List<Person>> fetchPersonDetails() async {
    final response = await http.get(Uri.parse('$apiUrl/get_persons.php'));
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((person) => Person.fromJson(person)).toList();
    } else {
      throw Exception('Failed to load person details');
    }
  }
  //customer
  Future<List<Person>> fetchCustomerDetails() async {
    final response = await http.get(Uri.parse('$apiUrl/get_customers.php'));
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((person) => Person.fromJson(person)).toList();
    } else {
      throw Exception('Failed to load person details');
    }
  }
  //driver
  Future<List<Person>> fetchDriverDetails() async {
    final response = await http.get(Uri.parse('$apiUrl/get_drivers.php'));
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((person) => Person.fromJson(person)).toList();
    } else {
      throw Exception('Failed to load person details');
    }
  }

  //payment
  Future<List<Payment>> fetchPaymentDetails() async {
    final response = await http.get(Uri.parse('$apiUrl/get_payments.php'));
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((payment) => Payment.fromJson(payment)).toList();
    } else {
      throw Exception('Failed to load payment details');
    }
  }

  //report
  Future<List<Report>> fetchReportDetails() async {
    final response = await http.get(Uri.parse('$apiUrl/get_reports.php'));
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((payment) => Report.fromJson(payment)).toList();
    } else {
      throw Exception('Failed to load report details');
    }
  }

  //hirepoint
  Future<List<HirePoint>> fetchHirepointDetails() async {
    final response = await http.get(Uri.parse('$apiUrl/get_hirepoints.php'));
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((hirePoint) => HirePoint.fromJson(hirePoint)).toList();
    } else {
      throw Exception('Failed to load HirePoint details');
    }
  }

  Future<List<Maintenance>> fetchMaintainDetails() async {
    final response = await http.get(Uri.parse('$apiUrl/get_maintainance.php'));
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((hirePoint) => Maintenance.fromJson(hirePoint)).toList();
    } else {
      throw Exception('Failed to load HirePoint details');
    }
  }

  Future<List<Review>> fetchReviewDetails() async {
    final response = await http.get(Uri.parse('$apiUrl/get_reviews.php'));
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((hirePoint) => Review.fromJson(hirePoint)).toList();
    } else {
      throw Exception('Failed to load HirePoint details');
    }
  }












  Future<List<Booking>> fetchAllBooling() async {
    final response = await http.get(Uri.parse('$apiUrl/get_all_booking.php'));
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((value) => Booking.fromJson(value)).toList();
    } else {
      throw Exception('Failed to load booking details');
    }
  }

  Future<List<Person>> fetchbookingbyuser() async {
    final response = await http.get(Uri.parse('$apiUrl/get_booking_by_user.php'));
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((value) => Person.fromJson(value)).toList();
    } else {
      throw Exception('Failed to load booking details');
    }
  }

  Future<List<CarDetails>> fetchpopularcar() async {
    final response = await http.get(Uri.parse('$apiUrl/get_popular_car.php'));
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((value) => CarDetails.fromJson(value)).toList();
    } else {
      throw Exception('Failed to load booking details');
    }
  }












  Future<List<CarDetails>> fetchCarDetailsByTypeAPI(String type) async {

    final response = await http.post(
      Uri.parse('$apiUrl/get_filter_cars.php'),
      body: jsonEncode({'type': type}),
    );

    print(response.body);
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((car) => CarDetails.fromJson(car)).toList();
    } else {
      throw Exception('Failed to load car details');
    }
  }


  Future getSingleCar(int carId) async {

    try {
      final response = await http.post(
        Uri.parse('$apiUrl/get_single_car.php'),
        body: jsonEncode({'carId': carId}),
      );

      if (response.statusCode == 200) {
        print(response.body);

        return jsonDecode(response.body);
      } else {
        return {'success': false, 'message': 'Server error: ${response.statusCode}'};
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }


  Future<List<String>> fetchCarType() async {
    final response = await http.get(Uri.parse('$apiUrl/get_all_type.php'));

    if (response.statusCode == 200) {
      // Decode the JSON response
      List<dynamic> jsonData = json.decode(response.body);

      // Extract the CarType values into a List<String>
      List<String> carTypes = jsonData.map<String>((item) => item['CarType'].toString()).toList();

      return carTypes;
    } else {
      throw Exception('Failed to load car details');
    }
  }






}