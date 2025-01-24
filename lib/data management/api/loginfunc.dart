import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// Custom HttpOverrides to allow bad SSL certificates for local testing
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

// AuthService for handling API interactions
class AuthService {
  static const String baseUrl = 'http://localhost/flutter/rental_car_api'; // Replace with your API base URL

  // Login function
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/get_login.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      // Debug logs
      print('Request: ${jsonEncode({'username': username, 'password': password})}');
      print('Response (${response.statusCode}): ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('success')) {
          return jsonResponse;
        } else {
          return {'success': false, 'message': 'Unexpected response format.'};
        }
      } else {
        return {'success': false, 'message': 'Server error: ${response.statusCode}'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }


  // Function to fetch person data by ID
  Future<Map<String, dynamic>> getPersonData(int personId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/get_single_user.php'),
        body: jsonEncode({'id': personId}),
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

   personCounter() async{
    final response = await http.get(Uri.parse('$baseUrl/counters/personcount.php'));
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
       List<dynamic> jsonData = json.decode(response.body);
      var a=await jsonData[0]['count'];
      return jsonData[0]['count'];
    } else {
      throw Exception('Failed to load person details');
    }
  }
  availableCarCounter() async{
    final response = await http.get(Uri.parse('$baseUrl/counters/availablecarcount.php'));
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      var a=await jsonData[0]['count'];
      print(jsonData);
      return jsonData[0]['count'];
    } else {
      throw Exception('Failed to load person details');
    }
  }

  availableRevCounter() async{
    final response = await http.get(Uri.parse('$baseUrl/counters/availablerevcount.php'));
    if (response.statusCode == 200) {
      // Parse the JSON response into a list of CarDetails objects
      List<dynamic> jsonData = json.decode(response.body);
      var a=await jsonData[0]['count'];
      print(jsonData);
      return jsonData[0]['count'];
    } else {
      throw Exception('Failed to load person details');
    }
  }
}
