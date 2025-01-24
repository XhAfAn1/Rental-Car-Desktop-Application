import 'dart:convert';

import 'package:car_rental_app/data%20management/all%20classes/booking.dart';
import 'package:car_rental_app/data%20management/userData/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class onGoing extends StatefulWidget {
  const onGoing({super.key});

  @override
  State<onGoing> createState() => _onGoingState();
}

class _onGoingState extends State<onGoing> {
  late Future<List<Booking>> DetailsFuture;

  Future<List<Booking>> fetchDetails() async{

      // Map<String, dynamic> carData = {
      //   "registrationNumber": registrationNumberController.text,
      //   "carType": carTypeController.text,
      //   "modelName": modelNameController.text,
      //   "manufacturer": manufacturerController.text,
      //   "year": yearController.text,
      //   "amount": amountController.text,
      // };

      final response = await http.post(
        Uri.parse('https://localhost/flutter/rental_car_api/get_ongoing.php'),
        body: jsonEncode({'PersonID': currentUser.CurrentUser?.personId}),
      );

      print(response.body);
      if (response.statusCode == 200) {
        // Parse the JSON response into a list of CarDetails objects
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((car) => Booking.fromJson(car)).toList();
      } else {
        throw Exception('Failed to load car details');
      }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DetailsFuture = fetchDetails();
    print(DetailsFuture);
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
        title: Text("onGoing Booking",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Booking>>(
        future: DetailsFuture,
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
                              ElevatedButton(
                                onPressed: () {
                                },
                                child: Text('Report',style: TextStyle(color: Colors.white),),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                  textStyle: TextStyle(fontSize: 25),
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                },
                                child: Text('Review',style: TextStyle(color: Colors.white),),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                  textStyle: TextStyle(fontSize: 25),
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 30,
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

