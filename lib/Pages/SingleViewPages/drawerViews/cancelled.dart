import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../data management/all classes/booking.dart';
import '../../../data management/userData/currentUser.dart';

class cancellist extends StatefulWidget {
  const cancellist({super.key});

  @override
  State<cancellist> createState() => _cancellistState();
}

class _cancellistState extends State<cancellist> {
  @override
  late Future<List<Booking>> cancelFuture;

  Future<List<Booking>> fetchDetails() async {
    try {
      // API endpoint for fetching canceled bookings
      final uri = Uri.parse('https://localhost/flutter/rental_car_api/get_single_cancelled.php');

      // HTTP POST request with JSON-encoded body
      final response = await http.post(
        uri,
        body: jsonEncode({'PersonID': currentUser.CurrentUser?.personId}),
      );

      // Log the response body for debugging
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Parse the JSON response into a list of Booking objects
        List<dynamic> jsonData = json.decode(response.body);

        return jsonData.map((json) => Booking.fromJson(json)).toList();
      } else {
        // Handle server error responses
        throw Exception('Failed to load booking details: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any exceptions that occur during the request
      print('Error fetching booking details: $error');
      throw Exception('Failed to fetch booking details');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cancelFuture = fetchDetails();
    print(cancelFuture);
  }
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back)),
          title: Text("My Cancelled Bookings",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
          centerTitle: true,
        ),
        body: FutureBuilder<List<Booking>>(
          future: cancelFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final carDetails = snapshot.data!;
              return ListView.builder(
                itemCount: carDetails.length,
                itemBuilder: (context, index) {
                  final car = carDetails[index];
                  return Container(

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black.withAlpha(40), width: 2),
                    ),
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),

                    height: 200,
                    width:double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.circular(10),
                                // border: Border.all(color: Colors.black.withAlpha(10), width: 2),
                                  image:   car.photo!=null || car.photo!=''? DecorationImage(image: NetworkImage(car.photo!)): DecorationImage(image: AssetImage('assets/logo.png'))
                              ),
                              margin: EdgeInsets.all(10),
                              width: 200,

                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.only(left:10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //    Text("Car ID: ${car.carId}",style: TextStyle(fontSize: 20),),
                                  Text("${car.modelName}",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                                  SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text('Year: ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                              Text('${car.year}  ',style: TextStyle(fontSize: 20,),),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('Type: ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                              Text('${car.carType} ',style: TextStyle(fontSize: 20,),),
                                            ],
                                          ),

                                        ],
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text('Brand: ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                              Text('${car.manufacturer} ',style: TextStyle(fontSize: 20,),),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),


                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text("Cancelled Date: ${car.pickupDate?.year} - ${car.pickupDate?.month} - ${car.pickupDate?.day}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color(
                                    0xffd25050)),),

                              ],
                            ),
                            SizedBox(
                              width: 80,
                            ),
                            Text("${car.amount?.toInt()}৳",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Color(0xff5850d2)),),
                            Text("/day",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                            SizedBox(width: 40,)
                          ],
                        )
                      ],
                    ),

                  );
                },
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        )
    );
  }


}
